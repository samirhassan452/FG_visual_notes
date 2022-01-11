import 'package:visual_notes/app/core/core_exports.dart' show CustomTextWidget;
import 'package:flutter/material.dart';

class NotFoundTitleWidget extends StatelessWidget {
  const NotFoundTitleWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomTextWidget(
      "Opps, this page does not exist",
      fontColor: Colors.black54,
      fontWeight: FontWeight.bold,
      fontSize: 20.0,
    );
  }
}
