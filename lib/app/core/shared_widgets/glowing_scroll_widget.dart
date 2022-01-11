import 'package:visual_notes/app/core/core_exports.dart' show AppColors;
import 'package:flutter/material.dart';

class GlowingScrollWidget extends StatelessWidget {
  final AxisDirection axisDirection;
  final Color glowingColor;
  final Widget child;
  const GlowingScrollWidget({
    Key? key,
    this.axisDirection = AxisDirection.down,
    this.glowingColor = AppColors.facegraphColor,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior(),
      child: GlowingOverscrollIndicator(
        axisDirection: axisDirection,
        color: glowingColor,
        child: child,
      ),
    );
  }
}
