import { cloneElement, HTMLAttributes, ReactElement, useRef } from "react";
import { useIsomorphicLayoutEffect } from "usehooks-ts";

// Loosely inspired by `OutlinedTextField` from android Jetpack Compose
// https://developer.android.com/reference/kotlin/androidx/compose/material/package-summary#OutlinedTextField(kotlin.String,kotlin.Function1,androidx.compose.ui.Modifier,kotlin.Boolean,kotlin.Boolean,androidx.compose.ui.text.TextStyle,kotlin.Function0,kotlin.Function0,kotlin.Function0,kotlin.Function0,kotlin.Boolean,androidx.compose.ui.text.input.VisualTransformation,androidx.compose.foundation.text.KeyboardOptions,androidx.compose.foundation.text.KeyboardActions,kotlin.Boolean,kotlin.Int,androidx.compose.foundation.interaction.MutableInteractionSource,androidx.compose.ui.graphics.Shape,androidx.compose.material.TextFieldColors)
export type TextFieldAttributes = {
  variant: "filled" | "outlined";
  type: "multilineText" | "singlelineText" | "email" | "password" | "number";
  label: string;
  placeholder?: string;
  value: string;
  onValueChange: (newValue: string) => void;
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
   * This text does not alter the height of the text field.
   */
  supportingText?: string;
  /**
   * Indicate an error state (e.g. invalid contents).
   */
  error?: boolean;
  /**
   * Whether the text field is enabled or disabled.
   *
   * If your {@link leading} or {@link trailing} elements contain elements
   * that can be disabled, you must make sure these follow this `disabled` state!
   */
  disabled?: boolean;
  maxLength?: number;
  /**
   * See https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/pattern
   *
   * Only used when {@link type} is NOT "multilineText"
   */
  pattern?: string | undefined;
  required?: boolean;
} & Omit<HTMLAttributes<HTMLDivElement>, "children">;

function normalizeLeadingTrailing(
  node: ReactElement | string | null,
  leadingOrTrailing: "leading" | "trailing"
): ReactElement | null {
  if (typeof node === "string") {
    return <span className={leadingOrTrailing}>{node}</span>;
  }
  if (node !== null) {
    return cloneElement<HTMLElement>(node, {
      className: `${node.props.className ?? ""} ${leadingOrTrailing}`,
    });
  }
  return null;
}

function TextFieldInput({
  id,
  type,
  placeholder,
  value,
  onValueChange,
  disabled,
  maxLength,
  pattern,
  required,
}: Pick<
  TextFieldAttributes,
  | "id"
  | "type"
  | "placeholder"
  | "value"
  | "onValueChange"
  | "disabled"
  | "maxLength"
  | "pattern"
  | "required"
>) {
  const textAreaRef = useRef<HTMLTextAreaElement | null>(null);

  useIsomorphicLayoutEffect(() => {
    if (textAreaRef.current === null) return;
    textAreaRef.current.style.height = `${textAreaRef.current.scrollHeight}px`;
  }, [value, textAreaRef]);

  switch (type) {
    case "multilineText":
      return (
        <textarea
          id={id}
          ref={textAreaRef}
          placeholder={placeholder}
          value={value}
          onInput={(e) => onValueChange(e.currentTarget.value)}
          disabled={disabled}
          maxLength={maxLength}
          required={required}
        />
      );
    default:
      return (
        <input
          id={id}
          type={type === "singlelineText" ? "text" : type}
          placeholder={placeholder}
          value={value}
          onInput={(e) => onValueChange(e.currentTarget.value)}
          disabled={disabled}
          maxLength={maxLength}
          required={required}
          pattern={pattern}
        />
      );
  }
}

function TextField({
  variant,
  type,
  label,
  placeholder = " ",
  value,
  onValueChange,
  leading = null,
  trailing = null,
  supportingText = "",
  error = false,
  disabled = false,
  maxLength = -1,
  required = false,
  pattern,
  id = `id-${Math.random().toString(16).substring(2)}`,
  ...props
}: TextFieldAttributes) {
  if (placeholder.length === 0) {
    // A placeholder is required for proper positioning of the label.
    placeholder = " ";
  }
  leading = normalizeLeadingTrailing(leading, "leading");
  trailing = normalizeLeadingTrailing(trailing, "trailing");

  return (
    <div
      {...props}
      className={`textfield textfield-${variant} ${props.className ?? ""}`}
      data-error={error}
      data-disabled={disabled}
    >
      {leading}
      <div className="input-wrap">
        <TextFieldInput
          id={id}
          type={type}
          placeholder={placeholder}
          value={value}
          onValueChange={onValueChange}
          disabled={disabled}
          maxLength={maxLength}
          pattern={pattern}
          required={required}
        />
        <label htmlFor={id}>{label}</label>
      </div>
      {trailing}
      <div className="supporting-wrap">
        <span>{supportingText}</span>
        {maxLength >= 0 && (
          <span>
            {value.length}/{maxLength}
          </span>
        )}
      </div>
    </div>
  );
}
export default TextField;
