import "dart:async";

import "package:dansdata_portal/app/account/page.dart";
import "package:dansdata_portal/app/dashboard/page.dart";
import "package:dansdata_portal/app/routing/router.dart";
import "package:firebase_analytics/firebase_analytics.dart";
import "package:flutter/scheduler.dart";
import "package:go_router/go_router.dart";
import "package:injectable/injectable.dart";
import "package:logger/logger.dart";
import "package:signals/signals.dart";

@singleton
@injectable
class NavigationService {
  NavigationService({
    required Logger logger,
    required FirebaseAnalytics analytics,
  }) {
    _NavigationLogger(
      logger: logger,
      analytics: analytics,
      router: router,
    ).enableNavigationLogging();
  }

  final Signal<GoRouter> router = signal(mainRouter);

  void goToDashboard() => router.value.go(DashboardPage.route.path);

  void goToAccount() => router.value.go(AccountPage.route.path);
}

class _NavigationLogger {
  _NavigationLogger({
    required Logger logger,
    required FirebaseAnalytics analytics,
    required ReadonlySignal<GoRouter> router,
  })  : _logger = logger,
        _analytics = analytics,
        _router = router;

  final Logger _logger;
  final FirebaseAnalytics _analytics;
  final ReadonlySignal<GoRouter> _router;
  late final Signal<({Uri? previous, Uri current})> _routerUri = signal(
    (
      previous: null,
      current: _router.value.routeInformationProvider.value.uri,
    ),
  );

  void enableNavigationLogging() {
    _attachRouterNotificationListener();
    _attachNavigationLogger();
  }

  void _attachRouterNotificationListener() {
    GoRouter? previousRouter;
    effect(() {
      previousRouter?.routerDelegate.removeListener(_onRouterNotification);
      _router.value.routerDelegate.addListener(_onRouterNotification);

      untracked(_updateRouterUri);

      previousRouter = _router.value;
    });
  }

  void _onRouterNotification() =>
      SchedulerBinding.instance.addPostFrameCallback((_) => _updateRouterUri());

  void _updateRouterUri() {
    final previous = _routerUri.value.current;
    final current = _router.value.routeInformationProvider.value.uri;
    if (previous != current) {
      _routerUri.value = (previous: previous, current: current);
    }
  }

  void _attachNavigationLogger() {
    effect(() {
      final (:previous, :current) = _routerUri.value;

      _logger.t("Navigation: $previous -> $current");

      // Ignore parameter changes when notifying analytics.
      if (previous?.path != current.path) {
        unawaited(_analytics.logScreenView(screenName: current.path));
      }
    });
  }
}
