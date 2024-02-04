import "package:dansdata_portal/dependency_injection/environments.dart";
import "package:firebase_analytics/firebase_analytics.dart";
import "package:firebase_crashlytics/firebase_crashlytics.dart";
import "package:firebase_performance/firebase_performance.dart";
import "package:injectable/injectable.dart";

import "analytics.mocks.dart";
import "crashlytics.mocks.dart";
import "performance.mocks.dart";

@module
abstract class FirebaseMocksModule {
  @widgetTest
  @unitTest
  FirebaseAnalytics get analytics => MockFirebaseAnalytics();

  @widgetTest
  @unitTest
  FirebaseCrashlytics get crashlytics => MockFirebaseCrashlytics();

  @widgetTest
  @unitTest
  FirebasePerformance get performance => MockFirebasePerformance();
}
