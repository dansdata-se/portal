import "package:flutter/foundation.dart";
import "package:portal/app/auth/account.dart";
import "package:portal/app/auth/account_provider.dart";
import "package:portal/app/auth/login_result.dart";
import "package:portal/app/auth/user_service.dart";

class UserController with ChangeNotifier {
  UserController(this._userService);

  final UserService _userService;

  late Account? _currentAccount = _userService.currentAccount;
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

    final result = await _userService.login(email, password);
    _currentAccount = _userService.currentAccount;
    _isLoggingIn = false;
    notifyListeners();

    return result;
  }

  Future<LoginResult> loginWithProvider(AccountProvider provider) async {
    if (isLoggingIn || isLoggedIn) return LoginResult.aborted;
    _isLoggingIn = true;
    notifyListeners();

    final result = await _userService.loginWithProvider(provider);
    _currentAccount = _userService.currentAccount;
    _isLoggingIn = false;
    notifyListeners();

    return result;
  }

  Future<void> logout() async {
    if (isLoggingOut || !isLoggedIn) return;
    _isLoggingOut = true;
    notifyListeners();

    await _userService.logout();
    _currentAccount = null;
    _isLoggingOut = false;
    notifyListeners();
  }

  Future<void> deleteAccout() async {
    if (isLoggingOut || !isLoggedIn) return;
    _isLoggingOut = true;
    notifyListeners();

    await _userService.deleteAccount();
    _currentAccount = null;
    _isLoggingOut = false;
    notifyListeners();
  }
}
