import "package:dansdata_portal/dependency_injection/environments.dart";
import "package:dansdata_portal/firebase_options.dart";
import "package:firebase_analytics/firebase_analytics.dart";
import "package:firebase_core/firebase_core.dart";
import "package:firebase_crashlytics/firebase_crashlytics.dart";
import "package:firebase_performance/firebase_performance.dart";
import "package:flutter/widgets.dart";
import "package:injectable/injectable.dart";

@module
abstract class FirebaseModule {
  @android
  @ios
  @web
  @preResolve
  @singleton
  Future<FirebaseApp> get app {
    WidgetsFlutterBinding.ensureInitialized();
    return Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @android
  @ios
  @web
  @singleton
  FirebaseAnalytics analytics(FirebaseApp app) => FirebaseAnalytics.instance;

  @android
  @ios
  @singleton
  FirebaseCrashlytics crashlytics(FirebaseApp app) =>
      FirebaseCrashlytics.instance;

  @android
  @ios
  @web
  @singleton
  FirebasePerformance performance(FirebaseApp app) =>
      FirebasePerformance.instance;
}
