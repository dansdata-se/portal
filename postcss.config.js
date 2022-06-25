module.exports = {
  plugins: {
    "postcss-import": {},
    "tailwindcss/nesting": {},
    // Ensure postcss-each is run before tailwindcss.
    // See https://github.com/madyankin/postcss-each/issues/39
    "postcss-each": {
      plugins: {
        beforeEach: [require("tailwindcss")],
      },
    },
    autoprefixer: {},
  },
};
