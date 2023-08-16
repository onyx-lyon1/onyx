import 'dart:ui';

import 'package:flutter/material.dart';

class CustomScrollBehavior extends ScrollBehavior {
  const CustomScrollBehavior() : super();

  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return child;
      case TargetPlatform.android:
        return StretchingOverscrollIndicator(
          axisDirection: details.direction,
          child: child,
        );
      case TargetPlatform.fuchsia:
        return GlowingOverscrollIndicator(
          axisDirection: details.direction,
          color: Theme.of(context).primaryColor.withOpacity(0.5),
          child: child,
        );
    }
  }
}
