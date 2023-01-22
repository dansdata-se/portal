import "dart:async";

import "package:flutter/material.dart";
import "package:portal/l10n/language_setting.dart";
import "package:provider/provider.dart";

/// Helper mixin for widgets, providing a standardized [onToggleLanguageClick]
/// method.
mixin LanguageClickHandler {
  void onToggleLanguageClick(BuildContext context) {
    unawaited(context.read<LanguageSetting>().toggle());
  }
}

class LanguageClickHandlerDelegate with LanguageClickHandler {
  const LanguageClickHandlerDelegate();
}
