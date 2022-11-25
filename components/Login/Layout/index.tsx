import Footer from "components/Footer";
import Header from "components/Header";
import { Destination } from "navigation/Nav";
import Image from "next/future/image";
import { ReactNode } from "react";
import { useIsFirstRender, useMediaQuery } from "usehooks-ts";

function LoginLayout({
  currentDestination,
  children,
}: {
  currentDestination: Destination;
  children: ReactNode;
}) {
  // Check for first render to avoid state differences between SSR and client.
  const isFirst = useIsFirstRender();
  // Force small footer when image squishes the left-hand bar too much.
  const forceSmallFooter = useMediaQuery(
    "((min-width: 768px) and (max-width: 1150px)) or ((min-width: 1280px) and (max-width: 1700px))"
  );

  return (
    <div className="flex min-h-full flex-row items-stretch">
      <div className="relative flex min-h-full flex-col w-full md:w-1/2 xl:w-1/3">
        <Header currentDestination={currentDestination} />
        <div className="h-8 grow"></div>
        <main className="prose grow mx-auto px-4 w-full max-w-sm">
          {children}
        </main>
        <div className="h-8 grow"></div>
        <Footer forceSmall={!isFirst && forceSmallFooter} />
      </div>
      <div className="relative overflow-hidden flex-grow hidden md:block">
        <Image
          priority={true}
          className="object-cover"
          src="/images/dansbana.webp"
          alt=""
          fill
        />
      </div>
    </div>
  );
}

export default LoginLayout;
