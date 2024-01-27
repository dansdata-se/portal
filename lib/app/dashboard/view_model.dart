import "package:dansdata_portal/app/account/page.dart";
import "package:dansdata_portal/app/context.dart";
import "package:dansdata_portal/app/view_model/view_model.dart";
import "package:signals/signals.dart";

class DashboardViewModel extends ViewModel {
  DashboardViewModel({required this.appContext});

  final ApplicationContext appContext;

  late final Computed<String> buttonText =
      computed(() => appContext.l10n.value.appTitleAccount);

  @override
  void init() {
    super.init();
    viewModelEffect(() {
      appContext.appTitle.value = appContext.l10n.value.appTitleDashboard;
    });
  }

  void gotoAccount() => appContext.router.value.go(AccountPage.route.path);
}
