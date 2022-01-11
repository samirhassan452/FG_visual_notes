import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:visual_notes/app/core/core_exports.dart'
    show Constants, GlowingScrollWidget;

class HomeShimmerWidget extends StatelessWidget {
  const HomeShimmerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlowingScrollWidget(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: Constants.mediumPadding),
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: List.filled(
          5,
          Shimmer(
            child: Container(
              // width: double.infinity,
              margin: const EdgeInsets.only(
                bottom: Constants.semiMediumPadding,
                left: Constants.semiMediumPadding,
                right: Constants.semiMediumPadding,
              ),
              height: 155.0,
              child: Card(elevation: 4.0, color: Colors.grey[600]),
            ),
          ),
        ),
      ),
    );
  }
}
