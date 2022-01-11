import 'package:flutter/material.dart';
import 'package:visual_notes/app/core/core_exports.dart'
    show
        Constants,
        CustomTextFieldWidget,
        TextFieldInfoModel,
        ValidationModel,
        defaultConfiguration;

class AddTitleAndDescriptionWidget extends StatefulWidget {
  final String? defaultTitle;
  final String? defaultDescription;
  final void Function(String?) onSavedTitle;
  final void Function(String?) onSavedDescription;
  const AddTitleAndDescriptionWidget({
    Key? key,
    required this.defaultDescription,
    required this.defaultTitle,
    required this.onSavedTitle,
    required this.onSavedDescription,
  }) : super(key: key);

  @override
  State<AddTitleAndDescriptionWidget> createState() =>
      _AddTitleAndDescriptionWidgetState();
}

class _AddTitleAndDescriptionWidgetState
    extends State<AddTitleAndDescriptionWidget> {
  late List<TextFieldInfoModel> _listOfTextFields;
  late Map<String, TextEditingController> _textEditingControllers;
  late Map<String, FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _listOfTextFields =
        TextFieldInfoModel.getListOfTextFieldsInfoFromListOfJson(
      defaultConfiguration["VisualNoteInfoTextFields"],
    );

    _textEditingControllers = {};
    _focusNodes = {};
    for (var field in _listOfTextFields) {
      _textEditingControllers[field.fieldKey] = TextEditingController();
      _focusNodes[field.fieldKey] = FocusNode();
    }

    _textEditingControllers[Constants.visualNoteTitleKey]!.text =
        widget.defaultTitle ?? "";
    _textEditingControllers[Constants.visualNoteDescriptionKey]!.text =
        widget.defaultDescription ?? "";
  }

  @override
  void dispose() {
    for (var field in _listOfTextFields) {
      _textEditingControllers[field.fieldKey]?.clear();
      _textEditingControllers[field.fieldKey]?.dispose();

      _focusNodes[field.fieldKey]?.unfocus();
      _focusNodes[field.fieldKey]?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _listOfTextFields
          .map((field) => CustomTextFieldWidget(
                controller: _textEditingControllers[field.fieldKey]!,
                focusNode: _focusNodes[field.fieldKey],
                label: field.labelKey!,
                hintText: field.hintKey!,
                obsecureText: field.obsecure!,
                maxLines: field.maxLines,
                readOnly: field.readOnly!,
                textInputAction: field.inputAction,
                keyboardType: field.inputType,
                validator: (value) =>
                    _onValidate(field.fieldKey, value, field.validation!),
                onChanged: (value) => _onSavedInfo(value, field.fieldKey),
              ))
          .toList(),
    );
  }

  String? _onValidate(String type, String? value, ValidationModel? validation) {
    if (validation == null) {
      // _onSavedInfo(value ?? '', type);
      return null;
    } else {
      // send null until value match validation
      // _onSavedInfo(null, type);
      RegExp regExp = RegExp(
        validation.pattern != null ? validation.pattern! : "",
      );
      value = value != null ? value.trim() : "";
      if (validation.required != null &&
          validation.required! &&
          value.isEmpty) {
        return validation.requiredError!;
      } else if (validation.minLength != null &&
          value.isNotEmpty &&
          (value.length < validation.minLength!)) {
        return validation.minLengthError!;
      } else if (validation.maxLength != null &&
          value.isNotEmpty &&
          (value.length > validation.maxLength!)) {
        return validation.maxLengthError!;
      } else if (validation.pattern != null &&
          value.isNotEmpty &&
          !regExp.hasMatch(value)) {
        return validation.patternError!;
      } else {
        // _onSavedInfo(value, type);
        return null;
      }
    }
  }

  void _onSavedInfo(String? value, String type) {
    switch (type) {
      case Constants.visualNoteTitleKey:
        widget.onSavedTitle(value!.isEmpty ? null : value);
        break;
      case Constants.visualNoteDescriptionKey:
        widget.onSavedDescription(value!.isEmpty ? null : value);
        break;
    }
  }
}
