import "dart:ui";

import "package:flutter_test/flutter_test.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:portal/app/app_module.dart";

import "test_app_widgets.dart";

part "device.freezed.dart";

@freezed
class Device with _$Device {
  const factory Device({
    required String name,
    required double width,
    required double height,
    @Default(1.0) double pixelDensity,
  }) = _Device;

  static final allVariants = ValueVariant<Device>({
    Devices.iPhone5,
    Devices.pixel5,
    Devices.galaxyZFlip,
    Devices.galaxyZFold2,
    Devices.iPad,
    Devices.iPadPro,
    Devices.macBookAir,
    Devices.fullHd,
    Devices.quadHd,
  });

  static final simpleVariants = ValueVariant<Device>({
    Devices.mobile,
    Devices.tablet,
    Devices.laptop,
    Devices.desktop,
  });
}

class Devices {
  static const iPhone5 =
      Device(name: "iPhone_5", width: 320, height: 568, pixelDensity: 2);
  static const pixel5 =
      Device(name: "Pixel_5", width: 393, height: 851, pixelDensity: 2.75);
  static const galaxyZFlip = Device(
    name: "Galaxy_Z_Flip_2020",
    width: 412,
    height: 1004,
    pixelDensity: 2.625,
  );
  static const galaxyZFold2 = Device(
    name: "Galaxy_Z_Fold2_2020",
    width: 884,
    height: 1104,
    pixelDensity: 2,
  );
  static const iPad = Device(
    name: "iPad_10.2inch_2020",
    width: 810,
    height: 1080,
    pixelDensity: 2,
  );
  static const iPadPro = Device(
    name: "iPad_Pro_12.9inch_2020",
    width: 1024,
    height: 1366,
    pixelDensity: 2,
  );
  static const macBookAir = Device(
    name: "MacBook_Air_2020_13inch",
    width: 1280,
    height: 800,
    pixelDensity: 2,
  );
  static const fullHd = Device(name: "FHD", width: 1920, height: 1080);
  static const quadHd = Device(name: "QHD", width: 2560, height: 1440);

  static const mobile = iPhone5;
  static const tablet = iPad;
  static const laptop = macBookAir;
  static const desktop = fullHd;

  Devices._();
}

@isTest
void testAppWidgetOnVirtualDevice(
  String description,
  ValueVariant<Device> devices,
  Future<void> Function(
    WidgetTester tester,
    AppTestWrapper wrapper,
    AppModule appModule,
    Device device,
  )
      callback, {
  bool? skip,
  Timeout? timeout,
  bool semanticsEnabled = true,
  dynamic tags,
}) {
  testAppWidgets(
    description,
    (
      WidgetTester tester,
      AppTestWrapper wrapper,
      AppModule appModule,
    ) async {
      await tester.simulateDevice(devices.currentValue!);
      await callback(tester, wrapper, appModule, devices.currentValue!);
    },
    skip: skip,
    timeout: timeout,
    semanticsEnabled: semanticsEnabled,
    variant: devices,
    tags: tags,
  );
}

extension DeviceSimulation on WidgetTester {
  /// Configures the window size etc. to match the given device.
  Future<void> simulateDevice(Device device) async {
    final size = Size(device.width, device.height);
    await binding.setSurfaceSize(size);
    binding.window.physicalSizeTestValue = size;
    binding.window.devicePixelRatioTestValue = device.pixelDensity;
    addTearDown(() async {
      await binding.setSurfaceSize(null);
      binding.window.clearPhysicalSizeTestValue();
      binding.window.clearDevicePixelRatioTestValue();
    });
  }
}
