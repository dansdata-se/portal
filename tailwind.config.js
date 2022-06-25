const defaultTheme = require("tailwindcss/defaultTheme");
/** @type {import('tailwindcss').Config} */
module.exports = {
  darkMode: "class",
  content: [
    "./.storybook/**/*.{js,ts,jsx,tsx,mdx}",
    "./pages/**/*.{js,ts,jsx,tsx,mdx}",
    "./components/**/*.{js,ts,jsx,tsx,mdx}",
    "./styles/**/*.{js,ts,jsx,tsx,mdx}",
  ],
  theme: {
    extend: {},
    colors: {
      md: {
        sys: {
          color: {
            primary: {
              light: "#006877",
              dark: "#52d7f0",
            },
            "on-primary": {
              light: "#ffffff",
              dark: "#00363f",
            },
            "primary-container": {
              light: "#a4eeff",
              dark: "#004e5a",
            },
            "on-primary-container": {
              light: "#001f25",
              dark: "#a4eeff",
            },
            secondary: {
              light: "#4b6268",
              dark: "#b2cbd1",
            },
            "on-secondary": {
              light: "#ffffff",
              dark: "#1c3439",
            },
            "secondary-container": {
              light: "#cde7ee",
              dark: "#334a50",
            },
            "on-secondary-container": {
              light: "#051f24",
              dark: "#cde7ee",
            },
            tertiary: {
              light: "#006b58",
              dark: "#58dcbc",
            },
            "on-tertiary": {
              light: "#ffffff",
              dark: "#00382d",
            },
            "tertiary-container": {
              light: "#77f8d7",
              dark: "#005142",
            },
            "on-tertiary-container": {
              light: "#002019",
              dark: "#77f8d7",
            },
            error: {
              light: "#ba1a1a",
              dark: "#ffb4ab",
            },
            "on-error": {
              light: "#ffffff",
              dark: "#690005",
            },
            "error-container": {
              light: "#ffdad6",
              dark: "#93000a",
            },
            "on-error-container": {
              light: "#410002",
              dark: "#ffdad6",
            },
            outline: {
              light: "#6f797b",
              dark: "#899295",
            },
            background: {
              light: "#fbfcfd",
              dark: "#191c1d",
            },
            "on-background": {
              light: "#191c1d",
              dark: "#e1e3e4",
            },
            surface: {
              light: "#fbfcfd",
              dark: "#191c1d",
            },
            "on-surface": {
              light: "#191c1d",
              dark: "#e1e3e4",
            },
            "surface-variant": {
              light: "#dbe4e7",
              dark: "#3f484b",
            },
            "on-surface-variant": {
              light: "#3f484b",
              dark: "#bfc8cb",
            },
            "inverse-surface": {
              light: "#2e3132",
              dark: "#e1e3e4",
            },
            "inverse-on-surface": {
              light: "#eff1f2",
              dark: "#191c1d",
            },
          },
        },
      },
    },
    fontFamily: {
      brand: ["Norican", "cursive"],
      plain: ["Roboto Flex", "Roboto", ...defaultTheme.fontFamily.sans],
    },
    // 1 rem = 16px
    fontSize: {
      "display-large": ["3.5625rem", { lineHeight: "4rem" }],
      "display-medium": ["2.8125rem", { lineHeight: "3.25rem" }],
      "display-small": ["2.25rem", { lineHeight: "2.75rem" }],
      "headline-large": ["2rem", { lineHeight: "2.5rem" }],
      "headline-medium": ["1.75rem", { lineHeight: "2.25rem" }],
      "headline-small": ["1.5rem", { lineHeight: "2rem" }],
      "title-large": ["1.375rem", { lineHeight: "1.75rem" }],
      "title-medium": ["1rem", { lineHeight: "1.5rem" }],
      "title-small": ["0.875rem", { lineHeight: "1.25rem" }],
      "label-large": ["0.875rem", { lineHeight: "1.25rem" }],
      "label-medium": ["0.75rem", { lineHeight: "1rem" }],
      "label-small": ["0.6875rem", { lineHeight: "1rem" }],
      "body-large": ["1rem", { lineHeight: "1.5rem" }],
      "body-medium": ["0.875rem", { lineHeight: "1.25rem" }],
      "body-small": ["0.75rem", { lineHeight: "1rem" }],
    },
    lineHeight: {
      "display-large": "4rem",
      "display-medium": "3.25rem",
      "display-small": "2.25rem",
      "headline-large": "2rem",
      "headline-medium": "1.75rem",
      "headline-small": "1.5rem",
      "title-large": "1.375rem",
      "title-medium": "1rem",
      "title-small": "0.875rem",
      "label-large": "0.875rem",
      "label-medium": "0.75rem",
      "label-small": "0.6875rem",
      "body-large": "1rem",
      "body-medium": "0.875rem",
      "body-small": "0.75rem",
    },
    letterSpacing: {
      "display-large": "0rem",
      "display-medium": "0rem",
      "display-small": "0rem",
      "headline-large": "0rem",
      "headline-medium": "0rem",
      "headline-small": "0rem",
      "title-large": "0rem",
      "title-medium": "0.009375rem",
      "title-small": "0.00625rem",
      "label-large": "0.00625rem",
      "label-medium": "0.03125rem",
      "label-small": "0.03125rem",
      "body-large": "0.03125rem",
      "body-medium": "0.015625rem",
      "body-small": "0.025rem",
    },
    opacity: {
      0: "0",
      hover: "0.08",
      focus: "0.12",
      pressed: "0.12",
      dragged: "0.16",
      "disabled-bg": "0.12",
      "disabled-text": "0.38",
      100: "1",
    },
  },
  plugins: [require("@tailwindcss/forms")],
};
