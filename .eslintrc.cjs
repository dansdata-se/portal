module.exports = {
  extends: [
    "plugin:@typescript-eslint/recommended-type-checked",
    "plugin:@typescript-eslint/stylistic-type-checked",
    "plugin:@typescript-eslint/strict",
    "next/core-web-vitals",
    "prettier",
  ],
  parser: "@typescript-eslint/parser",
  plugins: ["@typescript-eslint"],
  parserOptions: {
    project: true,
    tsconfigRootDir: __dirname,
  },
  root: true,
  rules: {
    eqeqeq: "error",
    "no-restricted-imports": [
      "error",
      {
        patterns: [{ group: ["/.*"], message: "Use `@/` for local imports." }],
        paths: [
          {
            name: "process",
            importNames: ["env"],
            message:
              'Use `import env from "@/env"` to access environment variables.',
          }
        ],
      },
    ],
  },
};
