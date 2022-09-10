import classNames from "classnames";
import {
  ButtonHTMLAttributes,
  ForwardedRef,
  forwardRef,
  ReactElement,
} from "react";
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

const Button = forwardRef<HTMLButtonElement, ButtonAttributes>(
  (
    { variant, text, icon, ...attrs }: ButtonAttributes,
    ref: ForwardedRef<HTMLButtonElement> | undefined
  ) => {
    return (
      <button
        {...attrs}
        ref={ref}
        className={classNames("btn", `btn-${variant}`, attrs?.className)}
      >
        <>
          {icon}
          {text.length && <span>{text}</span>}
        </>
      </button>
    );
  }
);
Button.displayName = "Button";

export default Button;
