import Card from "@/app/card";
import { FileDropContext } from "@/app/file_drop_context";
import {
  Dispatch,
  Fragment,
  SetStateAction,
  useCallback,
  useContext,
  useEffect,
} from "react";

const allowedFileTypes = ["image/png", "image/jpeg", "image/webp"];

export function PhotoInput({
  photos,
  setPhotos,
}: {
  photos: {
    url: string;
    file: File;
    formats: ("cover" | "poster" | "square")[];
  }[];
  setPhotos: Dispatch<
    SetStateAction<
      { url: string; file: File; formats: ("cover" | "poster" | "square")[] }[]
    >
  >;
}) {
  const acceptFiles = useCallback(
    (files: FileList | null) => {
      if (!files) return;

      for (let i = 0; i < files.length; i++) {
        const file = files.item(i);
        if (file === null || !allowedFileTypes.includes(file.type)) {
          continue;
        }

        setPhotos((photos) => [
          ...photos,
          {
            // BUG(FelixZY): This object url is not cleaned up properly when
            // switching between organization/individual/venue tabs.
            url: URL.createObjectURL(file),
            file,
            formats: ["cover", "poster", "square"],
          },
        ]);
      }
    },
    [setPhotos]
  );

  const droppedFiles = useContext(FileDropContext);

  useEffect(() => {
    acceptFiles(droppedFiles);
  }, [acceptFiles, droppedFiles]);

  return (
    <>
      <span className="prose">
        <h3>Bilder</h3>
      </span>
      {photos.map((p, i) => (
        <Fragment key={p.url}>
          <Photo
            imgSrc={p.url}
            formats={p.formats}
            onFormatsChanged={(formats) => {
              setPhotos((photos) => [
                ...photos.slice(0, i),
                {
                  ...p,
                  formats: Array.isArray(formats)
                    ? formats
                    : formats(p.formats),
                },
                ...photos.slice(i + 1),
              ]);
            }}
            onRemove={() => {
              URL.revokeObjectURL(p.url);

              setPhotos((photos) => [
                ...photos.slice(0, i),
                ...photos.slice(i + 1),
              ]);
            }}
          />
          <div className="divider" />
        </Fragment>
      ))}
      <input
        type="file"
        multiple
        onChange={(e) => acceptFiles(e.target.files)}
        value=""
        placeholder="Dra en bild hit för att lägga till den"
        accept={allowedFileTypes.join(",")}
        className="file-input w-full"
      />
    </>
  );
}

export function Photo({
  imgSrc,
  formats,
  onFormatsChanged,
  onRemove,
}: {
  imgSrc: string;
  formats: ("cover" | "poster" | "square")[];
  onFormatsChanged: Dispatch<SetStateAction<("cover" | "poster" | "square")[]>>;
  onRemove: () => void;
}) {
  function buildOnChangeListener(format: "cover" | "poster" | "square") {
    return function onChange(checked: boolean) {
      onFormatsChanged((oldFormats) => {
        const formatSet = new Set(oldFormats);
        if (checked) {
          formatSet.add(format);
        } else {
          formatSet.delete(format);
        }
        const formatList = [...formatSet] as ("cover" | "poster" | "square")[];
        return formatList;
      });
    };
  }
  return (
    <section className="flex flex-col xs:grid xs:grid-cols-3 gap-4 xs:items-end">
      <Card
        className="w-full xs:shrink"
        format="cover"
        checked={formats.includes("cover")}
        onChange={buildOnChangeListener("cover")}
        imgSrc={imgSrc}
      />
      <Card
        className="w-full xs:shrink"
        format="square"
        checked={formats.includes("square")}
        onChange={buildOnChangeListener("square")}
        imgSrc={imgSrc}
      />
      <Card
        className="w-full xs:shrink"
        format="poster"
        checked={formats.includes("poster")}
        onChange={buildOnChangeListener("poster")}
        imgSrc={imgSrc}
      />
      <button
        onClick={onRemove}
        className="btn btn-outline btn-error col-span-3"
      >
        Ta bort
      </button>
    </section>
  );
}
