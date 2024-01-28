import "package:dansdata_portal/app/context.dart";
import "package:dansdata_portal/app/l10n/localization_service.dart";
import "package:dansdata_portal/app/routing/navigation_service.dart";
import "package:dansdata_portal/firebase/crashlytics_logger.dart";
import "package:firebase_analytics/firebase_analytics.dart";
import "package:firebase_crashlytics/firebase_crashlytics.dart";
import "package:get_it/get_it.dart";
import "package:logger/logger.dart";

const scopeName = "SingletonScope";

Future<void> register(
  GetIt getIt,
  FirebaseAnalytics analytics,
  FirebaseCrashlytics crashlytics,
) async {
  getIt
    ..pushNewScope(scopeName: scopeName)
    // Registrations
    ..registerSingleton<FirebaseAnalytics>(analytics)
    ..registerSingleton<FirebaseCrashlytics>(crashlytics)
    ..registerSingleton(
      Logger(
        printer: PrettyPrinter(),
        output: MultiOutput([
          ConsoleOutput(),
          CrashlyticsLogger(crashlytics: getIt.get()),
        ]),
      ),
    )
    ..registerSingleton(ApplicationContext())
    ..registerSingleton(
      NavigationService(
        logger: getIt.get(),
        analytics: getIt.get(),
      ),
    )
    ..registerSingletonAsync(
      () => LocalizationService.initialize(logger: getIt.get()),
    );

  await getIt.allReady(timeout: const Duration(seconds: 5));
}
