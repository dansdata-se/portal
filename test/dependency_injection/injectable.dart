import "package:get_it/get_it.dart";
import "package:injectable/injectable.dart";

import "injectable.config.dart";

@InjectableInit(
  preferRelativeImports: true,
  asExtension: true,
  usesNullSafety: true,
  throwOnMissingDependencies: true,
  generateForDir: ["lib", "test"],
)
Future<void> configureTestDependencyInjection({
  required GetIt injector,
  required String environment,
}) =>
    injector.init(
      environment: environment,
    );
