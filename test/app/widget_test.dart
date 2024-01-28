import "package:dansdata_portal/app/app.dart";
import "package:dansdata_portal/app/context.dart";
import "package:dansdata_portal/app/l10n/localization_service.dart";
import "package:dansdata_portal/dependency_injection/dependencies.dart";
import "package:dansdata_portal/dependency_injection/singleton_component.dart"
    as singleton_component;
import "package:firebase_analytics/firebase_analytics.dart";
import "package:firebase_crashlytics/firebase_crashlytics.dart";
import "package:firebase_performance/firebase_performance.dart";
import "package:flutter_test/flutter_test.dart";
import "package:get_it/get_it.dart";
import "package:mockito/annotations.dart";

import "widget_test.mocks.dart";

@GenerateNiceMocks([
  MockSpec<FirebaseAnalytics>(),
  MockSpec<FirebaseCrashlytics>(),
  MockSpec<FirebasePerformance>(),
])
void main() {
  late FirebaseAnalytics analytics;
  late FirebaseCrashlytics crashlytics;
  late FirebasePerformance performance;

  setUp(() {
    analytics = MockFirebaseAnalytics();
    crashlytics = MockFirebaseCrashlytics();
    performance = MockFirebasePerformance();
  });

  testWidgets("Navigation smoke test", (WidgetTester tester) async {
    GetIt injector = GetIt.asNewInstance();
    await singleton_component.register(
      injector,
      analytics,
      crashlytics,
      performance,
    );

    await tester.pumpWidget(
      Dependencies(injector: injector, child: const MyApp()),
    );

    final appContext = injector.get<ApplicationContext>();
    final localizationService = injector.get<LocalizationService>();

    expect(find.text("Dashboard Page"), findsOneWidget);
    expect(
      appContext.appTitle.value,
      localizationService.l10n.value.appTitleDashboard,
    );

    await tester.tap(find.text(localizationService.l10n.value.appTitleAccount));
    await tester.pump();

    expect(find.text("Account Page"), findsOneWidget);
    expect(
      appContext.appTitle.value,
      localizationService.l10n.value.appTitleAccount,
    );

    await tester
        .tap(find.text(localizationService.l10n.value.appTitleDashboard));
    await tester.pump();

    expect(find.text("Dashboard Page"), findsOneWidget);
    expect(
      appContext.appTitle.value,
      localizationService.l10n.value.appTitleDashboard,
    );
  });
}
