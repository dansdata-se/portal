import "package:dansdata_portal/app/context.dart";
import "package:dansdata_portal/app/dashboard/page.dart";
import "package:dansdata_portal/app/view_model/view_model.dart";

class AccountViewModel extends ViewModel {
  AccountViewModel({required this.appContext});

  final ApplicationContext appContext;

  @override
  void init() {
    super.init();
    appContext.appTitle.value = "Account";
  }

  void gotoDashboard() => appContext.router.value.go(DashboardPage.route.path);
}
