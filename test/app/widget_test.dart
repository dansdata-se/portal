import "package:dansdata_portal/app/app.dart";
import "package:dansdata_portal/app/context.dart";
import "package:dansdata_portal/app/l10n/localization_service.dart";
import "package:dansdata_portal/dependency_injection/dependencies.dart";
import "package:dansdata_portal/dependency_injection/environments.dart";
import "package:flutter_test/flutter_test.dart";
import "package:get_it/get_it.dart";

import "../dependency_injection/injectable.dart";

void main() {
  testWidgets("Navigation smoke test", (WidgetTester tester) async {
    GetIt injector = GetIt.asNewInstance();
    await configureTestDependencyInjection(
      injector: injector,
      environment: widgetTest.name,
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
