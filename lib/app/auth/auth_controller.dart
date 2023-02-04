import "package:flutter/foundation.dart";
import "package:portal/app/auth/account.dart";
import "package:portal/app/auth/auth_service.dart";
import "package:portal/app/auth/login_result.dart";
import "package:portal/app/auth/sso/account_provider.dart";

class AuthController with ChangeNotifier {
  AuthController(this._authService);

  final AuthService _authService;

  late Account? _currentAccount = _authService.currentAccount;
  Account? get currentAccount => _currentAccount;
  bool get isLoggedIn => _currentAccount != null;

  bool _isLoggingIn = false;
  bool get isLoggingIn => _isLoggingIn;

  bool _isLoggingOut = false;
  bool get isLoggingOut => _isLoggingOut;

  Future<LoginResult> login(String email, String password) async {
    if (isLoggingIn || isLoggedIn) return LoginResult.aborted;
    _isLoggingIn = true;
    notifyListeners();

    final result = await _authService.login(email, password);
    _currentAccount = _authService.currentAccount;
    _isLoggingIn = false;
    notifyListeners();

    return result;
  }

  Future<LoginResult> loginWithProvider(AccountProvider provider) async {
    if (isLoggingIn || isLoggedIn) return LoginResult.aborted;
    _isLoggingIn = true;
    notifyListeners();

    final result = await _authService.loginWithProvider(provider);
    _currentAccount = _authService.currentAccount;
    _isLoggingIn = false;
    notifyListeners();

    return result;
  }

  Future<void> logout() async {
    if (isLoggingOut || !isLoggedIn) return;
    _isLoggingOut = true;
    notifyListeners();

    await _authService.logout();
    _currentAccount = null;
    _isLoggingOut = false;
    notifyListeners();
  }

  Future<void> deleteAccout() async {
    if (isLoggingOut || !isLoggedIn) return;
    _isLoggingOut = true;
    notifyListeners();

    await _authService.deleteAccount();
    _currentAccount = null;
    _isLoggingOut = false;
    notifyListeners();
  }
}
