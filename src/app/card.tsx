import classNames from "classnames";

export default function Card({
  className = "",
  imgSrc,
  format,
  checked = false,
  onChange,
}: {
  className?: string;
  imgSrc: string;
  format: "cover" | "poster" | "square";
  checked?: boolean;
  onChange: (checked: boolean) => void;
}) {
  return (
    <article
      className={classNames(
        className,
        "card card-compact card-bordered w-full transition-opacity",
        {
          "opacity-50": !checked,
        }
      )}
    >
      <figure>
        {/* eslint-disable-next-line @next/next/no-img-element */}
        <img
          className={classNames("object-cover", {
            "aspect-cover": format === "cover",
            "aspect-poster": format === "poster",
            "aspect-square": format === "square",
          })}
          src={imgSrc}
          alt=""
        />
      </figure>
      <div className="card-body">
        <label className="label cursor-pointer">
          <span className="label-text">{format}</span>
          <input
            type="checkbox"
            className="checkbox"
            checked={checked}
            onChange={(e) => onChange(e.target.checked)}
          />
        </label>
        <span className="label-text-alt">
          {
            {
              cover: "min. 1800x945 px (40:21)",
              poster: "min. 1400x1960 px (5:7)",
              square: "min. 1500x1500 px (1:1)",
            }[format]
          }
        </span>
      </div>
    </article>
  );
}
