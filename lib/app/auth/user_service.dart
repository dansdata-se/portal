import "package:portal/app/auth/account.dart";
import "package:portal/app/auth/account_provider.dart";
import "package:portal/app/auth/login_result.dart";

abstract class UserService {
  Account? get currentAccount;
  Future<LoginResult> login(String email, String password);
  Future<LoginResult> loginWithProvider(AccountProvider accountProvider);
  Future<void> logout();
  Future<void> deleteAccount();
}
