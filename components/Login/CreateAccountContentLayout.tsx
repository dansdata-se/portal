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

function CreateAccountContentLayout({ tPage }: { tPage: TFunction }) {
  const { t: tCommon } = useTranslation("common");
  const { t: tLoginCommon } = useTranslation("login/common");

  const supabaseClient = useSupabaseClient<Database>();

  const emailRef = useRef<HTMLInputElement>(null);
  const passwordRef = useRef<HTMLInputElement>(null);
  const [passwordVisible, setPasswordVisible] = useState(false);
  const passwordConfirmRef = useRef<HTMLInputElement>(null);
  const [passwordConfirmVisible, setPasswordConfirmVisible] = useState(false);
  const [isLoading, setLoading] = useState(false);

  useEventListener("beforeunload", () => {
    if (isLoading) {
      return tCommon("onbeforeunload-generic-message");
    }
  });

  function createAccount() {
    if (isLoading) return;

    let isValid = true;
    isValid = (emailRef.current?.reportValidity() ?? false) && isValid;
    isValid = (passwordRef.current?.reportValidity() ?? false) && isValid;
    isValid =
      (passwordConfirmRef.current?.reportValidity() ?? false) && isValid;
    if (passwordRef.current?.value !== passwordConfirmRef.current?.value) {
      isValid = false;
      passwordConfirmRef.current?.setCustomValidity(
        tLoginCommon("error-passwords-do-not-match")
      );
      passwordConfirmRef.current?.reportValidity();
    }
    if (!isValid) return;

    const email = (emailRef.current as HTMLInputElement).value;
    const password = (passwordRef.current as HTMLInputElement).value;

    setLoading(true);
    supabaseClient.auth
      .signUp({
        email,
        password,
      })
      .then((response) => {
        if (!response.error) return;

        // Continue loading indication if account creation was successful
        setLoading(false);

        if (/password/i.test(response.error.message)) {
          passwordRef.current?.setCustomValidity(response.error.message);
          passwordRef.current?.reportValidity();
        } else {
          emailRef.current?.setCustomValidity(response.error.message);
          emailRef.current?.reportValidity();
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
          createAccount();
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
        <TextField
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
        <TextField
          ref={passwordConfirmRef}
          className="w-full"
          variant="outlined"
          label={tLoginCommon("label-password-confirm")}
          type={passwordConfirmVisible ? "singlelineText" : "password"}
          trailing={
            <button
              type="button"
              onClick={() => setPasswordConfirmVisible((visible) => !visible)}
            >
              {passwordConfirmVisible ? <EyeOff /> : <Eye />}
            </button>
          }
          required
        />
        <CircularProgressButton
          className="w-full"
          variant="filled"
          type="submit"
          text={tLoginCommon("button-create-account")}
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
        <NavLink destination={Nav().Login}>
          <Button
            className="w-full"
            variant="text"
            text={tLoginCommon("button-log-in")}
          />
        </NavLink>
      </div>
    </>
  );
}

export default CreateAccountContentLayout;
