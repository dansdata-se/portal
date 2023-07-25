import { VenueMetadataDTO } from "@/api/dto/metadata";
import { LatLng } from "@/app/map";
import { PhotoInput } from "@/app/photo";
import SubmitButton from "@/app/submit_button";
import dynamic from "next/dynamic";
import { useState } from "react";

const Map = dynamic(() => import("@/app/map"), {
  ssr: false,
});

export default function VenueForm({
  isSubmitting,
  onSubmit,
}: {
  isSubmitting?: boolean;
  onSubmit: (photosWithMetadata: [File, VenueMetadataDTO][]) => void;
}) {
  const [name, setName] = useState("");
  const [description, setDescription] = useState("");
  const [otherDetails, setOtherDetails] = useState("");
  const [location, setLocation] = useState<LatLng | null>(null);
  const [photos, setPhotos] = useState<
    { url: string; file: File; formats: ("cover" | "poster" | "square")[] }[]
  >([]);
  return (
    <form
      onSubmit={(e) => {
        e.preventDefault();
        e.stopPropagation();

        if (!e.currentTarget.reportValidity()) return;
        if (location === null) {
          alert("Du har inte markerat någon plats på kartan");
          return;
        }
        if (photos.length === 0) {
          alert("Du har inte lagt till några bilder");
          return;
        }

        onSubmit(
          photos.map((p) => [
            p.file,
            {
              profileType: "venue",
              name,
              description,
              otherDetails,
              formats: p.formats,
              location,
            },
          ])
        );
      }}
    >
      <div className="container">
        <div className="prose mb-16">
          <h3>
            Har dansbanan flera dansgolv?
          </h3>
          <p>
            Skapa:
            <ul>
              <li>1 plats för dansområdet (t.ex Ljungsbro Folkets Park)</li>
              <li>1 plats per dansgolv (t.ex. &ldquo;Utomhusbanan&rdquo; och &ldquo;Inomhusbanan&rdquo;)</li>
            </ul>
          </p>
        </div>
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
            <span className="prose">
              <h3>Plats</h3>
            </span>
            <div className="form-control w-full">
              <span className="label">
                <span className="label-text">Markera platsen på kartan</span>
              </span>
              <div className="relative w-full aspect-video z-0">
                <Map onLocationSelected={setLocation} />
              </div>
              <span className="label">
                <span />
                <span className="label-text-alt">
                  Du placerar markören genom att klicka på kartan.
                </span>
              </span>
            </div>

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
