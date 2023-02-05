import "dart:io";

import "package:flutter/services.dart";
import "package:flutter_test/flutter_test.dart";
import "package:path/path.dart" show join;

class SupabaseBinding extends AutomatedTestWidgetsFlutterBinding {
  SupabaseBinding() {
    // Workaround for
    // ```
    // MissingPluginException(No implementation found for method getApplicationDocumentsDirectory on channel plugins.flutter.io/path_provider)
    // ```
    defaultBinaryMessenger.setMockMethodCallHandler(
      const MethodChannel("plugins.flutter.io/path_provider"),
      (_) async => join(testCachePath, "path_provider"),
    );
  }

  // Allow HTTP calls
  @override
  bool get overrideHttpClient => false;

  static final String testCachePath = join(
    Directory.systemTemp.path,
    "dansdata",
    "test_cache",
  );
}
