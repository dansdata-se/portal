import "dart:io";

import "package:flutter/foundation.dart";
import "package:injectable/injectable.dart";

const android = Environment("android");
const ios = Environment("ios");
const web = Environment("web");

const widgetTest = Environment("widgetTest");
const unitTest = Environment("unitTest");

String resolveEnvironment({
  String? environmentOverride,
}) {
  if (environmentOverride != null) return environmentOverride;
  if (kIsWeb) return web.name;
  if (Platform.isAndroid) return android.name;
  if (Platform.isIOS) return ios.name;
  throw UnsupportedError("Unknown platform is not supported!");
}
