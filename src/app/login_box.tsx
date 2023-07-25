import api from "@/api";
import logger from "@/logger";
import classNames from "classnames";
import { useCallback, useState } from "react";

export default function LoginBox({
  onLogin,
}: {
  onLogin: (authToken: string) => void;
}) {
  const [authToken, setAuthToken] = useState("");
  const [isLoggingIn, setLoggingIn] = useState(false);
  const [didLoginFail, setLoginFailed] = useState(false);

  const pingApi = useCallback(async () => {
    setLoggingIn(true);
    try {
      await api.auth.ping(authToken);
      onLogin(authToken);
    } catch (e) {
      setLoginFailed(true);
      logger.debug(e, "ping failed");
    } finally {
      setLoggingIn(false);
    }
  }, [authToken, onLogin]);

  return (
    <section className="grow py-12 flex items-center mb-24">
      <div className="container prose text-center">
        <h2>Logga in</h2>
        <form
          className="join join-vertical w-full max-w-xs"
          onSubmit={(e) => {
            e.preventDefault();
            void pingApi();
          }}
        >
          <input
            type="password"
            placeholder="Lösenord"
            className={classNames(
              "input input-bordered w-full join-item transition-all",
              {
                "input-error": didLoginFail,
              }
            )}
            onChange={(e) => {
              setLoginFailed(false);
              setAuthToken(e.target.value);
            }}
            value={authToken}
            disabled={isLoggingIn}
            required
          />
          <button
            type="submit"
            className="btn btn-primary join-item"
            disabled={isLoggingIn || didLoginFail}
          >
            {!isLoggingIn && "Logga in"}
            {isLoggingIn && <div className="loading loading-dots loading-sm" />}
          </button>
        </form>
      </div>
    </section>
  );
}
