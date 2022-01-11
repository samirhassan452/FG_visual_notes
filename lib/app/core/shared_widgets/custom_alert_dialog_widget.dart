import 'package:visual_notes/app/core/core_exports.dart'
    show
        AppColors,
        Constants,
        CustomTextButtonWidget,
        CustomTextWidget,
        POP_UP_MESSAGE_TYPE;
import 'package:flutter/material.dart';

class CustomAlertDialogWidget extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final double radius;
  final BorderSide? borderSide;
  final Color borderSideColor;
  final EdgeInsets insetPadding;
  final EdgeInsetsGeometry buttonPadding;
  final EdgeInsetsGeometry actionsPadding;
  final EdgeInsetsGeometry contentPadding;
  final Widget? title;
  final EdgeInsetsGeometry titlePadding;
  final BoxBorder? titleBorder;
  final Color titleBorderColor;
  final double titleBorderWidth;
  final POP_UP_MESSAGE_TYPE titleMessageType;
  final String? titleText;
  final Color titleTextColor;
  final double titleTextSize;
  final FontWeight? titleTextWeight;
  final Widget? content;
  final String? contentText;
  final Color contentTextColor;
  final List<Widget>? actions;
  final VoidCallback? primaryBtnPressed;
  final String? primaryBtnText;
  final VoidCallback? secondaryBtnPressed;
  final String? secondaryBtnText;
  const CustomAlertDialogWidget({
    Key? key,
    this.borderRadius,
    this.radius = 10.0,
    this.borderSide,
    this.borderSideColor = Colors.transparent,
    this.insetPadding = const EdgeInsets.symmetric(
      horizontal: Constants.mediumPadding,
    ),
    this.buttonPadding = EdgeInsets.zero,
    this.actionsPadding = EdgeInsets.zero,
    this.contentPadding = const EdgeInsets.symmetric(
      vertical: Constants.semiMediumPadding,
      horizontal: Constants.mediumPadding,
    ),
    this.title,
    this.titlePadding = const EdgeInsets.symmetric(
      vertical: Constants.smallPadding,
    ),
    this.titleBorder,
    this.titleBorderColor = Colors.black,
    this.titleBorderWidth = 1.0,
    this.titleMessageType = POP_UP_MESSAGE_TYPE.none,
    this.titleText,
    this.titleTextColor = Colors.black,
    this.titleTextSize = 20.0,
    this.titleTextWeight,
    this.content,
    this.contentText,
    this.contentTextColor = Colors.black45,
    this.actions,
    this.primaryBtnPressed,
    this.primaryBtnText,
    this.secondaryBtnPressed,
    this.secondaryBtnText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(radius)),
        side: borderSide ?? BorderSide(color: borderSideColor),
      ),
      insetPadding: insetPadding,
      titlePadding: EdgeInsets.zero,
      buttonPadding: buttonPadding,
      actionsPadding: actionsPadding,
      contentPadding: contentPadding,
      title: title ??
          Container(
            padding: titlePadding,
            decoration: BoxDecoration(
              border: titleBorder ??
                  Border(
                    bottom: BorderSide(
                      color: titleBorderColor,
                      width: titleBorderWidth,
                    ),
                  ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _getIconMessageBasedType() ?? const SizedBox(),
                if (titleMessageType != POP_UP_MESSAGE_TYPE.none)
                  Constants.horizontalSpaceSmall,
                CustomTextWidget(
                  _getTitleMessageBasedType(),
                  fontColor: titleTextColor,
                  fontSize: titleTextSize,
                  fontWeight: titleTextWeight,
                ),
                if (titleMessageType != POP_UP_MESSAGE_TYPE.none)
                  Constants.horizontalSpaceSmall,
                _getIconMessageBasedType() ?? const SizedBox(),
              ],
            ),
          ),
      content: content ??
          CustomTextWidget(
            contentText ?? "There is no text to display.",
            fontColor: contentTextColor,
          ),
      actions: actions ??
          [
            CustomTextButtonWidget(
              btnPressed:
                  primaryBtnPressed ?? () => Navigator.of(context).pop(true),
              btnText: primaryBtnText ?? "Ok",
            ),
            if (secondaryBtnPressed != null && secondaryBtnText != null)
              CustomTextButtonWidget(
                btnPressed: secondaryBtnPressed!,
                btnText: secondaryBtnText!,
              ),
          ],
    );
  }

  String _getTitleMessageBasedType() {
    switch (titleMessageType) {
      case POP_UP_MESSAGE_TYPE.error:
        return "Error";
      case POP_UP_MESSAGE_TYPE.warning:
        return "Warning";
      case POP_UP_MESSAGE_TYPE.success:
        return "Success";
      case POP_UP_MESSAGE_TYPE.confirm:
        return "Confirm";
      default:
        return "There is no title to display.";
    }
  }

  Icon? _getIconMessageBasedType() {
    switch (titleMessageType) {
      case POP_UP_MESSAGE_TYPE.error:
        return const Icon(
          Icons.error_outline_rounded,
          color: AppColors.error,
          size: 25,
        );
      case POP_UP_MESSAGE_TYPE.warning:
        return const Icon(
          Icons.warning_amber_rounded,
          color: AppColors.warning,
          size: 25,
        );
      case POP_UP_MESSAGE_TYPE.success:
        return const Icon(
          Icons.check_circle_outline_rounded,
          color: AppColors.success,
          size: 25,
        );
      case POP_UP_MESSAGE_TYPE.confirm:
        return const Icon(
          Icons.check_circle_outline_rounded,
          color: AppColors.success,
          size: 25,
        );
      default:
        return null;
    }
  }
}
