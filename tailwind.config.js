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
  },
  plugins: [],
};
