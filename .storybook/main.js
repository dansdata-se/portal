module.exports = {
  stories: [
    "./readme.stories.mdx",
    "../styles/**/*.stories.@(js|jsx|ts|tsx|mdx)",
    "../pages/**/*.stories.@(js|jsx|ts|tsx|mdx)",
  ],
  addons: [
    {
      name: "@storybook/addon-docs",
      options: {
        transcludeMarkdown: true,
      },
    },
    "@storybook/addon-links",
    "@storybook/addon-essentials",
    "@storybook/addon-interactions",
    "storybook-addon-next",
    "storybook-react-i18next",
    "storybook-dark-mode",
  ],
  framework: "@storybook/react",
  core: {
    builder: "@storybook/builder-webpack5",
  },
  staticDirs: ["../public"],
  webpackFinal: async (config, { isServer }) => {
    // Workaround for issues with SSR and next-i18next. See
    // https://github.com/storybookjs/storybook/issues/4082#issuecomment-818032557
    if (!isServer) {
      config.resolve.fallback = {
        fs: false,
        path: false,
      };
    }
    return config;
  },
};
