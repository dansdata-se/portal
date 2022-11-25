import { useSupabaseClient } from "@supabase/auth-helpers-react";
import Button from "components/Button";
import CircularProgressButton from "components/Button/Progress/Circular";
import TextField from "components/TextField";
import Nav from "navigation/Nav";
import NavLink from "navigation/NavLink";
import { useRef, useState } from "react";
import { Eye, EyeOff } from "react-feather";
import { TFunction, useTranslation } from "react-i18next";
import { Database } from "types/supabase";
import { useEventListener } from "usehooks-ts";

function LoginContentLayout({ tPage }: { tPage: TFunction }) {
  const { t: tCommon } = useTranslation("common");
  const { t: tLoginCommon } = useTranslation("login/common");

  const supabaseClient = useSupabaseClient<Database>();

  const emailRef = useRef<HTMLInputElement>(null);
  const passwordRef = useRef<HTMLInputElement>(null);
  const [passwordVisible, setPasswordVisible] = useState(false);
  const [isLoading, setLoading] = useState(false);

  useEventListener("beforeunload", () => {
    if (isLoading) {
      return tCommon("onbeforeunload-generic-message");
    }
  });

  function login() {
    if (isLoading) return;

    let isValid = true;
    isValid = (emailRef.current?.reportValidity() ?? false) && isValid;
    isValid = (passwordRef.current?.reportValidity() ?? false) && isValid;
    if (!isValid) return;

    const email = (emailRef.current as HTMLInputElement).value;
    const password = (passwordRef.current as HTMLInputElement).value;

    setLoading(true);
    supabaseClient.auth
      .signInWithPassword({
        email,
        password,
      })
      .then((response) => {
        if (!response.error) return;

        // Continue loading indication if login was successful
        setLoading(false);

        if (/e.?mail/i.test(response.error.message)) {
          emailRef.current?.setCustomValidity(response.error.message);
          emailRef.current?.reportValidity();
        } else {
          passwordRef.current?.setCustomValidity(response.error.message);
          passwordRef.current?.reportValidity();
        }
      });
  }

  return (
    <>
      <h1>{tPage("page-title")}</h1>
      <form
        className="flex flex-col gap-4 w-full max-w-sm"
        noValidate
        onSubmit={(e) => {
          e.preventDefault();
          login();
        }}
      >
        <TextField
          id="email"
          ref={emailRef}
          className="w-full"
          variant="outlined"
          label={tLoginCommon("label-email")}
          type="email"
          required
        />
        <TextField
          id="password"
          ref={passwordRef}
          className="w-full"
          variant="outlined"
          label={tLoginCommon("label-password")}
          type={passwordVisible ? "singlelineText" : "password"}
          trailing={
            <button
              type="button"
              onClick={() => setPasswordVisible((visible) => !visible)}
            >
              {passwordVisible ? <EyeOff /> : <Eye />}
            </button>
          }
          required
        />
        <CircularProgressButton
          className="w-full"
          variant="filled"
          type="submit"
          text={tLoginCommon("button-log-in")}
          disabled={isLoading}
          loading={isLoading}
        />
      </form>
      <div className="grid grid-cols-2 gap-2 mt-4">
        <NavLink destination={Nav().PasswordReset}>
          <Button
            className="w-full"
            variant="text"
            text={tLoginCommon("button-reset-password")}
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

export default LoginContentLayout;
