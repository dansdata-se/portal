import "package:freezed_annotation/freezed_annotation.dart";
import "package:portal/app/auth/account.dart";

part "test_accounts.freezed.dart";

class TestAccounts {
  static const TestAccount alice = TestAccount(
    id: "f79a5ba6-7eaf-400e-8f70-c1e8cbd9631b",
    email: "alice@example.com",
    password: "password",
  );
  static const TestAccount bob = TestAccount(
    id: "1912ff43-e876-4961-9631-ecd09fe019bb",
    email: "bob@example.com",
    password: "password",
  );

  TestAccounts._();
}

/// An account registered with supabase for use during integration testing
@freezed
class TestAccount with _$TestAccount {
  const TestAccount._();

  const factory TestAccount({
    required String id,
    required String email,
    required String password,
  }) = _TestAccount;

  Account get account => Account(id: id, email: email);
}
