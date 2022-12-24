import "package:flutter_test/flutter_test.dart";
import "package:portal/shared_preferences/enum_extensions.dart";

import "../test_environment.dart";
import "mock_prefs.dart";

enum _TestEnum { lowercase, camelCase }

void main() {
  test(
    "uses provided fallback value if value is not set",
    () async {
      final prefs = MockPrefs({});

      expect(
        prefs.getEnumOrNull("myEnum", _TestEnum.values),
        null,
      );
      expect(
        prefs.getEnum("myEnum", _TestEnum.values, () => _TestEnum.lowercase),
        _TestEnum.lowercase,
      );
      expect(
        prefs.getEnum("myEnum", _TestEnum.values, () => _TestEnum.camelCase),
        _TestEnum.camelCase,
      );
    },
    skip: !TestEnvironment.testSuite.smoke,
  );

  test(
    "can handle enums with lowercase names",
    () async {
      final prefs = MockPrefs({});

      expect(await prefs.setEnum("myEnum", _TestEnum.lowercase), true);
      expect(prefs.get("myEnum"), "lowercase");
      expect(
        prefs.getEnumOrNull("myEnum", _TestEnum.values),
        _TestEnum.lowercase,
      );
      expect(
        prefs.getEnum("myEnum", _TestEnum.values, () => _TestEnum.camelCase),
        _TestEnum.lowercase,
      );
    },
    skip: !TestEnvironment.testSuite.smoke,
  );

  test(
    "can handle enums with camelCase names",
    () async {
      final prefs = MockPrefs({});

      expect(await prefs.setEnum("myEnum", _TestEnum.camelCase), true);
      expect(prefs.get("myEnum"), "camelCase");
      expect(
        prefs.getEnumOrNull("myEnum", _TestEnum.values),
        _TestEnum.camelCase,
      );
      expect(
        prefs.getEnum("myEnum", _TestEnum.values, () => _TestEnum.lowercase),
        _TestEnum.camelCase,
      );
    },
    skip: !TestEnvironment.testSuite.smoke,
  );
}
