import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:portal/app/app.dart";
import "package:portal/app/app_module.dart";
import "package:provider/provider.dart";

/// A wrapper which configures an [AppModule]-based [MultiProvider] and a
/// [DansdataPortalApp] around a widget for testing.
class WidgetTestWrapper extends StatelessWidget {
  const WidgetTestWrapper({
    super.key,
    this.locale = const Locale("en"),
    required this.appModule,
    required this.child,
  });

  final Locale locale;
  final AppModule appModule;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: appModule.providers,
      child: DansdataPortalApp(
        routerConfig: GoRouter(
          initialLocation: "/",
          routes: [
            GoRoute(
              path: "/",
              builder: (context, state) => child,
            ),
          ],
        ),
      ),
    );
  }
}
