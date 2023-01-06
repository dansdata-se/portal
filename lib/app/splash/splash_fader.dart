import "package:flutter/foundation.dart";
import "package:flutter/widgets.dart";
import "package:portal/app/splash/splash_screen.dart";
import "package:portal/app/theme/anim_durations.dart";

/// Displays the splash screen until a child is given,
/// at which point the splash screen is replaced by the child with a fade
/// transition.
class SplashFader extends StatefulWidget {
  static const Key splashKey = Key("splashFader.splashscreen");
  static const Key childKey = Key("splashFader.child");

  const SplashFader({super.key, this.child});

  final Widget? child;

  @override
  State<StatefulWidget> createState() => _SplashFaderState();
}

class _SplashFaderState extends State<SplashFader> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (kDebugMode) {
      if (widget.child != null && widget.child?.key != SplashFader.childKey) {
        // Otherwise, we may start fading in an unexpected way.
        throw StateError("Child widget must use predefined key");
      }
    }
  }

  @override
  Widget build(BuildContext context) => AnimatedSwitcher(
        duration: AnimDurations.extraLong,
        child: widget.child ?? const SplashScreen(key: SplashFader.splashKey),
      );
}
