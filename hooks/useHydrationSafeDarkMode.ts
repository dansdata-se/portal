import {
  useIsClient,
  useIsomorphicLayoutEffect,
  useMediaQuery,
  useTernaryDarkMode,
} from "usehooks-ts";

export type TernaryDarkMode = "system" | "dark" | "light";

/**
 * Dark mode must be equal during SSG and first client render
 * or there will be hydration errors. This function solves the
 * issue by making the following assumptions during SSG and
 * the first clientside render:
 * 1. the "auto" theme is selected and
 * 2. the "auto" theme results in the "light" theme.
 * This comes at the cost of a short flicker for users using
 * dark mode.
 */
export function useHydrationSafeDarkMode(): {
  state: TernaryDarkMode;
  isDarkMode: boolean;
  toggleDarkMode: () => void;
} {
  const isDarkOs = useMediaQuery("(prefers-color-scheme: dark)");
  const { isDarkMode, ternaryDarkMode, setTernaryDarkMode } =
    useTernaryDarkMode();
  const isClient = useIsClient();

  useIsomorphicLayoutEffect(() => {
    if (!isClient) return;
    document.documentElement.classList.toggle("dark", isDarkMode);
  }, [isClient, isDarkMode]);

  return {
    state: isClient ? ternaryDarkMode : "system",
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
