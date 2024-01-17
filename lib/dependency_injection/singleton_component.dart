import "package:get_it/get_it.dart";

const scopeName = "SingletonScope";

void register(GetIt getIt) {
  getIt.pushNewScope(scopeName: scopeName);

  // Registrations
}
