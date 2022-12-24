import "package:flutter/foundation.dart";
import "package:logger/logger.dart";
import "package:portal/main.dart";
import "package:portal/vercel/vercel_env.dart";

class DansdataLogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) =>
      kDebugMode || BuildConfig.vercelEnv != VercelEnv.production;
}
