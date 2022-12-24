import "package:kotlin_scope_function/kotlin_scope_function.dart";

class TestSuite {
  /// A subset of unit tests intended for quick validation.
  static const TestSuite smokeSuite = TestSuite._(smoke: true);

  /// A suite of tests that can be run without external dependencies
  static const TestSuite unitSuite = TestSuite._(smoke: true, unit: true);

  /// A suite of tests for integrating with external services, typically
  /// supabase.
  static const TestSuite integrationSuite = TestSuite._(supabase: true);
  static const TestSuite fullSuite =
      TestSuite._(smoke: true, unit: true, supabase: true);

  const TestSuite._({
    this.smoke = false,
    this.unit = false,
    this.supabase = false,
  });

  final bool smoke;
  final bool unit;

  /// A test requiring the local supabase development setup to be running.
  ///
  /// Such tests should assume a newly started development setup and clean up
  /// after themselves.
  final bool supabase;
}

class TestEnvironment {
  static final TestSuite testSuite = const String.fromEnvironment(
    "TEST_SUITE",
    defaultValue: "smoke",
  ).let((it) {
    final suiteName = it.toLowerCase();
    switch (suiteName) {
      case "smoke":
        return TestSuite.smokeSuite;
      case "":
      case "unit":
        return TestSuite.unitSuite;
      case "integration":
        return TestSuite.integrationSuite;
      case "full":
        return TestSuite.fullSuite;
      default:
        throw UnsupportedError("No such suite: '$suiteName'");
    }
  });

  const TestEnvironment._();
}
