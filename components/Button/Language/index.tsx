import Button, { ButtonAttributes } from "components/Button";
import { GB as FlagGB, SE as FlagSE } from "country-flag-icons/react/3x2";
import Link from "next/link";
import { useRouter } from "next/router";
import { ButtonHTMLAttributes } from "react";
import { useTranslation } from "react-i18next";

/**
 * {@link Button} with logic for changing the current language.
 */
function LanguageButton({
  variant,
  ...props
}: Pick<ButtonAttributes, "variant"> &
  ButtonHTMLAttributes<HTMLButtonElement>) {
  const router = useRouter();
  const { t: tCommon } = useTranslation("common");
  return (
    <Link
      href="./"
      locale={router.locale === "en" ? "sv" : "en"}
    >
      <Button
        {...props}
        variant={variant}
        text={tCommon("change-locale")}
        icon={router.locale === "en" ? <FlagSE /> : <FlagGB />}
      />
    </Link>
  );
}

export default LanguageButton;
