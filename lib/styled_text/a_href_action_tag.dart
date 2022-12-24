import "dart:async";

import "package:flutter/material.dart";
import "package:styled_text/tags/styled_text_tag_action.dart";
import "package:url_launcher/url_launcher.dart";

StyledTextActionTag aHrefActionTag(BuildContext context) {
  final theme = Theme.of(context);
  return StyledTextActionTag(
    (text, attributes) => unawaited(
      launchUrl(Uri.parse(attributes["href"]!)),
    ),
    style: TextStyle(color: theme.colorScheme.primary),
  );
}
