import "package:portal/app/auth/account.dart";
import "package:portal/app/auth/login_result.dart";
import "package:portal/app/auth/sso/account_provider.dart";

abstract class AuthService {
  Account? get currentAccount;
  Future<LoginResult> login(String email, String password);
  Future<LoginResult> loginWithProvider(AccountProvider accountProvider);
  Future<void> logout();
  Future<void> deleteAccount();
}
