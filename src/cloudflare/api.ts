import {
  CloudflareDirectUploadDTOSchema,
  CloudflareDirectUploadParameters,
} from "@/cloudflare/dto/direct_upload";
import { CloudflareImageDTOSchema } from "@/cloudflare/dto/image";
import { CloudflareResultDTOSchema } from "@/cloudflare/dto/result";
import env, { DEV_UNSET } from "@/env";
import logger from "@/logger";
import wretch, { FetchLike } from "wretch";
import FormDataAddon from "wretch/addons/formData";

const api = wretch("https://api.cloudflare.com/client/v4/") //
  .addon(FormDataAddon)
  .middlewares([
    (next: FetchLike): FetchLike =>
      async (url, opts) => {
        if (
          [
            env.CLOUDFLARE_ACCOUNT_ID,
            env.CLOUDFLARE_ACCOUNT_HASH,
            env.CLOUDFLARE_API_TOKEN,
          ].includes(DEV_UNSET)
        ) {
          throw new Error(
            "Missing envvars for Cloudflare credentials. " +
              "The Cloudflare API cannot be used."
          );
        }
        return next(url, opts);
      },
    // Logging middleware for debugging
    (next: FetchLike): FetchLike =>
      async (url, opts) => {
        logger.debug(
          {
            req: {
              url,
            },
          },
          "Calling Cloudflare API"
        );
        return next(url, opts);
      },
  ])
  .auth(`Bearer ${env.CLOUDFLARE_API_TOKEN}`);

export const cloudflareApi = {
  images: {
    createImageUploadUrl: (params: CloudflareDirectUploadParameters) => {
      return api
        .url(`accounts/${env.CLOUDFLARE_ACCOUNT_ID}/images/v2/direct_upload`)
        .formData({
          ...params,
          metadata: JSON.stringify(params.metadata),
        })
        .resolve(
          async (r) =>
            await CloudflareDirectUploadDTOSchema.parseAsync(await r.json())
        )
        .post();
    },

    isUploaded: (cloudflareImageId: string): Promise<boolean> => {
      return api
        .url(
          `accounts/${env.CLOUDFLARE_ACCOUNT_ID}/images/v1/${cloudflareImageId}`
        )
        .resolve((r) =>
          r
            .notFound(() => false)
            .json(
              async (r) =>
                !(await CloudflareImageDTOSchema.parseAsync(r)).result.draft
            )
        )
        .get();
    },

    delete: (cloudflareImageId: string) => {
      return api
        .url(
          `accounts/${env.CLOUDFLARE_ACCOUNT_ID}/images/v1/${cloudflareImageId}`
        )
        .resolve(
          async (r) =>
            await CloudflareResultDTOSchema.parseAsync(await r.json())
        )
        .delete();
    },
  },
};
