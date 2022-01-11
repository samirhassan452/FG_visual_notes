import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final String? fontFamily;
  final Color fontColor;
  final FontWeight? fontWeight;
  final double height;
  final TextOverflow textOverflow;
  final TextAlign textAlign;
  final TextDecoration textDecoration;
  final double textDecorationThickness;
  final Color? textDecorationColor;
  final TextDirection? textDirection;
  final int? maxLines;
  const CustomTextWidget(
    this.text, {
    Key? key,
    this.fontSize = 16.0,
    this.fontFamily,
    this.fontColor = Colors.black,
    this.fontWeight,
    this.height = 1.0,
    this.textAlign = TextAlign.start,
    this.textOverflow = TextOverflow.visible,
    this.textDecoration = TextDecoration.none,
    this.textDecorationThickness = 1.5,
    this.textDecorationColor,
    this.textDirection,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: textOverflow,
      textDirection: textDirection,
      maxLines: maxLines,
      style: TextStyle(
        fontSize: fontSize,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
        color: fontColor,
        height: height,
        decoration: textDecoration,
        decorationThickness: textDecorationThickness,
        decorationColor: textDecorationColor ?? fontColor,
      ),
    );
  }
}
