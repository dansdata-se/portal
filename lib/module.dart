import "package:dansdata_portal/firebase/crashlytics_logger.dart";
import "package:firebase_crashlytics/firebase_crashlytics.dart";
import "package:injectable/injectable.dart";
import "package:logger/logger.dart";

@module
abstract class GlobalModule {
  @singleton
  Logger logger(FirebaseCrashlytics crashlytics) => Logger(
        printer: PrettyPrinter(),
        output: MultiOutput([
          ConsoleOutput(),
          CrashlyticsLogger(crashlytics: crashlytics),
        ]),
      );
}
