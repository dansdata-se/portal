import { z } from "zod";

export type CreateImageUploadUrlDTO = z.infer<
  typeof CreateImageUploadUrlDTOSchema
>;
export const CreateImageUploadUrlDTOSchema = z.object({
  id: z.string(),
  uploadURL: z.string().url(),
});

