import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:portal/app/auth/login_page.dart";
import "package:portal/app/auth/user_controller.dart";
import "package:portal/app/dashboard/dashboard_page.dart";
import "package:portal/app/navigation/portal_router.dart";
import "package:portal/app/settings/language_setting.dart";
import "package:portal/app/settings/theme_mode_setting.dart";
import "package:portal/app/theme/theme.dart";
import "package:provider/provider.dart";

class DansdataPortalApp extends StatefulWidget {
  const DansdataPortalApp({super.key});

  @override
  State<StatefulWidget> createState() => _DansdataPortalAppState();
}

class _DansdataPortalAppState extends State<DansdataPortalApp> {
  late final UserController _userController;
  late final RouterConfig<Object> _routerConfig;
  bool _wasLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _userController = Provider.of(context, listen: false);
    _routerConfig = buildRouterConfig();
    _wasLoggedIn = _userController.isLoggedIn;

    _userController.addListener(_onUserControllerChanged);
  }

  @override
  void dispose() {
    _userController.removeListener(_onUserControllerChanged);

    super.dispose();
  }

  // Respond to login/logout events and redirect user as required.
  void _onUserControllerChanged() {
    if (_wasLoggedIn == _userController.isLoggedIn) return;

    if (_userController.isLoggedIn) {
      const DashboardDestination().go(context);
      setState(() {
        _wasLoggedIn = true;
      });
    } else {
      const LoginDestination().go(context);
      setState(() {
        _wasLoggedIn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      restorationScopeId: "app",
      title: "Dansdata Portal",
      themeMode: context.watch<ThemeModeSetting>().value,
      theme: dansdataThemeLight,
      darkTheme: dansdataThemeDark,
      routerConfig: _routerConfig,
      locale: context.watch<LanguageSetting>().locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
    );
  }
}
