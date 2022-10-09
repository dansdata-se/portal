const path = require("path");

module.exports = {
  i18n: {
    defaultLocale: "sv",
    locales: ["en", "sv"],
  },
  localePath: path.resolve("./public/locales"),
  localeExtension: "yaml",
};
