import "dart:async";
import "dart:io";

import "package:firebase_crashlytics/firebase_crashlytics.dart";
import "package:flutter/foundation.dart";
import "package:logger/logger.dart";

class CrashlyticsLogger extends LogOutput {
  CrashlyticsLogger({required this.crashlytics});

  final FirebaseCrashlytics crashlytics;

  @override
  void output(OutputEvent event) {
    if (!kIsWeb && Platform.environment.containsKey("FLUTTER_TEST")) return;

    unawaited(crashlytics.log(event.lines.join("\n")));
    if (event.level case Level.error || Level.fatal) {
      unawaited(
        crashlytics.recordError(
          event.origin.error,
          event.origin.stackTrace,
          // Fatal errors are not likely to reach the Logger.
          fatal: false,
        ),
      );
    }
  }
}
