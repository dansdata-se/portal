import "package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart";

class CustomBreakpoints {
  // Quote from https://m3.material.io/components/navigation-drawer/guidelines:
  //
  // > Standard navigation drawers are best for screens at large breakpoints of
  // > 1240dp or greater.
  static const Breakpoint extraLarge = WidthPlatformBreakpoint(begin: 1240);

  const CustomBreakpoints._();
}
