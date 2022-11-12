import classNames, { Argument } from "classnames";
import { CSSProperties, HTMLAttributes, useMemo } from "react";
import { MDColor } from "types/md";
import CircularProgressIndicatorSvg from "./circular-progress-indicator.svg";
import IndeterminateCircularProgressIndicatorSvg from "./indeterminate-circular-progress-indicator.svg";

// As defined on the <circle /> element in the progress indicator svg file
const PROGRESS_INDICATOR_RADIUS = 20;
const PROGRESS_INDICATOR_STROKE_DASH_100_PERCENT =
  2 * Math.PI * PROGRESS_INDICATOR_RADIUS;

function fractionToStrokeDashArray(fraction: number): string {
  const clampedFraction = Math.min(1, Math.max(0, fraction));
  return `${PROGRESS_INDICATOR_STROKE_DASH_100_PERCENT * clampedFraction} ${
    PROGRESS_INDICATOR_STROKE_DASH_100_PERCENT * (1 - clampedFraction)
  }`;
}

export type CircularProgressIndicatorAttributes = {
  /**
   * A value in the range `[0, 1]` or `undefined`
   * to display an indeterminate indicator
   */
  progress?: number | undefined;
  /**
   * The color of the indicator.
   *
   * `"currentColor"` to use the `color` of the surrounding context.
   */
  color?: MDColor | "currentColor";
  /**
   * How the indicator should be sized.
   * * `fixed` uses a default size of `48dp` (as defined by spec:
   * https://m3.material.io/components/progress-indicators/specs)
   * * `fill` uses a 100% width and height.
   * * `text` uses a 1em width and height
   * * `none` does not apply a default width or height
   */
  sizing?: "fixed" | "fill" | "text" | "none";
} & HTMLAttributes<HTMLDivElement>;

/**
 * A circular progress indicator.
 */
function CircularProgressIndicator({
  progress = undefined,
  color = "primary",
  sizing = "fixed",
  ...attrs
}: CircularProgressIndicatorAttributes) {
  const className = useMemo(() => {
    const classes: Argument[] = [];

    // color
    if (color !== "currentColor") {
      classes.push(`text-${color}`);
    }

    // sizing
    classes.push(
      {
        fixed: "w-12 h-12",
        fill: "w-full h-full",
        text: "w-[1em] h-[1em]",
        none: "",
      }[sizing]
    );

    return classNames(classes);
  }, [color, sizing]);

  return (
    <>
      {progress === undefined ? (
        <div {...attrs}>
          <IndeterminateCircularProgressIndicatorSvg className={className} />
          <span className="sr-only">Loading</span>
        </div>
      ) : (
        <div {...attrs}>
          <CircularProgressIndicatorSvg
            className={className}
            style={
              {
                "--md-comp-progress-indicator-stroke-dasharray":
                  fractionToStrokeDashArray(progress),
              } as CSSProperties
            }
          />
          <span className="sr-only">
            Progress at {Math.floor(progress * 100)}%
          </span>
        </div>
      )}
    </>
  );
}

export default CircularProgressIndicator;
