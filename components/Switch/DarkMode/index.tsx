import Switch, { SwitchState } from "components/Switch";
import { useMemo } from "react";
import { Monitor, Moon, Sun } from "react-feather";
import { useTranslation } from "react-i18next";
import {
  useIsClient,
  useIsomorphicLayoutEffect,
  useMediaQuery,
  useTernaryDarkMode,
} from "usehooks-ts";

const DarkModeStates: { [key in "AUTO" | "DARK" | "LIGHT"]: SwitchState } = {
  AUTO: {
    selection: false,
    thumb: "center",
    icon: <Monitor />,
  },
  DARK: {
    selection: true,
    thumb: "left",
    icon: <Moon />,
  },
  LIGHT: {
    selection: true,
    thumb: "right",
    icon: <Sun />,
  },
};

// Dark mode must be equal during SSG and first client render
// or there will be hydration errors. This function solves the
// issue by making the following assumptions during SSG and
// the first clientside render:
// 1. the "auto" theme is selected and
// 2. the "auto" theme results in the "light" theme.
// This comes at the cost of a short flicker for users using
// dark mode.
function useHydrationSafeDarkMode(): {
  state: SwitchState;
  isDarkMode: boolean;
  toggleDarkMode: () => void;
} {
  const isDarkOs = useMediaQuery("(prefers-color-scheme: dark)");
  const { isDarkMode, ternaryDarkMode, setTernaryDarkMode } =
    useTernaryDarkMode();
  const isClient = useIsClient();
  const state = useMemo(
    () =>
      ({
        light: DarkModeStates.LIGHT,
        dark: DarkModeStates.DARK,
        system: DarkModeStates.AUTO,
      }[ternaryDarkMode]),
    [ternaryDarkMode]
  );

  useIsomorphicLayoutEffect(() => {
    if (!isClient) return;
    document.documentElement.classList.toggle("dark", isDarkMode);
  }, [isClient, isDarkMode]);

  return {
    state: isClient ? state : DarkModeStates.AUTO,
    isDarkMode: isClient ? isDarkMode : false,
    toggleDarkMode() {
      // Smart toggle:
      // isDarkOs === true: system -> light -> dark -> ...
      // isDarkOs === false: system -> dark -> light -> ...
      switch (ternaryDarkMode) {
        case "dark":
          setTernaryDarkMode(isDarkOs ? "system" : "light");
          break;
        case "light":
          setTernaryDarkMode(isDarkOs ? "dark" : "system");
          break;
        default:
          setTernaryDarkMode(isDarkOs ? "light" : "dark");
          break;
      }
    },
  };
}

/**
 * {@link Switch} with logic to change the current theme between light and dark mode.
 */
function DarkModeSwitch() {
  const { t: tCommon } = useTranslation("common");
  const { state, toggleDarkMode } = useHydrationSafeDarkMode();

  return (
    <Switch
      state={state}
      onClick={() => toggleDarkMode()}
      altText={
        (state === DarkModeStates.DARK && tCommon("sr-darkmode-on")) ||
        (state === DarkModeStates.LIGHT && tCommon("sr-darkmode-off")) ||
        tCommon("sr-darkmode-follow-system")
      }
    />
  );
}

export default DarkModeSwitch;
