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
    singleton_component.register(injector);

    await tester.pumpWidget(
      Dependencies(injector: injector, child: const MyApp()),
    );

    expect(find.text("Dashboard Page"), findsOneWidget);
    expect(
      injector.get<ApplicationContext>().appTitle.value,
      equals("Dashboard"),
    );

    await tester.tap(find.text("Account"));
    await tester.pump();

    expect(find.text("Account Page"), findsOneWidget);
    expect(
      injector.get<ApplicationContext>().appTitle.value,
      equals("Account"),
    );

    await tester.tap(find.text("Dashboard"));
    await tester.pump();

    expect(find.text("Dashboard Page"), findsOneWidget);
    expect(
      injector.get<ApplicationContext>().appTitle.value,
      equals("Dashboard"),
    );
  });
}
