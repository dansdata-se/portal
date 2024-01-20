import "package:dansdata_portal/app/context.dart";
import "package:get_it/get_it.dart";

const scopeName = "SingletonScope";

void register(GetIt getIt) {
  getIt
    ..pushNewScope(scopeName: scopeName)
    // Registrations
    ..registerSingleton(ApplicationContext(injector: getIt));
}
