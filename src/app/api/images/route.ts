import { ErrorCode, ErrorDTO } from "@/api/dto/error";
import { MetadataDTO, MetadataDTOSchema } from "@/api/dto/metadata";
import { CreateImageUploadUrlDTO } from "@/api/dto/image";
import { cloudflareApi } from "@/cloudflare/api";
import env from "@/env";
import logger from "@/logger";
import { headers } from "next/headers";
import { NextResponse } from "next/server";
import { fromZodError } from "zod-validation-error";

export async function POST(req: Request) {
  try {
    const authHeader = headers().get("authorization");
    if (authHeader === `Bearer ${env.AUTH_KEY}`) {
      const parseResult = await MetadataDTOSchema.safeParseAsync(
        await req.json()
      );
      if (!parseResult.success) {
        const validationError = fromZodError(parseResult.error);
        return NextResponse.json<ErrorDTO>(
          {
            code: ErrorCode.invalidBody,
            message: validationError.message,
          },
          {
            status: 400,
          }
        );
      }

      const metadata: MetadataDTO = parseResult.data;

      const {
        success,
        result: { id, uploadURL },
        messages,
        errors,
      } = await cloudflareApi.images.createImageUploadUrl({
        metadata,
      });

      if (messages.length > 0) {
        logger.warn(
          { cloudflare: { messages } },
          "Cloudflare API returned messages"
        );
      }
      if (errors.length > 0) {
        logger.error(
          { cloudflare: { errors } },
          "Cloudflare API returned errors"
        );
      }
      if (!success) {
        throw new Error("Failed to allocate upload url from cloudflare");
      }

      return NextResponse.json<CreateImageUploadUrlDTO>(
        {
          id,
          uploadURL,
        },
        {
          status: 201,
        }
      );
    } else {
      return NextResponse.json<ErrorDTO>(
        {
          code: ErrorCode.unauthorized,
          message: "You must be authenticated to access this resource.",
        },
        {
          status: 401,
        }
      );
    }
  } catch (e) {
    logger.error(e, "Could not create an image upload url.");
    return NextResponse.json<ErrorDTO>(
      {
        code: ErrorCode.internalServerError,
        message: "Could not create an image upload url.",
      },
      {
        status: 500,
      }
    );
  }
}
