import 'package:flutter/material.dart';
import 'package:visual_notes/app/core/core_exports.dart'
    show ACTION_BUTTON_TYPE, AppColors, CustomIconButtonWidget;

class ActionButtonWidget extends StatelessWidget {
  final ACTION_BUTTON_TYPE actionButtonType;
  final VoidCallback onPressed;
  const ActionButtonWidget({
    Key? key,
    required this.actionButtonType,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomIconButtonWidget(
      btnPressed: onPressed,
      backgroundColor: _getBackgroundColorBasedType()!,
      borderRadius: 0.0,
      btnWidth: double.infinity,
      materialIcon: _getIconBasedType(),
      materialIconColor: Colors.white,
      materialIconSize: 27.0,
    );
  }

  IconData? _getIconBasedType() {
    switch (actionButtonType) {
      case ACTION_BUTTON_TYPE.add:
        return Icons.note_add;
      case ACTION_BUTTON_TYPE.view:
        return Icons.remove_red_eye_outlined;

      case ACTION_BUTTON_TYPE.update:
        return Icons.edit;

      case ACTION_BUTTON_TYPE.delete:
        return Icons.delete_outline_rounded;
    }
  }

  Color? _getBackgroundColorBasedType() {
    switch (actionButtonType) {
      case ACTION_BUTTON_TYPE.add:
        return AppColors.facegraphColor;

      case ACTION_BUTTON_TYPE.view:
        return Colors.green[700];

      case ACTION_BUTTON_TYPE.update:
        return Colors.blue[700];

      case ACTION_BUTTON_TYPE.delete:
        return Colors.red[700];
    }
  }
}
