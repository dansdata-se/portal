import "package:dansdata_portal/app/context.dart";
import "package:dansdata_portal/app/routing/navigation_service.dart";
import "package:get_it/get_it.dart";
import "package:logger/logger.dart";

const scopeName = "SingletonScope";

void register(GetIt getIt) {
  getIt
    ..pushNewScope(scopeName: scopeName)
    // Registrations
    ..registerSingleton(
      Logger(
        printer: PrettyPrinter(),
      ),
    )
    ..registerSingleton(ApplicationContext(logger: getIt.get()))
    ..registerSingleton(NavigationService());
}
