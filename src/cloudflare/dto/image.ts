import { CloudflareResultDTOSchema } from "@/cloudflare/dto/result";
import { z } from "zod";

// Partial schema - covers the parts we are interested in.
export type CloudflareImageDTO = z.infer<typeof CloudflareImageDTOSchema>;
export const CloudflareImageDTOSchema = CloudflareResultDTOSchema.merge(
  z.object({
    result: z.object({
      id: z.string(),
      meta: z.record(z.string()),
      uploaded: z.string().datetime(),
      draft: z.optional(z.boolean()),
    }),
  })
);
