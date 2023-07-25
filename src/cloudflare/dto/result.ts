import { z } from "zod";

export type CloudflareResultDTO = z.infer<typeof CloudflareResultDTOSchema>;
export const CloudflareResultDTOSchema = z.object({
  errors: z.array(
    z.object({
      code: z.number(),
      message: z.string(),
    })
  ),
  messages: z.array(
    z.object({
      code: z.number(),
      message: z.string(),
    })
  ),
  success: z.boolean(),
});
