const i18nextConfig = require("./next-i18next.config");

/** @type {import('next').NextConfig} */
const nextConfig = {
  ...i18nextConfig,
  reactStrictMode: true,
  trailingSlash: true,
};

module.exports = nextConfig;
