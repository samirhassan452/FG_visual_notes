import 'package:flutter/material.dart';

import 'package:visual_notes/app/core/core_exports.dart'
    show AppColors, Constants, CustomTextWidget, CustomVerticalSpace;

class CustomRadioButtonWidget extends StatelessWidget {
  final double height;
  final double width;
  final Color borderColor;
  final Color borderSelectedColor;
  final double borderRadius;
  final Function(dynamic) onSelected;
  final bool isSelected;
  final Color backgroundColor;
  final Color? backgroundSelectedColor;
  final double space;
  final EdgeInsetsGeometry? padding;
  final double horizontalPadding;
  final double verticalPadding;
  final double radioHeight;
  final double radioWidth;
  final Color radioSelectedColor;
  final Color radioUnSelectedColor;
  final dynamic radioValue;
  final dynamic radioGroupValue;
  final String title;
  final Color titleColor;
  final double titleSize;
  final FontWeight? titleFontWeight;

  final String? errorMsg;
  CustomRadioButtonWidget({
    Key? key,
    this.height = 60.0,
    this.width = double.infinity,
    this.borderColor = Colors.black54,
    this.borderSelectedColor = AppColors.facegraphColor,
    this.borderRadius = 4.0,
    required this.onSelected,
    this.isSelected = false,
    this.backgroundColor = Colors.transparent,
    this.backgroundSelectedColor,
    this.space = 12.0,
    this.padding,
    this.horizontalPadding = 16.0,
    this.verticalPadding = 0.0,
    this.radioHeight = 25.0,
    this.radioWidth = 25.0,
    this.radioSelectedColor = AppColors.facegraphColor,
    this.radioUnSelectedColor = Colors.white60,
    required this.radioValue,
    required this.radioGroupValue,
    required this.title,
    this.titleColor = Colors.black,
    this.titleSize = 18.0,
    this.titleFontWeight,
    this.errorMsg,
  }) : super(key: key);

  final Color _unselectedBorderColor = Colors.blue[100]!;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: height,
          width: width,
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(bottom: Constants.semiMediumPadding),
          decoration: BoxDecoration(
            border: Border.all(
              color: (isSelected || radioGroupValue == radioValue)
                  ? borderSelectedColor
                  : borderColor,
            ),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: ListTile(
            // dense: true,
            onTap: () => onSelected(radioValue),
            selected: (isSelected || radioGroupValue == radioValue),
            tileColor: backgroundColor,
            selectedTileColor: backgroundSelectedColor ?? Colors.blue[200],
            horizontalTitleGap: space,
            minLeadingWidth: 0.0,
            minVerticalPadding: 0.0,
            contentPadding: padding ??
                EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: verticalPadding,
                ),
            leading: _RadioWidget(
              width: radioWidth,
              height: radioHeight,
              color: (isSelected || radioGroupValue == radioValue)
                  ? radioSelectedColor
                  : radioUnSelectedColor,
              borderColor: (isSelected || radioGroupValue == radioValue)
                  ? radioSelectedColor
                  : _unselectedBorderColor,
            ),
            title: Container(
              // color: Colors.blue,
              height: radioHeight,
              alignment: Alignment.centerLeft,
              child: CustomTextWidget(
                title,
                fontWeight: titleFontWeight,
                fontColor: titleColor,
                textAlign: TextAlign.start,
                fontSize: titleSize,
              ),
            ),
          ),
        ),
        if (errorMsg != null && errorMsg!.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomVerticalSpace(height: 8.0),
              CustomTextWidget(
                errorMsg!,
                fontSize: 13.0,
                fontColor: AppColors.error,
              ),
            ],
          ),
      ],
    );
  }
}

class _RadioWidget extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Color borderColor;
  const _RadioWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.color,
    required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: borderColor),
      ),
      child: Container(
        width: width / 3.0,
        height: height / 3.0,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}


/*
Radio<dynamic>(
              activeColor: radioSelectedColor,
              toggleable: true,
              value: radioValue,
              groupValue: radioGroupValue,
              onChanged: (newVal) {
                // print(newVal);
              },
            )
*/