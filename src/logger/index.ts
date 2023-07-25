import env from "@/env";
import pino, { Logger } from "pino";

const logger: Logger = pino({
  level: env.LOG_LEVEL,
});

export default logger.child({
  dansdata: {
    version: {
      package: {
        // eslint-disable-next-line @typescript-eslint/no-unsafe-member-access, @typescript-eslint/no-var-requires
        name: require("@/../package.json").name as string,
        // eslint-disable-next-line @typescript-eslint/no-unsafe-member-access, @typescript-eslint/no-var-requires
        version: require("@/../package.json").version as string,
      },
    },
  },
});
