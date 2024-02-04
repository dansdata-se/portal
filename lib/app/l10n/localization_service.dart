import "dart:async";

import "package:dansdata_portal/async/cancellation_token.dart";
import "package:flutter/foundation.dart";
import "package:flutter/widgets.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:injectable/injectable.dart";
import "package:logger/logger.dart";
import "package:signals/signals.dart";

@singleton
@injectable
class LocalizationService with WidgetsBindingObserver {
  LocalizationService._({
    required Logger logger,
    required Locale initialLocale,
    required AppLocalizations localizations,
  })  : _logger = logger,
        locale = signal(initialLocale),
        l10n = signal(localizations) {
    WidgetsBinding.instance.addObserver(this);
  }

  final Logger _logger;

  final Signal<Locale> locale;
  final Signal<AppLocalizations> l10n;

  CancellationToken? _updateLocaleToken;

  @override
  void didChangeLocales(List<Locale>? locales) {
    super.didChangeLocales(locales);
    final newLocale = basicLocaleListResolution(
      locales,
      AppLocalizations.supportedLocales,
    );
    _logger.d("Locale change detected: ${locale.value} => $newLocale");
    unawaited(_updateLocale(newLocale));
  }

  Future<void> _updateLocale(Locale newLocale) async {
    _updateLocaleToken?.cancel();
    final cancellationToken = _updateLocaleToken = CancellationToken();
    final (newLocale, newL10n) = await _resolveL10n();

    if (cancellationToken.isCancelled()) return;
    _updateLocaleToken = null;

    batch(() {
      locale.value = newLocale;
      l10n.value = newL10n;
    });
    _logger.d("New locale applied: $newLocale");
  }

  void _dispose() {
    _updateLocaleToken?.cancel();
    _updateLocaleToken = null;
    WidgetsBinding.instance.removeObserver(this);
  }

  static const supportedLocales = AppLocalizations.supportedLocales;
  static const localizationsDelegates = AppLocalizations.localizationsDelegates;

  // https://api.flutter.dev/flutter/dart-core/Finalizer-class.html
  // ignore: unused_field
  static final Finalizer<LocalizationService> _finalizer =
  Finalizer((instance) => instance._dispose());

  @factoryMethod
  static Future<LocalizationService> initialize({
    required Logger logger,
  }) async {
    final (locale, l10n) = await _resolveL10n();
    return LocalizationService._(
      logger: logger,
      initialLocale: locale,
      localizations: l10n,
    );
  }

  static Future<(Locale, AppLocalizations)> _resolveL10n() async {
    final locale = basicLocaleListResolution(
      PlatformDispatcher.instance.locales,
      AppLocalizations.supportedLocales,
    );
    final l10n = await AppLocalizations.delegate.load(locale);
    return (locale, l10n);
  }
}
