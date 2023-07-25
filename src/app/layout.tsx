import FileDropContextProvider from "@/app/file_drop_context";
import "@/app/globals.css";
import type { Metadata } from "next";
import { Norican, Roboto_Flex } from "next/font/google";

const norican = Norican({
  weight: "400",
  variable: "--font-norican",
  display: "swap",
  subsets: ["latin"],
});
const robotoFlex = Roboto_Flex({
  variable: "--font-roboto-flex",
  display: "swap",
  subsets: ["latin"],
  fallback: ["sans-serif"],
});

export const metadata: Metadata = {
  title: "Dansdata Portal",
  robots: "noindex",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="sv">
      <body className={`${norican.variable} ${robotoFlex.variable} font-sans`}>
        <FileDropContextProvider>{children}</FileDropContextProvider>
      </body>
    </html>
  );
}
