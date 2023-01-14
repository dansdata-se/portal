import "package:go_router/go_router.dart";

/// Allows tests to navigate a [router] without interacting with the widget
/// tree.
void navigateTestRouter(GoRouter router, String destination) {
  GoRouter.of(router.routerDelegate.navigatorKey.currentContext!)
      .go(destination);
}
