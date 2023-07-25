import { z } from "zod";

export enum ErrorCode {
  internalServerError = "INTERNAL_SERVER_ERROR",
  httpMethodNotAllowed = "METHOD_NOT_ALLOWED",
  unauthorized = "UNAUTHORIZED",
  forbidden = "FORBIDDEN",
  invalidParameters = "INVALID_PARAMETERS",
  invalidBody = "INVALID_BODY",
  notFound = "NOT_FOUND",
}

export type ErrorDTO = z.infer<typeof ErrorDTOSchema>;
export const ErrorDTOSchema = z.object({
  code: z.nativeEnum(ErrorCode),
  message: z.string(),
});
