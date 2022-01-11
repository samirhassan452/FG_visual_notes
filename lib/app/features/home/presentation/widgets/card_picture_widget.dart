import 'dart:convert' show base64Decode;

import 'package:flutter/material.dart';
import 'package:visual_notes/app/core/core_exports.dart' show AppColors;

class CardPictureWidget extends StatelessWidget {
  final String picture;
  final double cardHeight;
  const CardPictureWidget({
    Key? key,
    required this.picture,
    required this.cardHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      // color: Colors.amber,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.facegraphColor),
      ),
      width: width > 460.0 ? 110.0 : 90.0,
      height: cardHeight,
      child: Image.memory(base64Decode(picture), fit: BoxFit.cover),
    );
  }
}
