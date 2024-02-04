import "package:dansdata_portal/dependency_injection/environments.dart";
import "package:dansdata_portal/dependency_injection/injectable.config.dart";
import "package:get_it/get_it.dart";
import "package:injectable/injectable.dart";

@InjectableInit(
  preferRelativeImports: false,
  asExtension: true,
  usesNullSafety: true,
  throwOnMissingDependencies: true,
  rootDir: "..",
)
Future<void> configureDependencyInjection({
  required GetIt injector,
  String? environmentOverride,
}) =>
    injector.init(
      environment: resolveEnvironment(
        environmentOverride: environmentOverride,
      ),
    );
