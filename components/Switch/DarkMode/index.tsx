import Switch, { SwitchState } from "components/Switch";
import {
  TernaryDarkMode,
  useHydrationSafeDarkMode,
} from "hooks/useHydrationSafeDarkMode";
import { HTMLAttributes } from "react";
import { Monitor, Moon, Sun } from "react-feather";
import { useTranslation } from "react-i18next";

const DarkModeStates: { [key in TernaryDarkMode]: SwitchState } = {
  system: {
    selection: false,
    thumb: "center",
    icon: <Monitor />,
  },
  dark: {
    selection: true,
    thumb: "left",
    icon: <Moon />,
  },
  light: {
    selection: true,
    thumb: "right",
    icon: <Sun />,
  },
};

/**
 * {@link Switch} with logic to change the current theme between light and dark mode.
 */
function DarkModeSwitch(props: HTMLAttributes<HTMLButtonElement>) {
  const { t: tCommon } = useTranslation("common");
  const { state, toggleDarkMode } = useHydrationSafeDarkMode();

  return (
    <Switch
      {...props}
      state={DarkModeStates[state]}
      onClick={() => toggleDarkMode()}
      altText={
        (state === "dark" && tCommon("sr-darkmode-on")) ||
        (state === "light" && tCommon("sr-darkmode-off")) ||
        tCommon("sr-darkmode-follow-system")
      }
    />
  );
}

export default DarkModeSwitch;
