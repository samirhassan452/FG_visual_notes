import 'package:visual_notes/app/core/core_exports.dart'
    show Constants, ValidationModel;
import 'package:flutter/material.dart' show TextInputAction, TextInputType;

Map<String, dynamic> defaultConfiguration = {
  "VisualNoteInfoTextFields": [
    {
      "id": 1,
      "fieldKey": Constants.visualNoteTitleKey,
      "hintKey": "Write title here...",
      "labelKey": "Title",
      "prefixIcon": "",
      "suffixIcon": "",
      "obsecure": false,
      "maxLines": 1,
      "readOnly": false,
      "inputAction": TextInputAction.next,
      "inputType": TextInputType.text,
      "nextFocusfieldKey": Constants.visualNoteDescriptionKey,
      "validation": ValidationModel(
        required: true,
        requiredError: "Title is required",
        minLength: 5,
        minLengthError: "Title must be greater than 5 characters",
        maxLength: 20,
        maxLengthError: "Title must be less than 20 characters",
      ),
    },
    {
      "id": 2,
      "fieldKey": Constants.visualNoteDescriptionKey,
      "hintKey": "Write description here...",
      "labelKey": "Description",
      "prefixIcon": "",
      "suffixIcon": "",
      "obsecure": false,
      "maxLines": 3,
      "readOnly": false,
      "inputAction": TextInputAction.done,
      "inputType": TextInputType.text,
      "nextFocusfieldKey": "",
      "validation": ValidationModel(
        required: true,
        requiredError: "Description is required",
        minLength: 10,
        minLengthError: "Description must be greater than 10 characters",
        maxLength: 100,
        maxLengthError: "Description must be less than 100 characters",
      ),
    },
  ],
  "VisualNoteStatus": [
    {
      "id": 1,
      "radioValue": "Open",
      "radioGroupValue": "",
      "titleKey": "Open",
    },
    {
      "id": 2,
      "radioValue": "Closed",
      "radioGroupValue": "",
      "titleKey": "Closed",
    },
  ],
};
