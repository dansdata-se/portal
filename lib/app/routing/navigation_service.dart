import "package:dansdata_portal/app/account/page.dart";
import "package:dansdata_portal/app/dashboard/page.dart";
import "package:dansdata_portal/app/routing/router.dart";
import "package:go_router/go_router.dart";
import "package:signals/signals.dart";

class NavigationService {
  final ReadonlySignal<GoRouter> router = signal(mainRouter);

  GoRouter get _router => router.value;

  void goToDashboard() => _router.go(DashboardPage.route.path);

  void goToAccount() => _router.go(AccountPage.route.path);
}
