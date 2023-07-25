import { MetadataDTOSchema } from "@/api/dto/metadata";
import { CloudflareResultDTOSchema } from "@/cloudflare/dto/result";
import { z } from "zod";

export type CloudflareDirectUploadParameters = z.infer<
  typeof CloudflareDirectUploadParametersSchema
>;
export const CloudflareDirectUploadParametersSchema = z.object({
  expiry: z.optional(z.date()),
  metadata: MetadataDTOSchema,
  requireSignedURLs: z.optional(z.boolean()),
});

export type CloudflareDirectUploadDTO = z.infer<
  typeof CloudflareDirectUploadDTOSchema
>;
export const CloudflareDirectUploadDTOSchema = CloudflareResultDTOSchema.merge(
  z.object({
    result: z.object({
      id: z.string(),
      uploadURL: z.string().url(),
    }),
  })
);
