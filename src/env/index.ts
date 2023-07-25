import { envsafe, str } from "envsafe";

/**
 * Used for environment variables representing e.g. passwords or other
 * credential tokens that should not be shared in git and where a local
 * development fallback is not possible.
 *
 * An example of this is image storage. We use Cloudflare for our images.
 * However, our Cloudflare credentials should not be shared in git and we
 * cannot provide "development credentials" for anyone cloning the code from
 * GitHub either.
 *
 * When this variable is used, it is to ensure that the application will remain
 * runnable in a local development environment, even if that means some features
 * are disabled and using some sort of fallback. Variables where such fallbacks
 * simply are not possible should not use this variable.
 */
export const DEV_UNSET = "{unset_envvar}";

// Should NOT include `process.env.NODE_ENV` as the compiler
// is not smart enough to remove just `env.NODE_ENV` during build.
export default envsafe({
  AUTH_KEY: str({
    devDefault: "passw0rd",
  }),
  CLOUDFLARE_ACCOUNT_ID: str({
    devDefault: DEV_UNSET,
  }),
  CLOUDFLARE_API_TOKEN: str({
    devDefault: DEV_UNSET,
  }),
  CLOUDFLARE_ACCOUNT_HASH: str({
    devDefault: DEV_UNSET,
  }),
  LOG_LEVEL: str({
    devDefault: "debug",
    default: "info",
    choices: ["trace", "debug", "info", "warn", "error", "fatal", "silent"],
  }),
});
