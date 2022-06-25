import classNames from "classnames";
import { ButtonHTMLAttributes, ReactElement } from "react";
import { Icon } from "react-feather";

export type ButtonAttributes = {
  variant: "elevated" | "filled" | "tonal" | "outlined" | "text";
  text: string;
  icon?:
    | ReactElement<Icon>
    | ReactElement<HTMLImageElement>
    | ReactElement<SVGElement>;
} & ButtonHTMLAttributes<HTMLButtonElement>;

/**
 * Standard `<button>` element with recommended `.btn` classes and other markup added.
 *
 * Pure icon buttons should not use this component.
 */
function Button({ variant, text, icon, ...props }: ButtonAttributes) {
  return (
    <button
      {...props}
      className={classNames("btn", `btn-${variant}`, props?.className)}
    >
      <>
        {icon}
        {text.length && <span>{text}</span>}
      </>
    </button>
  );
}

export default Button;
