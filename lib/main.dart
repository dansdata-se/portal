import "package:dansdata_portal/app/app.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";

void main() {
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

  runApp(const MyApp());
}
