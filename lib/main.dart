import "package:dansdata_portal/app/app.dart";
import "package:dansdata_portal/dependency_injection/dependencies.dart";
import "package:dansdata_portal/dependency_injection/singleton_component.dart"
    as singleton_component;
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
  usePathUrlStrategy();
  _configureFonts();
  await singleton_component.register(GetIt.instance);
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
