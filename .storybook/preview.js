import { I18nextProvider } from "react-i18next";
import "../styles/globals.css";
import i18n from "./i18n";

export const parameters = {
  actions: { argTypesRegex: "^on[A-Z].*" },
  controls: {
    matchers: {
      color: /(background|color)$/i,
      date: /Date$/,
    },
  },
  i18n,
  locale: "sv",
  locales: {
    en: "English",
    sv: "Swedish",
  },
  darkMode: {
    classTarget: "html",
    darkClass: "dark",
    stylePreview: true,
  },
};

export const decorators = [
  (Story) => (
    <I18nextProvider i18n={i18n}>
      <Story />
    </I18nextProvider>
  ),
];
