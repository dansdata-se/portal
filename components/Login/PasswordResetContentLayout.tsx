import { useSupabaseClient } from "@supabase/auth-helpers-react";
import Button from "components/Button";
import CircularProgressButton from "components/Button/Progress/Circular";
import TextField from "components/TextField";
import Nav from "navigation/Nav";
import NavLink from "navigation/NavLink";
import { useRef, useState } from "react";
import { TFunction, useTranslation } from "react-i18next";
import { Database } from "types/supabase";
import { useEventListener } from "usehooks-ts";

function PasswordResetContentLayout({ tPage }: { tPage: TFunction }) {
  const { t: tCommon } = useTranslation("common");
  const { t: tLoginCommon } = useTranslation("login/common");

  const supabaseClient = useSupabaseClient<Database>();

  const emailRef = useRef<HTMLInputElement>(null);
  const [didSend, setDidSend] = useState(false);

  useEventListener("beforeunload", () => {
    if (didSend) {
      return tCommon("onbeforeunload-generic-message");
    }
  });

  function sendResetEmail() {
    if (didSend) return;

    let isValid = true;
    isValid = (emailRef.current?.reportValidity() ?? false) && isValid;
    if (!isValid) return;

    const email = (emailRef.current as HTMLInputElement).value;

    setDidSend(true);
    supabaseClient.auth.resetPasswordForEmail(email, {
      redirectTo: new URL(Nav().secure.Index.href, document.baseURI).toString(),
    });
  }

  return (
    <>
      <h1>{tPage("page-title")}</h1>
      {didSend ? (
        <span>{tPage("reset-link-sent")}</span>
      ) : (
        <form
          className="flex flex-col gap-4 w-full max-w-sm"
          noValidate
          onSubmit={(e) => {
            e.preventDefault();
            sendResetEmail();
          }}
        >
          <TextField
            ref={emailRef}
            className="w-full"
            variant="outlined"
            label={tLoginCommon("label-email")}
            type="email"
            required
          />
          <CircularProgressButton
            className="w-full"
            variant="filled"
            type="submit"
            text={tLoginCommon("button-reset-password")}
            disabled={didSend}
            loading={didSend}
          />
        </form>
      )}
      <div className="grid grid-cols-2 gap-2 mt-4">
        <NavLink destination={Nav().Login}>
          <Button
            className="w-full"
            variant="text"
            text={tLoginCommon("button-log-in")}
          />
        </NavLink>
        <NavLink destination={Nav().CreateAccount}>
          <Button
            className="w-full"
            variant="text"
            text={tLoginCommon("button-create-account")}
          />
        </NavLink>
      </div>
    </>
  );
}

export default PasswordResetContentLayout;
