/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./src/**/*.{js,ts,jsx,tsx,mdx}"],
  theme: {
    extend: {
      aspectRatio: {
        cover: "1800 / 945",
        poster: "1400 / 1960",
      },
      colors: {
        outline: "rgba(var(--color-outline), <alpha-value>)",
      },
      screens: {
        xs: "475px",
      },
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
    fontFamily: {
      brand: ["var(--font-norican)"],
      sans: ["var(--font-roboto-flex)"],
    },
  },
  plugins: [require("@tailwindcss/typography"), require("daisyui")],
  daisyui: {
    themes: [
      {
        light: {
          primary: "#006877",
          secondary: "#006878",
          accent: "#006b58",
          neutral: "#DBE4E7",
          "base-100": "#F8FDFF",
          info: "#006877",
          success: "#006b58",
          warning: "#F3AF12",
          error: "#BA1A1A",
        },
      },
    ],
  },
};
