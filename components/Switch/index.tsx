import classNames from "classnames";
import { HTMLAttributes, ReactNode } from "react";
import { Check } from "react-feather";

export type SwitchState = {
  /**
   * Whether the current state should indicate a selection -
   * e.g. an "on" state.
   */
  selection: boolean;
  /**
   * The position of the thumb within the switch.
   */
  thumb: "left" | "right" | "center";
  icon: ReactNode | null;
};

type PredefinedSwitchStates = "ON" | "OFF" | "INDETERMINATE";
export const SimpleSwitchState: {
  [key in PredefinedSwitchStates]: SwitchState;
} = {
  ON: {
    selection: true,
    thumb: "right",
    icon: <Check />,
  },
  OFF: {
    selection: false,
    thumb: "left",
    icon: null,
  },
  INDETERMINATE: {
    selection: false,
    thumb: "center",
    icon: null,
  },
};

/**
 * A simple toggle switch with support for an "indeterminate" state.
 *
 * Default `on`/`off`/`indeterminate` states are provided by {@link SimpleSwitchState}
 * but you can also set up your own states using custom {@link SwitchState}s.
 */
function Switch({
  state,
  onClick = () => {},
  disabled = false,
  altText = "",
  ...props
}: {
  state: SwitchState;
  onClick?: () => void;
  disabled?: boolean;
  altText?: string;
} & HTMLAttributes<HTMLButtonElement>) {
  return (
    <button
      {...props}
      className={`switch ${props.className}`}
      data-selection={state.selection ? "true" : "false"}
      data-thumb={state.thumb}
      disabled={disabled}
      onClick={() => onClick()}
    >
      <div className="switch-track"></div>
      <div
        className={classNames("switch-thumb", {
          "switch-thumb-icon": state.icon !== null,
        })}
      >
        {state.icon}
      </div>
      {altText && <span className="sr-only">{altText}</span>}
    </button>
  );
}

export default Switch;
