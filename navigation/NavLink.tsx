import Link from "next/link";
import { useRouter } from "next/router";
import { ReactNode } from "react";
import { Destination } from "./Nav";

/**
 * Wrapper for {@link Link} that preserves the current locale when navigating.
 */
function NavLink({
  destination,
  children,
}: {
  destination: Destination;
  children: ReactNode;
}) {
  const router = useRouter();
  return (
    <Link
      href={destination.href}
      locale={router.locale}
    >
      {children}
    </Link>
  );
}

export default NavLink;
