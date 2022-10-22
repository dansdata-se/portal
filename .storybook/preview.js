import * as NextImage from "next/future/image";
import { I18nextProvider } from "react-i18next";
import "../styles/globals.css";
import i18n from "./i18n";

// Fix images not rendering in storybook
// https://dev.to/jonasmerlin/how-to-use-the-next-js-image-component-in-storybook-1415
const OriginalNextImage = NextImage.default;
Object.defineProperty(NextImage, "default", {
  configurable: true,
  value: (props) => (
    <OriginalNextImage
      {...props}
      unoptimized
    />
  ),
});

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
