import { IndividualMetadataDTO } from "@/api/dto/metadata";
import { IndividualTag, IndividualTagDetails } from "@/api/individual_tag";
import { PhotoInput } from "@/app/photo";
import SubmitButton from "@/app/submit_button";
import { useState } from "react";

export default function IndividualForm({
  isSubmitting,
  onSubmit,
}: {
  isSubmitting?: boolean;
  onSubmit: (photosWithMetadata: [File, IndividualMetadataDTO][]) => void;
}) {
  const [name, setName] = useState("");
  const [description, setDescription] = useState("");
  const [associations, setAssociations] = useState("");
  const [otherDetails, setOtherDetails] = useState("");
  const [tags, setTags] = useState<Record<IndividualTag, boolean>>(
    Object.fromEntries(
      Object.values(IndividualTag).map((tag) => [tag, false])
    ) as Record<IndividualTag, boolean>
  );
  const [photos, setPhotos] = useState<
    { url: string; file: File; formats: ("cover" | "poster" | "square")[] }[]
  >([]);
  return (
    <form
      onSubmit={(e) => {
        e.preventDefault();
        e.stopPropagation();

        if (!e.currentTarget.reportValidity()) return;
        if (photos.length === 0) {
          alert("Du har inte lagt till några bilder");
          return;
        }

        onSubmit(
          photos.map((p) => [
            p.file,
            {
              profileType: "individual",
              name,
              associations,
              description,
              tags: Object.entries(tags)
                .filter(([, include]) => include)
                .map(([tag]) => tag as IndividualTag),
              otherDetails,
              formats: p.formats,
            },
          ])
        );
      }}
    >
      <div className="container">
        <div className="flex flex-col lg:flex-row items-center lg:items-start gap-4">
          <div className="flex flex-col gap-6 lg:max-w-sm w-full">
            <span className="prose">
              <h3>Om</h3>
            </span>
            <div className="form-control w-full">
              <input
                type="text"
                placeholder="Namn"
                className="input input-bordered w-full"
                value={name}
                onChange={(e) => setName(e.currentTarget.value)}
                required
              />
            </div>
            <div className="form-control w-full">
              <textarea
                className="textarea textarea-bordered"
                placeholder="Beskrivning (valfritt)"
                rows={2}
                value={description}
                onChange={(e) => setDescription(e.currentTarget.value)}
              />
            </div>
            <div className="grid w-full gap-2">
              <span>Vilka kategorier beskriver personen bäst?</span>
              {Object.values(IndividualTagDetails).map(({ tag, label }) => (
                <div
                  key={tag}
                  className="form-control w-full"
                >
                  <label className="label cursor-pointer">
                    <span className="label-text">{label}</span>
                    <input
                      type="checkbox"
                      className="checkbox"
                      checked={tags[tag]}
                      onChange={(e) =>
                        setTags((tags) => ({
                          ...tags,
                          [tag]: e.target.checked,
                        }))
                      }
                    />
                  </label>
                </div>
              ))}
            </div>
            <div className="form-control w-full">
              <label className="label">
                <span className="label-text">
                  Vilka band/föreningar/företag är personen medlem i?
                </span>
              </label>
              <textarea
                className="textarea textarea-bordered"
                placeholder="Tillhörighet (valfritt)"
                rows={2}
                value={associations}
                onChange={(e) => setAssociations(e.currentTarget.value)}
              />
              <label className="label">
                <span className="label-text-alt">
                  Exempel: Blender (basist), Sportdansarna (instruktör)
                </span>
              </label>
            </div>
            <div className="form-control w-full">
              <textarea
                className="textarea textarea-bordered"
                placeholder="Övriga upplysningar (valfritt)"
                rows={4}
                value={otherDetails}
                onChange={(e) => setOtherDetails(e.currentTarget.value)}
              />
            </div>
          </div>
          <div className="flex flex-col gap-4 w-full lg:w-0 lg:grow">
            <PhotoInput
              photos={photos}
              setPhotos={setPhotos}
            />
          </div>
        </div>
        <SubmitButton loading={isSubmitting} />
      </div>
    </form>
  );
}
