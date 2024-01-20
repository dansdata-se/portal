import "package:dansdata_portal/app/account/page.dart";
import "package:dansdata_portal/app/context.dart";
import "package:dansdata_portal/app/view_model/view_model.dart";

class DashboardViewModel extends ViewModel {
  DashboardViewModel({required this.appContext});

  final ApplicationContext appContext;

  @override
  void init() {
    super.init();
    appContext.appTitle.value = "Dashboard";
  }

  void gotoAccount() => appContext.router.value.go(AccountPage.route.path);
}
