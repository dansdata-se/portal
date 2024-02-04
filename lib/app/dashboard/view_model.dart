import "package:dansdata_portal/app/context.dart";
import "package:dansdata_portal/app/l10n/localization_service.dart";
import "package:dansdata_portal/app/routing/navigation_service.dart";
import "package:dansdata_portal/app/view_model/view_model.dart";
import "package:signals/signals.dart";

class DashboardViewModel extends ViewModel {
  DashboardViewModel({
    required ApplicationContext appContext,
    required LocalizationService localizationService,
    required NavigationService navigationService,
  })  : _appContext = appContext,
        _localizationService = localizationService,
        _navigationService = navigationService;

  final ApplicationContext _appContext;
  final LocalizationService _localizationService;
  final NavigationService _navigationService;

  late final Computed<String> buttonText =
      computed(() => _localizationService.l10n.value.appTitleAccount);

  @override
  void initGlobalState() {
    super.initGlobalState();

    viewModelEffect(() {
      _appContext.appTitle.value =
          _localizationService.l10n.value.appTitleDashboard;
    });
  }

  void goToAccount() => _navigationService.goToAccount();
}
