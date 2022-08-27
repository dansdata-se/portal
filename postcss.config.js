module.exports = {
  plugins: {
    "postcss-import": {},
    // Ensure postcss-each is run before tailwindcss.
    // See https://github.com/madyankin/postcss-each/issues/39
    "postcss-each": {
      plugins: {
        beforeEach: [require("tailwindcss")],
      },
    },
    "tailwindcss/nesting": {},
    "postcss-calc": {},
    autoprefixer: {},
  },
};
