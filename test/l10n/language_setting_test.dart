import "package:flutter_test/flutter_test.dart";
import "package:intl/intl.dart";
@GenerateNiceMocks([MockSpec<Logger>()])
import "package:logger/logger.dart";
import "package:mockito/annotations.dart";
import "package:portal/l10n/language.dart";
import "package:portal/l10n/language_setting.dart";

import "./language_setting_test.mocks.dart";
import "../shared_preferences/mock_prefs.dart";
import "../test_environment.dart";

void main() {
  test(
    "loadValue uses system locale when no stored value is available",
    () async {
      final prefs = MockPrefs({});
      final logger = MockLogger();
      LanguageSetting setting;

      setting = LanguageSetting.forTesting(
        logger,
        prefs,
        () async {
          Intl.systemLocale = "sv";
        },
      );
      await setting.initialize();
      expect(setting.value, Language.swedish);

      setting = LanguageSetting.forTesting(
        logger,
        prefs,
        () async {
          Intl.systemLocale = "en";
        },
      );
      await setting.initialize();
      expect(setting.value, Language.english);
    },
    skip: !TestEnvironment.testSuite.smoke,
  );

  test(
    "loadValue falls back on swedish for unknown system locale",
    () async {
      final prefs = MockPrefs({});
      final logger = MockLogger();
      LanguageSetting setting;

      setting = LanguageSetting.forTesting(
        logger,
        prefs,
        () async {
          Intl.systemLocale = "zz";
        },
      );
      await setting.initialize();
      expect(setting.value, Language.swedish);

      setting = LanguageSetting.forTesting(
        logger,
        prefs,
        () async {
          Intl.systemLocale = "someInvalidValue";
        },
      );
      await setting.initialize();
      expect(setting.value, Language.swedish);

      setting = LanguageSetting.forTesting(
        logger,
        prefs,
        () async {
          Intl.systemLocale = "";
        },
      );
      await setting.initialize();
      expect(setting.value, Language.swedish);
    },
    skip: !TestEnvironment.testSuite.smoke,
  );

  test(
    "loadValue uses stored value if available",
    () async {
      final prefs = MockPrefs({
        LanguageSetting.key: Language.english.name,
      });
      final logger = MockLogger();
      LanguageSetting setting;

      setting = LanguageSetting.forTesting(
        logger,
        prefs,
        () async {
          Intl.systemLocale = "sv";
        },
      );
      await setting.initialize();
      expect(setting.value, Language.english);
    },
    skip: !TestEnvironment.testSuite.smoke,
  );
}
