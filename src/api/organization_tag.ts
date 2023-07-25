export enum OrganizationTag {
  performer = "performer",
  educator = "educator",
  organizer = "organizer",
  photographer = "photographer",
  booking_agent = "booking_agent",
}
export const OrganizationTagDetails: Record<
  OrganizationTag,
  { tag: OrganizationTag; label: string; description: string }
> = {
  [OrganizationTag.performer]: {
    tag: OrganizationTag.performer,
    label: "Band/Artist",
    description: "Band eller artist som kan bokas för ett uppträdande",
  },
  [OrganizationTag.educator]: {
    tag: OrganizationTag.educator,
    label: "Utbildare",
    description: "Företag eller förening som erbjuder dansutbildning",
  },
  [OrganizationTag.organizer]: {
    tag: OrganizationTag.organizer,
    label: "Arrangör",
    description: "Företag eller förening som arrangerar dansevenemang",
  },
  [OrganizationTag.photographer]: {
    tag: OrganizationTag.photographer,
    label: "Fotograf",
    description: "Företag eller förening som fotograferar vid dansevenemang",
  },
  [OrganizationTag.booking_agent]: {
    tag: OrganizationTag.booking_agent,
    label: "Bokare",
    description:
      "Företag eller förening som samordnar bokningar för artister och band",
  },
};
