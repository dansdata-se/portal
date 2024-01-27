import "package:dansdata_portal/app/context.dart";
import "package:dansdata_portal/app/dashboard/page.dart";
import "package:dansdata_portal/app/view_model/view_model.dart";
import "package:signals/signals.dart";

class AccountViewModel extends ViewModel {
  AccountViewModel({required this.appContext});

  final ApplicationContext appContext;

  late final Computed<String> buttonText =
      computed(() => appContext.l10n.value.appTitleDashboard);

  @override
  void init() {
    super.init();
    viewModelEffect(() {
      appContext.appTitle.value = appContext.l10n.value.appTitleAccount;
    });
  }

  void gotoDashboard() => appContext.router.value.go(DashboardPage.route.path);
}
