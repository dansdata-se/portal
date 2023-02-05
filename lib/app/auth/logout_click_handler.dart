import "dart:async";

import "package:flutter/material.dart";
import "package:portal/app/auth/auth_controller.dart";
import "package:provider/provider.dart";

/// Helper mixin for widgets, providing a standardized [onLogoutClick] method.
mixin LogoutClickHandler {
  void onLogoutClick(BuildContext context) {
    unawaited(context.read<AuthController>().logout());
  }
}

class LogoutClickHandlerDelegate with LogoutClickHandler {
  const LogoutClickHandlerDelegate();
}
