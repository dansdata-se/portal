import classNames from "classnames";
import {
  cloneElement,
  DetailedHTMLProps,
  ForwardedRef,
  forwardRef,
  InputHTMLAttributes,
  ReactElement,
  useRef,
  useState,
} from "react";
import { mergeRefs } from "react-merge-refs";

export type TextFieldAttributes = {
  variant: "filled" | "outlined";
  label: string;
  /**
   * A leading icon or text.
   *
   * May be wrapped in a `<button>` to be clickable.
   */
  leading?: ReactElement | string | null;
  /**
   * A trailing icon or text.
   *
   * May be wrapped in a `<button>` to be clickable.
   */
  trailing?: ReactElement | string | null;
  /**
   * Supporting text shown beneath the text field.
   *
   * Supporting text is temporarily replaced by an error message
   * if the text field fails validation.
   */
  supportingText?: string;
  /**
   * Whether the text field is enabled or disabled.
   *
   * If your {@link leading} or {@link trailing} elements contain elements
   * that can be disabled, you must make sure these follow this `disabled` state!
   */
  disabled?: boolean;
} & DetailedHTMLProps<InputHTMLAttributes<HTMLInputElement>, HTMLInputElement> &
  Required<
    Pick<
      DetailedHTMLProps<
        InputHTMLAttributes<HTMLInputElement>,
        HTMLInputElement
      >,
      "id"
    >
  >;

function normalizeLeadingTrailing(
  node: ReactElement | string | null,
  leadingOrTrailing: "leading" | "trailing",
  disabled: boolean
): ReactElement | null {
  if (typeof node === "string") {
    return <span className={leadingOrTrailing}>{node}</span>;
  }
  if (node !== null) {
    return cloneElement<HTMLButtonElement>(node, {
      className: classNames(node.props.className, leadingOrTrailing),
      disabled,
    });
  }
  return null;
}

/**
 * A simple `<input>` element with surrounding markup to produce a material 3 style text field.
 */
const TextField = forwardRef(
  (
    {
      id,
      variant,
      label,
      placeholder = " ",
      leading = null,
      trailing = null,
      supportingText = "",
      ...attrs
    }: TextFieldAttributes,
    forwardedRef: ForwardedRef<HTMLInputElement>
  ) => {
    const ref = useRef<HTMLInputElement>(null);
    const [errorMessage, setErrorMessage] = useState<string | null>(null);
    const hasErrorMessage = errorMessage !== null;
    const [textLength, setTextLength] = useState(0);

    if (placeholder.length === 0) {
      // A placeholder is required for proper positioning of the label.
      placeholder = " ";
    }
    leading = normalizeLeadingTrailing(
      leading,
      "leading",
      attrs.disabled ?? false
    );
    trailing = normalizeLeadingTrailing(
      trailing,
      "trailing",
      attrs.disabled ?? false
    );

    if (hasErrorMessage && ref.current?.validity.valid) {
      setErrorMessage(null);
    }

    return (
      <div
        className={classNames(
          "textfield",
          `textfield-${variant}`,
          attrs.className
        )}
        data-error={hasErrorMessage ?? false}
        data-disabled={attrs.disabled ?? false}
      >
        <div className="content-wrap">
          {leading}
          <div className="input-wrap">
            <input
              ref={mergeRefs([ref, forwardedRef])}
              id={id}
              placeholder={placeholder}
              {...attrs}
              onInvalid={(e) => {
                attrs.onInvalid?.(e);
                if (e.defaultPrevented) return;

                e.preventDefault();
                setErrorMessage(ref.current?.validationMessage ?? "");
              }}
              onInput={(e) => {
                attrs.onInput?.(e);
                if (e.defaultPrevented) return;

                e.preventDefault();
                setTextLength(ref.current?.value.length ?? 0);
                setErrorMessage(null);
                ref.current?.setCustomValidity("");
              }}
            />
            <label htmlFor={id}>{label}</label>
          </div>
          {trailing}
        </div>
        {(supportingText || hasErrorMessage || attrs.maxLength) && (
          <div className="supporting-wrap">
            {/* This span also helps position the text length meter. */}
            <span>{errorMessage ?? supportingText}</span>
            {ref.current && (attrs.maxLength ?? -1) >= 0 && (
              <span>
                {textLength}/{attrs.maxLength}
              </span>
            )}
          </div>
        )}
      </div>
    );
  }
);
TextField.displayName = "TextField";

export default TextField;
