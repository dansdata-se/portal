import "dart:io";

import "package:flutter_test/flutter_test.dart";
import "package:logger/logger.dart";
import "package:portal/app/auth/login_result.dart";
import "package:portal/supabase/supabase_auth_service.dart";

import "../test_environment.dart";
import "supabase_binding.dart";
import "test_accounts.dart";

void main() {
  if (TestEnvironment.testSuite.supabase) {
    setUpAll(() => SupabaseBinding());
    tearDownAll(() async {
      await Directory(SupabaseBinding.testCachePath).delete(recursive: true);
    });
  }

  test(
    "verify initial state",
    () async {
      final logger = Logger();
      final authService = await SupabaseAuthService.create(logger);

      expect(authService.currentAccount, null);
    },
    skip: !TestEnvironment.testSuite.supabase,
  );

  test(
    "simple log in/log out flow",
    () async {
      const testAccount = TestAccounts.alice;
      final logger = Logger();
      final authService = await SupabaseAuthService.create(logger);

      expect(authService.currentAccount, null);

      final loginResult = await authService
          .login(
            testAccount.email,
            testAccount.password,
          )
          .timeout(
            const Duration(seconds: 3),
            onTimeout: () =>
                throw AssertionError("Login operation took too long"),
          );

      expect(loginResult, LoginResult.success);
      expect(authService.currentAccount, testAccount.account);

      await authService.logout().timeout(
            const Duration(seconds: 3),
            onTimeout: () =>
                throw AssertionError("Logout operation took too long"),
          );
      expect(authService.currentAccount, null);
    },
    skip: !TestEnvironment.testSuite.supabase,
  );
}
