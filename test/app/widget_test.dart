import "package:dansdata_portal/app/app.dart";
import "package:dansdata_portal/app/context.dart";
import "package:dansdata_portal/dependency_injection/dependencies.dart";
import "package:dansdata_portal/dependency_injection/singleton_component.dart"
    as singleton_component;
import "package:flutter_test/flutter_test.dart";
import "package:get_it/get_it.dart";

void main() {
  testWidgets("Navigation smoke test", (WidgetTester tester) async {
    GetIt injector = GetIt.asNewInstance();
    await singleton_component.register(injector);

    await tester.pumpWidget(
      Dependencies(injector: injector, child: const MyApp()),
    );

    final appContext = injector.get<ApplicationContext>();

    expect(find.text("Dashboard Page"), findsOneWidget);
    expect(
      appContext.appTitle.value,
      appContext.l10n.value.appTitleDashboard,
    );

    await tester.tap(find.text(appContext.l10n.value.appTitleAccount));
    await tester.pump();

    expect(find.text("Account Page"), findsOneWidget);
    expect(
      appContext.appTitle.value,
      appContext.l10n.value.appTitleAccount,
    );

    await tester.tap(find.text(appContext.l10n.value.appTitleDashboard));
    await tester.pump();

    expect(find.text("Dashboard Page"), findsOneWidget);
    expect(
      appContext.appTitle.value,
      appContext.l10n.value.appTitleDashboard,
    );
  });
}
