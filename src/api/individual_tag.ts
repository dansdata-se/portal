export enum IndividualTag {
  musician = "musician",
  songwriter = "songwriter",
  instructor = "instructor",
  organizer = "organizer",
  photographer = "photographer",
}

export const IndividualTagDetails: Record<
  IndividualTag,
  { tag: IndividualTag; label: string; description: string }
> = {
  [IndividualTag.musician]: {
    tag: IndividualTag.musician,
    label: "Musiker",
    description: "Någon som utövar musik, med eller utan instrument",
  },
  [IndividualTag.songwriter]: {
    tag: IndividualTag.songwriter,
    label: "Låtskrivare",
    description: "Person som skriver musik",
  },
  [IndividualTag.instructor]: {
    tag: IndividualTag.instructor,
    label: "Instruktör",
    description: "Person som utbildar i dans",
  },
  [IndividualTag.organizer]: {
    tag: IndividualTag.organizer,
    label: "Arrangör",
    description: "Enskild person som arrangerar dansevenemang",
  },
  [IndividualTag.photographer]: {
    tag: IndividualTag.photographer,
    label: "Fotograf",
    description: "Enskild person som fotograferar vid dansevenemang",
  },
};
