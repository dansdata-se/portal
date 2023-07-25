import { IndividualTag } from "@/api/individual_tag";
import { OrganizationTag } from "@/api/organization_tag";
import { z } from "zod";

export type BaseProfileMetadataDTO = z.infer<
  typeof BaseProfileMetadataDTOSchema
>;
export const BaseProfileMetadataDTOSchema = z.object({
  name: z.string(),
  profileType: z.enum(["organization", "individual", "venue"]),
  description: z.string().default(""),
  otherDetails: z.string().default(""),
  formats: z.enum(["cover", "poster", "square"]).array().min(1).max(3),
});

export type OrganizationMetadataDTO = z.infer<
  typeof OrganizationMetadataDTOSchema
>;
export const OrganizationMetadataDTOSchema = BaseProfileMetadataDTOSchema.merge(
  z.object({
    profileType: z.literal("organization"),
    associations: z.string().default(""),
    tags: z.nativeEnum(OrganizationTag).array(),
  })
);

export type IndividualMetadataDTO = z.infer<typeof IndividualMetadataDTOSchema>;
export const IndividualMetadataDTOSchema = BaseProfileMetadataDTOSchema.merge(
  z.object({
    profileType: z.literal("individual"),
    associations: z.string().default(""),
    tags: z.nativeEnum(IndividualTag).array(),
  })
);

export type VenueMetadataDTO = z.infer<typeof VenueMetadataDTOSchema>;
export const VenueMetadataDTOSchema = BaseProfileMetadataDTOSchema.merge(
  z.object({
    profileType: z.literal("venue"),
    location: z.object({
      lat: z.number().min(-90).max(90),
      lng: z.number().min(-180).max(180),
    }),
  })
);

export type MetadataDTO = z.infer<typeof MetadataDTOSchema>;
export const MetadataDTOSchema = z.discriminatedUnion("profileType", [
  OrganizationMetadataDTOSchema,
  IndividualMetadataDTOSchema,
  VenueMetadataDTOSchema,
]);
