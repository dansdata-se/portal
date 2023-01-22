import "dart:async";

import "package:flutter/material.dart";
import "package:portal/gen/assets.gen.dart";

/// Precached background image changing color to match current theme.
///
/// Precaching based on
/// https://alex.domenici.net/archive/preload-images-in-a-stateful-widget-on-flutter
class Background extends StatefulWidget {
  const Background({super.key});

  @override
  State<StatefulWidget> createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> {
  late Image _backgroundImage;

  @override
  void initState() {
    super.initState();

    _backgroundImage = Assets.images.authBackground.image(
      fit: BoxFit.cover,
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
      excludeFromSemantics: true,
      isAntiAlias: false,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    unawaited(precacheImage(_backgroundImage.image, context));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        theme.colorScheme.primaryContainer,
        BlendMode.color,
      ),
      child: _backgroundImage,
    );
  }
}
