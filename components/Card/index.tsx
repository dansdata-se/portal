import classNames from "classnames";
import useChildHoverDetector from "hooks/ChildHoverDetector";
import { HTMLAttributes, ReactNode, useRef } from "react";

export type CardAttributes = {
  variant: "elevated" | "filled" | "outlined";
  disabled?: boolean;
  dragging?: boolean;
  children?: ReactNode;
} & HTMLAttributes<HTMLElement>;

/**
 * Standard `<article>` element with recommended `.card` classes and other markup added.
 */
function Card({
  variant,
  disabled = false,
  dragging = false,
  children,
  ...props
}: CardAttributes) {
  const selfRef = useRef<HTMLElement>(null);
  const childHovered = useChildHoverDetector(selfRef);
  return (
    <article
      {...props}
      ref={selfRef}
      className={classNames(
        "card",
        `card-${variant}`,
        {
          "card-drag": dragging,
          "card-disabled": disabled,
          "card-child-hover": childHovered,
        },
        props.className ?? ""
      )}
      {...(props.onClick && props.tabIndex === undefined
        ? { tabIndex: 0 }
        : {})}
    >
      {children}
    </article>
  );
}

export default Card;
