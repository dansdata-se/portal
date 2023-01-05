import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:portal/app/theme/typography.dart";

/// Pumps a simple widget containing all fonts to ensure they are loaded.
///
/// This is needed as google fonts may take a few frames to load.
///
/// A solution to this is proposed in
/// https://github.com/material-foundation/google-fonts-flutter/pull/195
/// but not yet integrated at the time of writing.
Future<void> preloadFonts(WidgetTester tester) async {
  await tester.pumpWidget(
    Directionality(
      textDirection: TextDirection.ltr,
      child: Column(
        children: [
          Text("A", style: brandTextStyle()),
          Text("A", style: plainTextStyle()),
        ],
      ),
    ),
  );
  await tester.pumpAndSettle();
}
