import "package:http/http.dart";
import "package:kotlin_scope_function/kotlin_scope_function.dart";
import "package:logger/logger.dart";
import "package:portal/app/auth/account.dart";
import "package:portal/app/auth/account_provider.dart";
import "package:portal/app/auth/login_result.dart";
import "package:portal/app/auth/user_service.dart";
import "package:portal/main.dart";
import "package:supabase_flutter/supabase_flutter.dart";

class SupabaseUserService extends UserService {
  SupabaseUserService._(this._logger, this._supabase);

  final Logger _logger;
  final Supabase _supabase;

  static Future<SupabaseUserService> initialize(Logger logger) async {
    final supabase = await Supabase.initialize(
      url: BuildConfig.supabaseUrl.toString(),
      anonKey: BuildConfig.supabaseAnonKey,
    );
    return SupabaseUserService._(logger, supabase);
  }

  @override
  Account? get currentAccount =>
      _supabase.client.auth.currentUser?.let(_userToAccount);

  @override
  Future<LoginResult> login(String email, String password) async {
    try {
      final response = await _supabase.client.auth
          .signInWithPassword(email: email, password: password);
      if (response.user == null) {
        _logger.e(
          "Login response does not contain a user (contains session: ${response.session != null})",
        );
        return LoginResult.error;
      }
      return LoginResult.success;
    } on AuthException catch (e) {
      _logger.w("Authentication failed", {
        "message": e.message,
        "statusCode": e.statusCode,
      });
      return LoginResult.invalidCredentials;
    } on ClientException catch (e) {
      _logger.e("Login failed", {
        "uri": e.uri,
        "message": e.message,
      });
      return LoginResult.error;
    } on Exception catch (e) {
      _logger.e("Login failed", {
        "exception": e,
        "exceptionType": e.runtimeType,
      });
      return LoginResult.error;
    }
  }

  @override
  Future<LoginResult> loginWithProvider(AccountProvider accountProvider) async {
    Provider provider;
    switch (accountProvider) {
      case AccountProvider.facebook:
        provider = Provider.facebook;
        break;
      case AccountProvider.github:
        provider = Provider.github;
        break;
      case AccountProvider.google:
        provider = Provider.google;
        break;
    }
    await _supabase.client.auth.signInWithOAuth(
      provider,
    );

    if (currentAccount == null) {
      _logger.w("Provider login failed");
      return LoginResult.invalidCredentials;
    }
    return LoginResult.success;
  }

  @override
  Future<void> logout() async {
    try {
      await _supabase.client.auth.signOut();
    } on AuthException catch (e) {
      if (int.tryParse(e.statusCode ?? "") == 404) {
        // User not found means user has been deleted. Delete session and we're
        // done.
        assert(_supabase.client.auth.currentUser == null);
        return;
      }
      _logger.w("Logout failed", {
        "message": e.message,
        "statusCode": e.statusCode,
      });
    } on ClientException catch (e) {
      _logger.e("Logout failed", {
        "uri": e.uri,
        "message": e.message,
      });
    } on Exception catch (e) {
      _logger.e("Logout failed", {
        "exception": e,
        "exceptionType": e.runtimeType,
      });
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      await _supabase.client.rpc("delete_account");
      await logout();
    } on AuthException catch (e) {
      _logger.w("Account deletion failed", {
        "message": e.message,
        "statusCode": e.statusCode,
      });
    } on ClientException catch (e) {
      _logger.e("Account deletion failed", {
        "uri": e.uri,
        "message": e.message,
      });
    } on Exception catch (e) {
      _logger.e("Account deletion failed", {
        "exception": e,
        "exceptionType": e.runtimeType,
      });
    }
  }

  static Account _userToAccount(User user) =>
      Account(id: user.id, email: user.email);
}
