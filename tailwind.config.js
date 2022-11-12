const defaultTheme = require("tailwindcss/defaultTheme");
const card = require("./styles/components/card/tailwind");
const elevation = require("./styles/elevation/tailwind");

// Based on
// https://github.com/adamwathan/tailwind-css-variable-text-opacity-demo
function cssRgbVar(cssVar) {
  return ({ opacityVariable, opacityValue }) => {
    if (opacityValue !== undefined) {
      return `rgba(var(${cssVar}), ${opacityValue})`;
    }
    if (opacityVariable !== undefined) {
      return `rgba(var(${cssVar}), var(${opacityVariable}, 1))`;
    }
    return `rgb(var(${cssVar}))`;
  };
}

/** @type {import('tailwindcss').Config} */
module.exports = {
  darkMode: "class",
  important: true,
  content: [
    "./.storybook/**/*.{js,ts,jsx,tsx,mdx}",
    "./pages/**/*.{js,ts,jsx,tsx,mdx}",
    "./components/**/*.{js,ts,jsx,tsx,mdx}",
    "./styles/**/*.{js,ts,jsx,tsx,mdx}",
  ],
  theme: {
    extend: {
      gap: {
        ...card.theme.extends.gap,
      },
      borderWidth: {
        1: "1px",
      },
      zIndex: {
        1: 1,
        2: 2,
        3: 3,
        4: 4,
        5: 5,
        6: 6,
        7: 7,
        8: 8,
        9: 9,
      },
    },
    screens: {
      xs: "475px",
      sm: "640px",
      md: "768px",
      lg: "1024px",
      xl: "1280px",
      "2xl": "1536px",
    },
    container: {
      center: true,
      padding: {
        DEFAULT: "1rem",
        sm: "2rem",
        lg: "4rem",
        xl: "5rem",
        "2xl": "6rem",
      },
    },
    boxShadow: elevation.theme.boxShadow,
    colors: {
      transparent: "transparent",
      primary: cssRgbVar("--md-sys-color-primary"),
      "primary-light": cssRgbVar("--md-sys-color-primary-light"),
      "primary-dark": cssRgbVar("--md-sys-color-primary-dark"),
      "on-primary": cssRgbVar("--md-sys-color-on-primary"),
      "on-primary-light": cssRgbVar("--md-sys-color-on-primary-light"),
      "on-primary-dark": cssRgbVar("--md-sys-color-on-primary-dark"),
      "primary-container": cssRgbVar("--md-sys-color-primary-container"),
      "primary-container-light": cssRgbVar(
        "--md-sys-color-primary-container-light"
      ),
      "primary-container-dark": cssRgbVar(
        "--md-sys-color-primary-container-dark"
      ),
      "on-primary-container": cssRgbVar("--md-sys-color-on-primary-container"),
      "on-primary-container-light": cssRgbVar(
        "--md-sys-color-on-primary-container-light"
      ),
      "on-primary-container-dark": cssRgbVar(
        "--md-sys-color-on-primary-container-dark"
      ),
      secondary: cssRgbVar("--md-sys-color-secondary"),
      "secondary-light": cssRgbVar("--md-sys-color-secondary-light"),
      "secondary-dark": cssRgbVar("--md-sys-color-secondary-dark"),
      "on-secondary": cssRgbVar("--md-sys-color-on-secondary"),
      "on-secondary-light": cssRgbVar("--md-sys-color-on-secondary-light"),
      "on-secondary-dark": cssRgbVar("--md-sys-color-on-secondary-dark"),
      "secondary-container": cssRgbVar("--md-sys-color-secondary-container"),
      "secondary-container-light": cssRgbVar(
        "--md-sys-color-secondary-container-light"
      ),
      "secondary-container-dark": cssRgbVar(
        "--md-sys-color-secondary-container-dark"
      ),
      "on-secondary-container": cssRgbVar(
        "--md-sys-color-on-secondary-container"
      ),
      "on-secondary-container-light": cssRgbVar(
        "--md-sys-color-on-secondary-container-light"
      ),
      "on-secondary-container-dark": cssRgbVar(
        "--md-sys-color-on-secondary-container-dark"
      ),
      tertiary: cssRgbVar("--md-sys-color-tertiary"),
      "tertiary-light": cssRgbVar("--md-sys-color-tertiary-light"),
      "tertiary-dark": cssRgbVar("--md-sys-color-tertiary-dark"),
      "on-tertiary": cssRgbVar("--md-sys-color-on-tertiary"),
      "on-tertiary-light": cssRgbVar("--md-sys-color-on-tertiary-light"),
      "on-tertiary-dark": cssRgbVar("--md-sys-color-on-tertiary-dark"),
      "tertiary-container": cssRgbVar("--md-sys-color-tertiary-container"),
      "tertiary-container-light": cssRgbVar(
        "--md-sys-color-tertiary-container-light"
      ),
      "tertiary-container-dark": cssRgbVar(
        "--md-sys-color-tertiary-container-dark"
      ),
      "on-tertiary-container": cssRgbVar(
        "--md-sys-color-on-tertiary-container"
      ),
      "on-tertiary-container-light": cssRgbVar(
        "--md-sys-color-on-tertiary-container-light"
      ),
      "on-tertiary-container-dark": cssRgbVar(
        "--md-sys-color-on-tertiary-container-dark"
      ),
      error: cssRgbVar("--md-sys-color-error"),
      "error-light": cssRgbVar("--md-sys-color-error-light"),
      "error-dark": cssRgbVar("--md-sys-color-error-dark"),
      "on-error": cssRgbVar("--md-sys-color-on-error"),
      "on-error-light": cssRgbVar("--md-sys-color-on-error-light"),
      "on-error-dark": cssRgbVar("--md-sys-color-on-error-dark"),
      "error-container": cssRgbVar("--md-sys-color-error-container"),
      "error-container-light": cssRgbVar(
        "--md-sys-color-error-container-light"
      ),
      "error-container-dark": cssRgbVar("--md-sys-color-error-container-dark"),
      "on-error-container": cssRgbVar("--md-sys-color-on-error-container"),
      "on-error-container-light": cssRgbVar(
        "--md-sys-color-on-error-container-light"
      ),
      "on-error-container-dark": cssRgbVar(
        "--md-sys-color-on-error-container-dark"
      ),
      outline: cssRgbVar("--md-sys-color-outline"),
      "outline-light": cssRgbVar("--md-sys-color-outline-light"),
      "outline-dark": cssRgbVar("--md-sys-color-outline-dark"),
      background: cssRgbVar("--md-sys-color-background"),
      "background-light": cssRgbVar("--md-sys-color-background-light"),
      "background-dark": cssRgbVar("--md-sys-color-background-dark"),
      "on-background": cssRgbVar("--md-sys-color-on-background"),
      "on-background-light": cssRgbVar("--md-sys-color-on-background-light"),
      "on-background-dark": cssRgbVar("--md-sys-color-on-background-dark"),
      surface: cssRgbVar("--md-sys-color-surface"),
      "surface-light": cssRgbVar("--md-sys-color-surface-light"),
      "surface-dark": cssRgbVar("--md-sys-color-surface-dark"),
      "on-surface": cssRgbVar("--md-sys-color-on-surface"),
      "on-surface-light": cssRgbVar("--md-sys-color-on-surface-light"),
      "on-surface-dark": cssRgbVar("--md-sys-color-on-surface-dark"),
      "surface-variant": cssRgbVar("--md-sys-color-surface-variant"),
      "surface-variant-light": cssRgbVar(
        "--md-sys-color-surface-variant-light"
      ),
      "surface-variant-dark": cssRgbVar("--md-sys-color-surface-variant-dark"),
      "on-surface-variant": cssRgbVar("--md-sys-color-on-surface-variant"),
      "on-surface-variant-light": cssRgbVar(
        "--md-sys-color-on-surface-variant-light"
      ),
      "on-surface-variant-dark": cssRgbVar(
        "--md-sys-color-on-surface-variant-dark"
      ),
      "inverse-surface": cssRgbVar("--md-sys-color-inverse-surface"),
      "inverse-surface-light": cssRgbVar(
        "--md-sys-color-inverse-surface-light"
      ),
      "inverse-surface-dark": cssRgbVar("--md-sys-color-inverse-surface-dark"),
      "inverse-on-surface": cssRgbVar("--md-sys-color-inverse-on-surface"),
      "inverse-on-surface-light": cssRgbVar(
        "--md-sys-color-inverse-on-surface-light"
      ),
      "inverse-on-surface-dark": cssRgbVar(
        "--md-sys-color-inverse-on-surface-dark"
      ),
    },
    fontFamily: {
      brand: ["Norican", ...defaultTheme.fontFamily.serif],
      plain: ["Roboto Flex", "Roboto", ...defaultTheme.fontFamily.sans],
    },
    // 1 rem = 16px
    borderRadius: {
      none: "var(--md-sys-shape-corner-none)",
      xs: "var(--md-sys-shape-corner-extra-small)",
      sm: "var(--md-sys-shape-corner-small)",
      md: "var(--md-sys-shape-corner-medium)",
      lg: "var(--md-sys-shape-corner-large)",
      xl: "var(--md-sys-shape-corner-extra-large)",
      full: "var(--md-sys-shape-corner-full)",
    },
    fontSize: {
      "display-large": [
        "var(--md-sys-typescale-display-large-size)",
        { lineHeight: "var(--md-sys-typescale-display-large-line-height)" },
      ],
      "display-medium": [
        "var(--md-sys-typescale-display-medium-size)",
        { lineHeight: "var(--md-sys-typescale-display-medium-line-height)" },
      ],
      "display-small": [
        "var(--md-sys-typescale-display-small-size)",
        { lineHeight: "var(--md-sys-typescale-display-small-line-height)" },
      ],
      "headline-large": [
        "var(--md-sys-typescale-headline-large-size)",
        { lineHeight: "var(--md-sys-typescale-headline-large-line-height)" },
      ],
      "headline-medium": [
        "var(--md-sys-typescale-headline-medium-size)",
        { lineHeight: "var(--md-sys-typescale-headline-medium-line-height)" },
      ],
      "headline-small": [
        "var(--md-sys-typescale-headline-small-size)",
        { lineHeight: "var(--md-sys-typescale-headline-small-line-height)" },
      ],
      "title-large": [
        "var(--md-sys-typescale-title-large-size)",
        { lineHeight: "var(--md-sys-typescale-title-large-line-height)" },
      ],
      "title-medium": [
        "var(--md-sys-typescale-title-medium-size)",
        { lineHeight: "var(--md-sys-typescale-title-medium-line-height)" },
      ],
      "title-small": [
        "var(--md-sys-typescale-title-small-size)",
        { lineHeight: "var(--md-sys-typescale-title-small-line-height)" },
      ],
      "label-large": [
        "var(--md-sys-typescale-label-large-size)",
        { lineHeight: "var(--md-sys-typescale-label-large-line-height)" },
      ],
      "label-medium": [
        "var(--md-sys-typescale-label-medium-size)",
        { lineHeight: "var(--md-sys-typescale-label-medium-line-height)" },
      ],
      "label-small": [
        "var(--md-sys-typescale-label-small-size)",
        { lineHeight: "var(--md-sys-typescale-label-small-line-height)" },
      ],
      "body-large": [
        "var(--md-sys-typescale-body-large-size)",
        { lineHeight: "var(--md-sys-typescale-body-large-line-height)" },
      ],
      "body-medium": [
        "var(--md-sys-typescale-body-medium-size)",
        { lineHeight: "var(--md-sys-typescale-body-medium-line-height)" },
      ],
      "body-small": [
        "var(--md-sys-typescale-body-small-size)",
        { lineHeight: "var(--md-sys-typescale-body-small-line-height)" },
      ],
    },
    lineHeight: {
      "display-large": "var(--md-sys-typescale-display-large-line-height)",
      "display-medium": "var(--md-sys-typescale-display-medium-line-height)",
      "display-small": "var(--md-sys-typescale-display-small-line-height)",
      "headline-large": "var(--md-sys-typescale-headline-large-line-height)",
      "headline-medium": "var(--md-sys-typescale-headline-medium-line-height)",
      "headline-small": "var(--md-sys-typescale-headline-small-line-height)",
      "title-large": "var(--md-sys-typescale-title-large-line-height)",
      "title-medium": "var(--md-sys-typescale-title-medium-line-height)",
      "title-small": "var(--md-sys-typescale-title-small-line-height)",
      "label-large": "var(--md-sys-typescale-label-large-line-height)",
      "label-medium": "var(--md-sys-typescale-label-medium-line-height)",
      "label-small": "var(--md-sys-typescale-label-small-line-height)",
      "body-large": "var(--md-sys-typescale-body-large-line-height)",
      "body-medium": "var(--md-sys-typescale-body-medium-line-height)",
      "body-small": "var(--md-sys-typescale-body-small-line-height)",
    },
    letterSpacing: {
      "display-large": "var(--md-sys-typescale-display-large-tracking)",
      "display-medium": "var(--md-sys-typescale-display-medium-tracking)",
      "display-small": "var(--md-sys-typescale-display-small-tracking)",
      "headline-large": "var(--md-sys-typescale-headline-large-tracking)",
      "headline-medium": "var(--md-sys-typescale-headline-medium-tracking)",
      "headline-small": "var(--md-sys-typescale-headline-small-tracking)",
      "title-large": "var(--md-sys-typescale-title-large-tracking)",
      "title-medium": "var(--md-sys-typescale-title-medium-tracking)",
      "title-small": "var(--md-sys-typescale-title-small-tracking)",
      "label-large": "var(--md-sys-typescale-label-large-tracking)",
      "label-medium": "var(--md-sys-typescale-label-medium-tracking)",
      "label-small": "var(--md-sys-typescale-label-small-tracking)",
      "body-large": "var(--md-sys-typescale-body-large-tracking)",
      "body-medium": "var(--md-sys-typescale-body-medium-tracking)",
      "body-small": "var(--md-sys-typescale-body-small-tracking)",
    },
    opacity: {
      0: "0",
      hover: "0.08",
      focus: "0.12",
      pressed: "0.12",
      dragged: "0.16",
      "disabled-bg": "0.12",
      "disabled-text": "0.38",
      "disabled-container": "0.38",
      100: "1",
    },
  },
  plugins: [require("@tailwindcss/forms")],
};
