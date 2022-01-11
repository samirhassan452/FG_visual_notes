import 'package:flutter/material.dart';
import 'package:visual_notes/app/core/core_exports.dart'
    show CustomHorizontalSpace, CustomTextWidget;

class CustomViewVisualNoteCardWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  const CustomViewVisualNoteCardWidget({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextWidget(
          "$title: ",
          textAlign: TextAlign.start,
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
        ),
        const CustomHorizontalSpace(width: 5.0),
        Expanded(
          child: CustomTextWidget(
            subtitle,
            textAlign: TextAlign.start,
            fontSize: 16.0,
            fontColor: Colors.black87,
            height: 1.2,
          ),
        ),
      ],
    );
  }
}
