import 'dart:async' show StreamController;

import 'package:visual_notes/app/core/core_exports.dart'
    show
        AppColors,
        Constants,
        CustomHorizontalSpace,
        CustomPopUpsWidgets,
        CustomTextWidget,
        CustomVerticalSpace;
import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatefulWidget {
  // if app in different languages, pass the key to search about word
  final String label;
  final Color labelColor;
  final double labelSize;
  final TextAlign labelTextAlign;

  final bool filled;
  final Color fillColor;
  final double borderWidth;
  final double borderRadius;
  final Color borderColor;

  final TextEditingController controller;
  final FocusNode? focusNode;
  final bool autoCorrect;
  final bool readOnly;
  final Color cursorColor;
  final TextAlign textFieldAlign;
  final TextInputType? keyboardType;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final TextAlignVertical textAlignVertical;
  final TextInputAction? textInputAction;
  final bool obsecureText;
  final TextStyle? textFieldStyle;
  final double contentVerticalPadding;
  final double contentHorizontalPadding;
  final String hintText;
  final TextStyle? hintStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int errorMaxLines;
  final bool isRequired;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final VoidCallback? onTap;
  const CustomTextFieldWidget({
    Key? key,
    required this.label,
    this.labelColor = Colors.black,
    this.labelSize = 14.0,
    this.labelTextAlign = TextAlign.start,
    this.filled = true,
    this.fillColor = Colors.white,
    this.borderWidth = 1.0,
    this.borderRadius = 2.0,
    this.borderColor = AppColors.facegraphColor,
    required this.controller,
    this.focusNode,
    this.autoCorrect = true,
    this.readOnly = false,
    this.cursorColor = AppColors.facegraphColor,
    this.textFieldAlign = TextAlign.start,
    this.keyboardType,
    this.maxLength,
    this.maxLines,
    this.minLines,
    this.textAlignVertical = TextAlignVertical.center,
    this.textInputAction = TextInputAction.done,
    this.obsecureText = false,
    this.textFieldStyle,
    this.contentHorizontalPadding = 0,
    this.contentVerticalPadding = Constants.semiSmallPadding - 4,
    this.hintText = '',
    this.hintStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.errorMaxLines = 2,
    this.isRequired = true,
    this.onFieldSubmitted,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.onTap,
  }) : super(key: key);

  @override
  State<CustomTextFieldWidget> createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  late StreamController<String?> _errorStreamController;

  @override
  void initState() {
    _errorStreamController = StreamController<String?>();
    super.initState();
  }

  @override
  void dispose() {
    _errorStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // label
        if (widget.label.isNotEmpty)
          Row(
            children: [
              CustomTextWidget(
                widget.label,
                fontColor: widget.labelColor,
                fontSize: widget.labelSize,
                textAlign: widget.labelTextAlign,
              ),
              if (widget.isRequired)
                CustomTextWidget(
                  " *",
                  fontColor: AppColors.redBrown,
                  fontSize: widget.labelSize,
                  textAlign: widget.labelTextAlign,
                ),
            ],
          ),
        Container(
          margin: const EdgeInsets.only(top: Constants.smallPadding),
          decoration: BoxDecoration(
            color: widget.readOnly ? Colors.grey[850] : widget.fillColor,
            border: Border.all(
                width: widget.borderWidth, color: widget.borderColor),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Row(
                children: [
                  // prefix
                  if (widget.prefixIcon != null)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomHorizontalSpace(width: 5.0),
                        SizedBox(
                          width: 25.0,
                          height: 25.0,
                          child: FittedBox(child: widget.prefixIcon),
                        ),
                        const CustomHorizontalSpace(width: 5.0),
                      ],
                    ),
                  // text field
                  SizedBox(
                    width: _getTextFieldWidth(constraints.maxWidth),
                    child: TextFormField(
                      controller: widget.controller,
                      focusNode: widget.focusNode ?? FocusNode(),
                      autocorrect: widget.autoCorrect,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      readOnly: widget.readOnly,
                      cursorColor: widget.cursorColor,
                      keyboardType: widget.keyboardType,
                      maxLines: widget.obsecureText ? 1 : widget.maxLines,
                      maxLength: widget.maxLength,
                      minLines: widget.obsecureText ? 1 : widget.minLines,
                      obscureText: widget.obsecureText,
                      textAlignVertical: widget.textAlignVertical,
                      textInputAction: widget.textInputAction,
                      style: widget.textFieldStyle ??
                          const TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                            letterSpacing: 0.5,
                          ),
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: Constants.semiSmallPadding,
                          vertical: Constants.smallPadding,
                        ),
                        // counter: const SizedBox(),
                        hintText: widget.hintText,
                        hintStyle: widget.hintStyle ??
                            const TextStyle(
                              fontSize: 16.0,
                              color: Colors.black45,
                              letterSpacing: 0.5,
                            ),
                        filled: widget.filled,
                        fillColor: widget.readOnly
                            ? Colors.grey[850]
                            : widget.fillColor,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        errorMaxLines: widget.errorMaxLines,
                      ),
                      onChanged: widget.onChanged,
                      onFieldSubmitted: widget.onFieldSubmitted,
                      validator: (error) {
                        _errorStreamController.sink
                            .add(widget.validator!(error));
                        return null;
                      },
                      onSaved: widget.onSaved,
                      onTap: widget.readOnly
                          ? () => CustomPopUpsWidgets.showWarningMessageDialog(
                                "This field readonly",
                              )
                          : widget.onTap,
                    ),
                  ),
                  // suffix
                  if (widget.suffixIcon != null)
                    Row(
                      children: [
                        const CustomHorizontalSpace(width: 5.0),
                        SizedBox(
                          width: 25.0,
                          height: 25.0,
                          child: FittedBox(child: widget.suffixIcon),
                        ),
                        const CustomHorizontalSpace(width: 5.0),
                      ],
                    ),
                ],
              );
            },
          ),
        ),
        // show error here instead of textformfield
        StreamBuilder<String?>(
          initialData: null,
          stream: _errorStreamController.stream,
          builder: (context, snapshot) {
            return snapshot.data == null
                ? const SizedBox()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomVerticalSpace(height: 5.0),
                      CustomTextWidget(
                        snapshot.data!,
                        fontColor: AppColors.redBrown,
                        fontSize: 13.0,
                        textAlign: TextAlign.start,
                        height: 1.2,
                      ),
                    ],
                  );
          },
        ),
        const CustomVerticalSpace(height: 30.0),
      ],
    );
  }

  double _getTextFieldWidth(double width) {
    if (widget.suffixIcon != null && widget.prefixIcon != null) {
      // 35.0 for prefix & 35.0 for
      // 5 space + 30 width + 5 space
      return width - 70.0;
    } else if (widget.suffixIcon != null || widget.prefixIcon != null) {
      return width - 35.0;
    } else {
      return width;
    }
  }
}


/* child: Row(
                children: [
                  if (prefixIcon != null)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomHorizontalSpace(width: 5.0),
                        SizedBox(
                          width: 25.0,
                          height: 25.0,
                          child: FittedBox(child: prefixIcon),
                        ),
                        const CustomHorizontalSpace(width: 5.0),
                      ],
                    ),
                  SizedBox(
                    width: _getTextFieldWidth(constraints.maxWidth),
                    child: TextFormField(
                      controller: controller,
                      focusNode: focusNode ?? FocusNode(),
                      autocorrect: autoCorrect,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      readOnly: readOnly,
                      cursorColor: cursorColor,
                      keyboardType: keyboardType,
                      maxLines: obsecureText ? 1 : maxLines,
                      maxLength: maxLength,
                      minLines: obsecureText ? 1 : minLines,
                      obscureText: obsecureText,
                      textAlignVertical: textAlignVertical,
                      textInputAction: textInputAction,
                      style: textFieldStyle ??
                          const TextStyle(
                            fontSize: 16.0,
                            color: AppColors.black,
                            letterSpacing: 0.5,
                          ),
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        // counter: const SizedBox(),
                        hintText: hintText,
                        hintStyle: hintStyle ??
                            const TextStyle(
                              fontSize: 16.0,
                              color: AppColors.black300,
                              letterSpacing: 0.5,
                            ),
                        filled: filled,
                        fillColor: readOnly ? AppColors.black400 : Colors.red,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        errorMaxLines: errorMaxLines,
                      ),
                      onFieldSubmitted: (val) => onFieldSubmitted!(val),
                      validator: (val) => validator!(val),
                      onSaved:
                          onSaved == null ? (val) {} : (val) => onSaved!(val),
                      onTap: readOnly
                          ? () => CustomPopUpsWidgets.showWarningMessageDialog(
                                context,
                                Helpers.translatingWord("fieldReadOnlyWord"),
                              )
                          : null,
                    ),
                  ),
                  if (suffixIcon != null)
                    Row(
                      children: [
                        const CustomHorizontalSpace(width: 5.0),
                        SizedBox(
                          width: 25.0,
                          height: 25.0,
                          child: FittedBox(child: suffixIcon),
                        ),
                        const CustomHorizontalSpace(width: 5.0),
                      ],
                    ),
                ],
              ),
             */