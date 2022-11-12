import CircularProgressIndicator from "components/Progress/Circular/CircularProgressIndicator";
import { ForwardedRef, forwardRef } from "react";
import Button, { ButtonAttributes } from "../..";

export type CircularProgressButtonAttributes = Omit<
  ButtonAttributes,
  "icon"
> & {
  /**
   * Whether or not to show a circular loading indicator on the button.
   */
  loading?: boolean;
  /**
   * A value in the range `[0, 1]` or `undefined`
   * to display an indeterminate progress indicator.
   */
  progress?: number | undefined;
};

/**
 * {@link Button} element with optional {@link CircularProgressIndicator}
 * depending on the current `loading` state for ease of use.
 */
const CircularProgressButton = forwardRef<
  HTMLButtonElement,
  CircularProgressButtonAttributes
>(
  (
    {
      loading = false,
      progress = undefined,
      ...attrs
    }: CircularProgressButtonAttributes,
    ref: ForwardedRef<HTMLButtonElement> | undefined
  ) => {
    return (
      <Button
        ref={ref}
        icon={
          loading ? (
            <CircularProgressIndicator
              color="currentColor"
              sizing="text"
              progress={progress}
            />
          ) : undefined
        }
        {...attrs}
      />
    );
  }
);
CircularProgressButton.displayName = "CircularProgressButton";

export default CircularProgressButton;
