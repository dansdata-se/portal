import "package:flutter_test/flutter_test.dart";

import "../test_environment.dart";
import "mock_prefs.dart";

void main() {
  test(
    "init with values",
    () {
      final prefs = MockPrefs({
        "bool": true,
        "double": 123.456,
        "int": 123,
        "string": "hello world",
        "stringList": ["hello", "world"],
      });

      expect(prefs.containsKey("bool"), true);
      expect(prefs.get("bool"), true);
      expect(prefs.getBool("bool"), true);

      expect(prefs.containsKey("double"), true);
      expect(prefs.get("double"), 123.456);
      expect(prefs.getDouble("double"), 123.456);

      expect(prefs.containsKey("int"), true);
      expect(prefs.get("int"), 123);
      expect(prefs.getInt("int"), 123);

      expect(prefs.containsKey("string"), true);
      expect(prefs.get("string"), "hello world");
      expect(prefs.getString("string"), "hello world");

      expect(prefs.containsKey("stringList"), true);
      expect(prefs.get("stringList"), ["hello", "world"]);
      expect(prefs.getStringList("stringList"), ["hello", "world"]);

      expect(prefs.containsKey("random"), false);
    },
    skip: !TestEnvironment.testSuite.smoke,
  );

  test(
    "setting and removing values",
    () async {
      const key = "key";
      final prefs = MockPrefs({});

      expect(prefs.containsKey(key), false);

      expect(prefs.getBool(key), null);
      expect(await prefs.setBool(key, true), true);
      expect(prefs.containsKey(key), true);
      expect(prefs.getBool(key), true);
      expect(await prefs.remove(key), true);
      expect(prefs.containsKey(key), false);
      expect(prefs.getBool(key), null);

      expect(prefs.getDouble(key), null);
      expect(await prefs.setDouble(key, 123.456), true);
      expect(prefs.containsKey(key), true);
      expect(prefs.getDouble(key), 123.456);
      expect(await prefs.remove(key), true);
      expect(prefs.containsKey(key), false);
      expect(prefs.getDouble(key), null);

      expect(prefs.getInt(key), null);
      expect(await prefs.setInt(key, 123), true);
      expect(prefs.containsKey(key), true);
      expect(prefs.getInt(key), 123);
      expect(await prefs.remove(key), true);
      expect(prefs.containsKey(key), false);
      expect(prefs.getInt(key), null);

      expect(prefs.getString(key), null);
      expect(await prefs.setString(key, "hello world"), true);
      expect(prefs.containsKey(key), true);
      expect(prefs.getString(key), "hello world");
      expect(await prefs.remove(key), true);
      expect(prefs.containsKey(key), false);
      expect(prefs.getString(key), null);

      expect(prefs.getString(key), null);
      expect(await prefs.setStringList(key, ["hello", "world"]), true);
      expect(prefs.containsKey(key), true);
      expect(prefs.getStringList(key), ["hello", "world"]);
      expect(await prefs.remove(key), true);
      expect(prefs.containsKey(key), false);
      expect(prefs.getStringList(key), null);
    },
    skip: !TestEnvironment.testSuite.smoke,
  );

  test(
    "throws for invalid casts",
    () {
      final prefs = MockPrefs({
        "bool": true,
        "double": 123.456,
        "int": 123,
        "string": "hello world",
        "stringList": ["hello", "world"],
      });

      expect(() => prefs.getBool("double"), throwsA(isA<TypeError>()));
      expect(() => prefs.getDouble("bool"), throwsA(isA<TypeError>()));
      expect(() => prefs.getInt("double"), throwsA(isA<TypeError>()));
      expect(() => prefs.getString("stringList"), throwsA(isA<TypeError>()));
      expect(() => prefs.getStringList("string"), throwsA(isA<TypeError>()));
    },
    skip: !TestEnvironment.testSuite.smoke,
  );

  test(
    "keys and clear",
    () async {
      final prefs = MockPrefs({
        "bool": true,
        "double": 123.456,
        "int": 123,
        "string": "hello world",
        "stringList": ["hello", "world"],
      });
      expect(
        prefs.getKeys(),
        {"bool", "double", "int", "string", "stringList"},
      );
      expect(await prefs.clear(), true);
      expect(prefs.getKeys(), <Set>{});
    },
    skip: !TestEnvironment.testSuite.smoke,
  );

  test(
    "remove",
    () async {
      final prefs = MockPrefs({
        "bool": true,
      });
      expect(await prefs.remove("bool"), true);
      expect(await prefs.remove("bool"), false);
    },
    skip: !TestEnvironment.testSuite.smoke,
  );
}
