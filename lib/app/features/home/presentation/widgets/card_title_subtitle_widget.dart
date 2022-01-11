import 'package:flutter/material.dart';
import 'package:visual_notes/app/core/core_exports.dart' show CustomTextWidget;

class CardTitleSubtitleWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final double currentHeight;
  const CardTitleSubtitleWidget({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.currentHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomTextWidget(
          title,
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
          height: 1.15,
          maxLines: 2,
          textOverflow: TextOverflow.ellipsis,
        ),
        // const CustomVerticalSpace(height: 15.0),
        CustomTextWidget(
          subtitle,
          height: 1.25,
          fontColor: Colors.black87,
          maxLines: 3,
          textOverflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  /* String _getTitle() {
    if (currentSize.width >= 300.0) {
      return title.length > 65 ? title.substring(0, 65) + "..." : title;
    } else {
      return title.length > 35 ? title.substring(0, 35) + "..." : title;
    }
  }

  String _getSubtitle() {
    if (currentSize.width >= 300.0) {
      return subtitle.length > 145
          ? subtitle.substring(0, 145) + "..."
          : subtitle;
    } else {
      return subtitle.length > 65
          ? subtitle.substring(0, 65) + "..."
          : subtitle;
    }
  }

 */
}
