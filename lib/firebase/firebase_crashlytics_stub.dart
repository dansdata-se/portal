import "package:firebase_core/firebase_core.dart";
import "package:firebase_crashlytics/firebase_crashlytics.dart";
import "package:flutter/foundation.dart";

/// Stub for [FirebaseCrashlytics] as that library is not yet available on web.
class FirebaseCrashlyticsStub implements FirebaseCrashlytics {
  FirebaseCrashlyticsStub({required this.app});

  @override
  FirebaseApp app;

  @override
  Future<bool> checkForUnsentReports() async => false;

  @override
  void crash() {}

  @override
  Future<void> deleteUnsentReports() async {}

  @override
  Future<bool> didCrashOnPreviousExecution() async => false;

  @override
  bool get isCrashlyticsCollectionEnabled => false;

  @override
  Future<void> log(String message) async {}

  @override
  Map get pluginConstants => {
        isCrashlyticsCollectionEnabled: false,
      };

  @override
  Future<void> recordError(
    exception,
    StackTrace? stack, {
    reason,
    Iterable<Object> information = const [],
    bool? printDetails,
    bool fatal = false,
  }) async {}

  @override
  Future<void> recordFlutterError(
    FlutterErrorDetails flutterErrorDetails, {
    bool fatal = false,
  }) async {}

  @override
  Future<void> recordFlutterFatalError(
    FlutterErrorDetails flutterErrorDetails,
  ) async {}

  @override
  Future<void> sendUnsentReports() async {}

  @override
  Future<void> setCrashlyticsCollectionEnabled(bool enabled) async {}

  @override
  Future<void> setCustomKey(String key, Object value) async {}

  @override
  Future<void> setUserIdentifier(String identifier) async {}
}
