import 'package:visual_notes/app/core/core_exports.dart' show ValidationModel;
import 'package:flutter/material.dart' show TextInputAction, TextInputType;

class TextFieldInfoModel {
  final int? id;
  final String fieldKey;
  final String? hintKey;
  final String? labelKey;
  final String? prefixIcon;
  final String? suffixIcon;
  final bool? obsecure;
  final int? maxLines;
  final bool? readOnly;
  final TextInputAction? inputAction;
  final TextInputType? inputType;
  final String? nextFocusKey;
  final ValidationModel? validation;

  TextFieldInfoModel({
    this.id,
    required this.fieldKey,
    this.hintKey,
    this.labelKey,
    this.prefixIcon,
    this.suffixIcon,
    this.obsecure,
    this.maxLines,
    this.readOnly,
    this.inputAction,
    this.inputType,
    this.nextFocusKey,
    this.validation,
  });

  factory TextFieldInfoModel.fromJson(Map<String, dynamic> json) =>
      TextFieldInfoModel(
        id: json['id'] ?? 0,
        fieldKey: json['fieldKey'],
        hintKey: json['hintKey'] ?? '',
        labelKey: json['labelKey'] ?? '',
        prefixIcon: json['prefixIcon'] ?? '',
        suffixIcon: json['suffixIcon'] ?? '',
        obsecure: json['obsecure'] ?? false,
        maxLines: json['maxLines'],
        readOnly: json['readOnly'] ?? false,
        inputAction: json['inputAction'],
        inputType: json['inputType'],
        nextFocusKey: json['nextFocusfieldKey'] ?? '',
        validation: json['validation'],
      );

  static List<TextFieldInfoModel> getListOfTextFieldsInfoFromListOfJson(
    List<dynamic> json,
  ) =>
      List.generate(
        json.length,
        (index) => TextFieldInfoModel.fromJson(json[index]),
      );
}
