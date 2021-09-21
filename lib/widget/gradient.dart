import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class RadiantGradientMask extends StatelessWidget {
  RadiantGradientMask({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (Rect bounds) {
        return ui.Gradient.linear(
          Offset(4.0, 24.0),
          Offset(24.0, 4.0),
          [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColorDark,
          ],
        );
      },
      child: child,
    );
  }
}
