import 'package:flutter/material.dart';
import 'package:visual_notes/app/core/core_exports.dart'
    show ACTION_BUTTON_TYPE;
import 'package:visual_notes/app/features/home/home_exports.dart'
    show ActionButtonWidget;

class CardVerticalBarActionButtonsWidget extends StatelessWidget {
  final VoidCallback onView;
  final VoidCallback onUpdate;
  final VoidCallback onDelete;
  const CardVerticalBarActionButtonsWidget({
    Key? key,
    required this.onView,
    required this.onUpdate,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(4.0),
          bottomRight: Radius.circular(4.0),
        ),
      ),
      margin: EdgeInsets.zero,
      elevation: 12.0,
      child: Column(
        children: [
          // view button
          Expanded(
            child: ActionButtonWidget(
              onPressed: onView,
              actionButtonType: ACTION_BUTTON_TYPE.view,
            ),
          ),
          // update button
          Expanded(
            child: ActionButtonWidget(
              onPressed: onUpdate,
              actionButtonType: ACTION_BUTTON_TYPE.update,
            ),
          ),
          // delete button
          Expanded(
            child: ActionButtonWidget(
              onPressed: onDelete,
              actionButtonType: ACTION_BUTTON_TYPE.delete,
            ),
          ),
        ],
      ),
    );
  }
}
