import "package:dansdata_portal/app/app.dart";
import "package:dansdata_portal/dependency_injection/dependencies.dart";
import "package:dansdata_portal/dependency_injection/singleton_component.dart"
    as singleton_component;
import "package:dansdata_portal/firebase/firebase_crashlytics_stub.dart";
import "package:dansdata_portal/firebase_options.dart";
import "package:firebase_analytics/firebase_analytics.dart";
import "package:firebase_core/firebase_core.dart";
import "package:firebase_crashlytics/firebase_crashlytics.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_web_plugins/url_strategy.dart";
import "package:get_it/get_it.dart";

Future<void> main() async {
  await _setup();
  runApp(
    Dependencies(injector: GetIt.instance, child: const MyApp()),
  );
}

Future<void> _setup() async {
  final (analytics, crashlytics) = await _configureFirebase();
  usePathUrlStrategy();
  _configureFonts();
  await singleton_component.register(
    GetIt.instance,
    analytics,
    crashlytics,
  );
}

Future<(FirebaseAnalytics, FirebaseCrashlytics)> _configureFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();
  final app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final analytics = FirebaseAnalytics.instance;
  final crashlytics =
      kIsWeb ? FirebaseCrashlyticsStub(app: app) : FirebaseCrashlytics.instance;

  // Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = crashlytics.recordFlutterFatalError;
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    crashlytics.recordError(error, stack, fatal: true);
    return true;
  };

  return (analytics, crashlytics);
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
