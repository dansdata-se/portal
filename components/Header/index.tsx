import DarkModeSwitch from "components/Switch/DarkMode";
import { Destination } from "navigation/Nav";
import { HTMLAttributes } from "react";
import HeaderBreadcrumbs from "./Breadcrumbs";

function Header({
  currentDestination,
  className,
  ...props
}: { currentDestination: Destination } & HTMLAttributes<HTMLElement>) {
  return (
    <header
      {...props}
      className={`flex flex-row items-center justify-between w-full py-2 px-4 ${className}`}
    >
      <HeaderBreadcrumbs currentDestination={currentDestination} />

      <DarkModeSwitch />
    </header>
  );
}

export default Header;
