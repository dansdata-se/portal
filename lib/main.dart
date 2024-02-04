import "dart:async";

import "package:dansdata_portal/app/app.dart";
import "package:dansdata_portal/dependency_injection/dependencies.dart";
import "package:dansdata_portal/dependency_injection/injectable.dart";
import "package:firebase_crashlytics/firebase_crashlytics.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_web_plugins/url_strategy.dart";
import "package:get_it/get_it.dart";

final GetIt _injector = GetIt.asNewInstance();

Future<void> main() async {
  await _setup();
  runApp(
    Dependencies(injector: _injector, child: const MyApp()),
  );
}

Future<void> _setup() async {
  // Must be done _before_ setting up DI!
  if (kIsWeb) usePathUrlStrategy();

  await configureDependencyInjection(injector: _injector);
  _addCrashlyticsListeners(_injector.get());
  _configureFonts();
}

void _addCrashlyticsListeners(FirebaseCrashlytics crashlytics) {
  // Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = crashlytics.recordFlutterFatalError;
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    unawaited(crashlytics.recordError(error, stack, fatal: true));
    return true;
  };
}

void _configureFonts() {
  LicenseRegistry.addLicense(() async* {
    yield LicenseEntryWithLineBreaks(
      ["assets/fonts"],
      await rootBundle.loadString("fonts/Norican.OFL.txt"),
    );
    yield LicenseEntryWithLineBreaks(
      ["assets/fonts"],
      await rootBundle.loadString("fonts/RobotoFlex.OFL.txt"),
    );
  });
}
