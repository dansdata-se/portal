import "dart:ui";

import "package:flutter_test/flutter_test.dart";

enum TestScreenSizes {
  mobileSmall(Size(320, 640)),
  mobileMedium(Size(375, 800)),
  mobileLarge(Size(425, 800)),
  tabletPortrait(Size(768, 1024)),
  tabletLandscape(Size(768, 1024)),
  laptop(Size(1366, 768)),
  fullHd(Size(1920, 1080)),
  fullHdQuarterHeight(Size(1920, 1080 / 4));

  const TestScreenSizes(this.size);

  final Size size;
}

void testWidgetsMultiResolution(
  List<Size> resolutions,
  Future<void> Function(WidgetTester, Size) callback, {
  bool Function(Size)? skip,
  Timeout? timeout,
  bool semanticsEnabled = true,
  TestVariant<Object?> variant = const DefaultTestVariant(),
  dynamic tags,
}) {
  for (final resolution in resolutions) {
    testWidgets(
      "@${resolution.width}x${resolution.height}px",
      (tester) async {
        tester.binding.window.physicalSizeTestValue = resolution;
        tester.binding.window.devicePixelRatioTestValue = 1.0;
        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        addTearDown(
          tester.binding.window.clearDevicePixelRatioTestValue,
        );

        await callback(tester, resolution);
      },
      skip: skip?.call(resolution),
      timeout: timeout,
      semanticsEnabled: semanticsEnabled,
      variant: variant,
      tags: tags,
    );
  }
}
