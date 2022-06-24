import { Html, Head, Main, NextScript } from "next/document";

export default function Document() {
  return (
    <Html>
      <Head>
        <meta charSet="UTF-8" />
        <link
          rel="apple-touch-icon"
          sizes="180x180"
          href="/apple-touch-icon.png?v=1"
        />
        <link
          rel="icon"
          type="image/png"
          sizes="32x32"
          href="/favicon-32x32.png?v=1"
        />
        <link
          rel="icon"
          type="image/png"
          sizes="16x16"
          href="/favicon-16x16.png?v=1"
        />
        <link
          rel="manifest"
          href="/site.webmanifest?v=1"
        />
        <link
          rel="mask-icon"
          href="/safari-pinned-tab.svg?v=1"
          color="#006877"
        />
        <link
          rel="shortcut icon"
          href="/favicon.ico?v=1"
        />
        <meta
          name="msapplication-TileColor"
          content="#006877"
        />
        <meta
          name="theme-color"
          content="#006877"
        />
        <link
          href="https://fonts.googleapis.com/css2?family=Norican&family=Roboto+Flex:opsz@8..144&display=swap"
          rel="stylesheet"
        />
      </Head>
      <body>
        <Main />
        <NextScript />
      </body>
    </Html>
  );
}
