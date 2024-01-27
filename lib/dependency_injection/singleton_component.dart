import "package:dansdata_portal/app/context.dart";
import "package:dansdata_portal/app/l10n/localization_service.dart";
import "package:dansdata_portal/app/routing/navigation_service.dart";
import "package:get_it/get_it.dart";
import "package:logger/logger.dart";

const scopeName = "SingletonScope";

Future<void> register(GetIt getIt) async {
  getIt
    ..pushNewScope(scopeName: scopeName)
    // Registrations
    ..registerSingleton(
      Logger(
        printer: PrettyPrinter(),
      ),
    )
    ..registerSingleton(ApplicationContext())
    ..registerSingleton(NavigationService())
    ..registerSingletonAsync(
      () => LocalizationService.initialize(logger: getIt.get()),
    );

  await getIt.allReady();
}
