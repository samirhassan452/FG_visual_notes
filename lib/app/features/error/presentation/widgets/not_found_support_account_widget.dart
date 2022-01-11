import 'package:visual_notes/app/core/core_exports.dart' show CustomTextWidget;
import 'package:flutter/material.dart';

class NotFoundSupportAccountWidget extends StatelessWidget {
  const NotFoundSupportAccountWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomTextWidget(
      "support@facegraph.com",
      fontColor: Colors.black45,
      fontWeight: FontWeight.bold,
      fontSize: 18.0,
    );
  }
}
