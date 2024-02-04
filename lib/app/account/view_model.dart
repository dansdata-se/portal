import "package:dansdata_portal/app/context.dart";
import "package:dansdata_portal/app/l10n/localization_service.dart";
import "package:dansdata_portal/app/routing/navigation_service.dart";
import "package:dansdata_portal/app/view_model/view_model.dart";
import "package:signals/signals.dart";

class AccountViewModel extends ViewModel {
  AccountViewModel({
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
      computed(() => _localizationService.l10n.value.appTitleDashboard);

  @override
  void init() {
    super.init();
    viewModelEffect(() {
      _appContext.appTitle.value =
          _localizationService.l10n.value.appTitleAccount;
    });
  }

  void goToDashboard() => _navigationService.goToDashboard();
}
