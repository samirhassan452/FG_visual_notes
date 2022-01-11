import 'package:flutter/material.dart';
import 'package:visual_notes/app/core/core_exports.dart'
    show AppColors, CustomTextWidget;

class CustomTextButtonWidget extends StatelessWidget {
  final VoidCallback btnPressed;
  final String btnText;
  final Color btnTextColor;
  final FontWeight? btnTextWeight;
  final double btnTextSize;
  final bool haveUnderline;
  final Color? underlineColor;
  const CustomTextButtonWidget({
    Key? key,
    required this.btnPressed,
    required this.btnText,
    this.btnTextColor = AppColors.facegraphColor,
    this.btnTextWeight,
    this.btnTextSize = 18.0,
    this.haveUnderline = false,
    this.underlineColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: btnPressed,
      child: CustomTextWidget(
        btnText,
        fontColor: btnTextColor,
        fontWeight: btnTextWeight,
        fontSize: btnTextSize,
        textDecoration:
            haveUnderline ? TextDecoration.underline : TextDecoration.none,
        textDecorationColor: underlineColor,
      ),
    );
  }
}

class CustomElevatedButtonWidget extends StatelessWidget {
  final VoidCallback? btnPressed;
  final Color btnColor;
  final double btnHeight;
  final double btnWidth;
  final double btnRadius;
  final Color? btnBorderColor;
  final double btnBorderWidth;
  final double btnElevation;
  final AlignmentGeometry btnAlignment;
  final String btnText;
  final Color btnTextColor;
  final FontWeight? btnTextWeight;
  final double btnTextSize;
  final bool btnTextUnderline;
  final Color? btnTextUnderlineColor;
  const CustomElevatedButtonWidget({
    Key? key,
    required this.btnPressed,
    this.btnColor = AppColors.facegraphColor,
    this.btnHeight = 65.0,
    this.btnWidth = double.infinity,
    this.btnRadius = 2.5,
    this.btnBorderColor,
    this.btnBorderWidth = 1.0,
    this.btnElevation = 2.0,
    this.btnAlignment = Alignment.center,
    required this.btnText,
    this.btnTextColor = Colors.white,
    this.btnTextWeight,
    this.btnTextSize = 18.0,
    this.btnTextUnderline = false,
    this.btnTextUnderlineColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: btnColor, // background
        alignment: btnAlignment,
        elevation: btnElevation,
        minimumSize: Size(btnWidth, btnHeight),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(btnRadius),
        ),
        side: BorderSide(
          width: btnBorderWidth,
          color: btnBorderColor ?? btnColor,
        ),
        // padding: Edge
      ),
      onPressed: btnPressed,
      child: CustomTextWidget(
        btnText,
        fontColor: btnTextColor,
        fontWeight: btnTextWeight,
        fontSize: btnTextSize,
        textDecoration:
            btnTextUnderline ? TextDecoration.underline : TextDecoration.none,
        textDecorationColor: btnTextUnderlineColor,
      ),
    );
  }
}

class CustomIconButtonWidget extends StatelessWidget {
  final Color backgroundColor;
  final Color borderColor;
  final double borderRadius;
  final double borderWidth;
  final double btnWidth;
  final double btnHeight;
  final VoidCallback btnPressed;
  final Widget? icon;
  final IconData? materialIcon;
  final Color materialIconColor;
  final double materialIconSize;
  const CustomIconButtonWidget({
    Key? key,
    this.backgroundColor = Colors.transparent,
    this.borderColor = Colors.transparent,
    this.borderRadius = 4.0,
    this.borderWidth = 1.0,
    this.btnHeight = 24.0,
    this.btnWidth = 24.0,
    required this.btnPressed,
    this.icon,
    this.materialIcon,
    this.materialIconColor = Colors.black,
    this.materialIconSize = 18.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: btnWidth,
      height: btnHeight,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor, width: borderWidth),
      ),
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: btnPressed,
        child: icon ??
            Icon(
              materialIcon ?? Icons.arrow_back_ios_new,
              color: materialIconColor,
              size: materialIconSize,
            ),
      ),
    );
  }
}
