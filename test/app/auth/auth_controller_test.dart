import "dart:async";

import "package:flutter_test/flutter_test.dart";
import "package:mockito/annotations.dart";
import "package:mockito/mockito.dart";
import "package:portal/app/auth/account.dart";
import "package:portal/app/auth/auth_controller.dart";
@GenerateNiceMocks([MockSpec<AuthService>()])
import "package:portal/app/auth/auth_service.dart";
import "package:portal/app/auth/login_result.dart";
import "package:portal/app/auth/sso/account_provider.dart";

import "../../test_environment.dart";
import "auth_controller_test.mocks.dart";

void main() {
  test(
    "verify initial state",
    () async {
      final authService = MockAuthService();
      when(authService.currentAccount).thenReturn(null);

      final authController = AuthController(authService);

      expect(authController.currentAccount, null);
      expect(authController.isLoggedIn, false);
      expect(authController.isLoggingIn, false);
      expect(authController.isLoggingOut, false);
    },
    skip: !TestEnvironment.testSuite.smoke,
  );

  test(
    "verify simple logged in state",
    () async {
      const account = Account(id: "123", email: "alice@example.com");
      final authService = MockAuthService();
      when(authService.currentAccount).thenReturn(account);

      final authController = AuthController(authService);

      expect(authController.currentAccount, account);
      expect(authController.isLoggedIn, true);
      expect(authController.isLoggingIn, false);
      expect(authController.isLoggingOut, false);
    },
    skip: !TestEnvironment.testSuite.smoke,
  );

  test(
    "email login flow",
    () async {
      const account = Account(id: "123", email: "alice@example.com");
      final authService = MockAuthService();

      final loginCompleter = Completer();
      when(authService.currentAccount).thenReturn(null);
      when(authService.login(any, any)).thenAnswer(
        (_) async => (await loginCompleter.future) as LoginResult,
      );

      int changeNotificationCount = 0;
      final authController = AuthController(authService)
        ..addListener(
          () {
            changeNotificationCount++;
          },
        );

      // 1: User is logged out.

      expect(changeNotificationCount, 0);
      expect(authController.currentAccount, null);
      expect(authController.isLoggedIn, false);
      expect(authController.isLoggingIn, false);
      expect(authController.isLoggingOut, false);

      // 2: User requests login

      final loginFuture = authController.login(account.email!, "password123");

      expect(changeNotificationCount, 1);
      expect(authController.currentAccount, null);
      expect(authController.isLoggedIn, false);
      expect(authController.isLoggingIn, true);
      expect(authController.isLoggingOut, false);

      // 3: Service returns an account

      when(authService.currentAccount).thenReturn(account);

      // Work is still internal to the service - controller is not yet aware of
      // the new `currentAccount`!
      expect(changeNotificationCount, 1);
      expect(authController.currentAccount, null);
      expect(authController.isLoggedIn, false);
      expect(authController.isLoggingIn, true);
      expect(authController.isLoggingOut, false);

      // 4: Service call completes

      loginCompleter.complete(LoginResult.success);
      final result = await loginFuture.timeout(
        const Duration(milliseconds: 100),
        onTimeout: () => throw AssertionError(
          "Controller did not return after service completed execution",
        ),
      );

      expect(changeNotificationCount, 2);
      expect(result, LoginResult.success);
      expect(authController.currentAccount, account);
      expect(authController.isLoggedIn, true);
      expect(authController.isLoggingIn, false);
      expect(authController.isLoggingOut, false);
    },
    skip: !TestEnvironment.testSuite.unit,
  );

  test(
    "sso login flow",
    () async {
      const account = Account(id: "123", email: "alice@example.com");
      final authService = MockAuthService();

      final loginCompleter = Completer();
      when(authService.currentAccount).thenReturn(null);
      when(authService.loginWithProvider(any)).thenAnswer(
        (_) async => (await loginCompleter.future) as LoginResult,
      );

      int changeNotificationCount = 0;
      final authController = AuthController(authService)
        ..addListener(
          () {
            changeNotificationCount++;
          },
        );

      // 1: User is logged out.

      expect(changeNotificationCount, 0);
      expect(authController.currentAccount, null);
      expect(authController.isLoggedIn, false);
      expect(authController.isLoggingIn, false);
      expect(authController.isLoggingOut, false);

      // 2: User requests login

      final loginFuture =
          authController.loginWithProvider(AccountProvider.google);

      expect(changeNotificationCount, 1);
      expect(authController.currentAccount, null);
      expect(authController.isLoggedIn, false);
      expect(authController.isLoggingIn, true);
      expect(authController.isLoggingOut, false);

      // 3: Service returns an account

      when(authService.currentAccount).thenReturn(account);

      // Work is still internal to the service - controller is not yet aware of
      // the new `currentAccount`!
      expect(changeNotificationCount, 1);
      expect(authController.currentAccount, null);
      expect(authController.isLoggedIn, false);
      expect(authController.isLoggingIn, true);
      expect(authController.isLoggingOut, false);

      // 4: Service call completes

      loginCompleter.complete(LoginResult.success);
      final result = await loginFuture.timeout(
        const Duration(milliseconds: 100),
        onTimeout: () => throw AssertionError(
          "Controller did not return after service completed execution",
        ),
      );

      expect(changeNotificationCount, 2);
      expect(result, LoginResult.success);
      expect(authController.currentAccount, account);
      expect(authController.isLoggedIn, true);
      expect(authController.isLoggingIn, false);
      expect(authController.isLoggingOut, false);
    },
    skip: !TestEnvironment.testSuite.unit,
  );

  test(
    "logout flow",
    () async {
      const account = Account(id: "123", email: "alice@example.com");
      final authService = MockAuthService();

      final logoutCompleter = Completer();
      when(authService.currentAccount).thenReturn(account);
      when(authService.logout()).thenAnswer((_) => logoutCompleter.future);

      int changeNotificationCount = 0;
      final authController = AuthController(authService)
        ..addListener(
          () {
            changeNotificationCount++;
          },
        );

      // 1: User is logged in.

      expect(changeNotificationCount, 0);
      expect(authController.currentAccount, account);
      expect(authController.isLoggedIn, true);
      expect(authController.isLoggingIn, false);
      expect(authController.isLoggingOut, false);

      // 2: User requests logout

      final logoutFuture = authController.logout();

      expect(changeNotificationCount, 1);
      expect(authController.currentAccount, account);
      expect(authController.isLoggedIn, true);
      expect(authController.isLoggingIn, false);
      expect(authController.isLoggingOut, true);

      // 3: Service clears knowledge of current account

      when(authService.currentAccount).thenReturn(null);

      // Work is still internal to the service - controller is not yet aware of
      // the new `currentAccount`!
      expect(changeNotificationCount, 1);
      expect(authController.currentAccount, account);
      expect(authController.isLoggedIn, true);
      expect(authController.isLoggingIn, false);
      expect(authController.isLoggingOut, true);

      // 4: Service call completes

      logoutCompleter.complete();
      await logoutFuture.timeout(
        const Duration(milliseconds: 100),
        onTimeout: () => throw AssertionError(
          "Controller did not return after service completed execution",
        ),
      );

      expect(changeNotificationCount, 2);
      expect(authController.currentAccount, null);
      expect(authController.isLoggedIn, false);
      expect(authController.isLoggingIn, false);
      expect(authController.isLoggingOut, false);
    },
    skip: !TestEnvironment.testSuite.unit,
  );

  test(
    "account deletion flow",
    () async {
      const account = Account(id: "123", email: "alice@example.com");
      final authService = MockAuthService();

      final logoutCompleter = Completer();
      when(authService.currentAccount).thenReturn(account);
      when(authService.deleteAccount())
          .thenAnswer((_) => logoutCompleter.future);

      int changeNotificationCount = 0;
      final authController = AuthController(authService)
        ..addListener(
          () {
            changeNotificationCount++;
          },
        );

      // 1: User is logged in.

      expect(changeNotificationCount, 0);
      expect(authController.currentAccount, account);
      expect(authController.isLoggedIn, true);
      expect(authController.isLoggingIn, false);
      expect(authController.isLoggingOut, false);

      // 2: User requests logout

      final logoutFuture = authController.deleteAccout();

      expect(changeNotificationCount, 1);
      expect(authController.currentAccount, account);
      expect(authController.isLoggedIn, true);
      expect(authController.isLoggingIn, false);
      expect(authController.isLoggingOut, true);

      // 3: Service clears knowledge of current account

      when(authService.currentAccount).thenReturn(null);

      // Work is still internal to the service - controller is not yet aware of
      // the new `currentAccount`!
      expect(changeNotificationCount, 1);
      expect(authController.currentAccount, account);
      expect(authController.isLoggedIn, true);
      expect(authController.isLoggingIn, false);
      expect(authController.isLoggingOut, true);

      // 4: Service call completes

      logoutCompleter.complete();
      await logoutFuture.timeout(
        const Duration(milliseconds: 100),
        onTimeout: () => throw AssertionError(
          "Controller did not return after service completed execution",
        ),
      );

      expect(changeNotificationCount, 2);
      expect(authController.currentAccount, null);
      expect(authController.isLoggedIn, false);
      expect(authController.isLoggingIn, false);
      expect(authController.isLoggingOut, false);
    },
    skip: !TestEnvironment.testSuite.unit,
  );
}
