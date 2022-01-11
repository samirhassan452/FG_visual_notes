import 'package:visual_notes/app/core/core_exports.dart'
    show CustomAlertDialogWidget, NavigationService, POP_UP_MESSAGE_TYPE;
import 'package:flutter/material.dart';

class CustomPopUpsWidgets {
  static Future<bool> showCloseAppOrDeleteMessageDialog(String msg) async =>
      (await showGeneralDialog<bool>(
        barrierColor: Colors.black.withOpacity(0.6),
        transitionBuilder: (context, a1, a2, widget) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Transform.scale(
              scale: a1.value,
              child: Opacity(
                opacity: a1.value,
                child: CustomAlertDialogWidget(
                  titleMessageType: POP_UP_MESSAGE_TYPE.confirm,
                  contentText: msg,
                  primaryBtnPressed: () => Navigator.of(context).pop(true),
                  primaryBtnText: "Yes",
                  secondaryBtnPressed: () => Navigator.of(context).pop(false),
                  secondaryBtnText: "No",
                ),
              ),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
        barrierDismissible: false,
        barrierLabel: '',
        context: NavigationService.navigatorKey.currentContext!,
        pageBuilder: (context, animation1, animation2) {
          return const SizedBox();
        },
      )) ??
      false;

  static Future<bool> showWarningMessageDialog(String msg) async =>
      (await showGeneralDialog<bool>(
        barrierColor: Colors.black.withOpacity(0.6),
        transitionBuilder: (context, a1, a2, widget) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Transform.scale(
              scale: a1.value,
              child: Opacity(
                opacity: a1.value,
                child: CustomAlertDialogWidget(
                  titleMessageType: POP_UP_MESSAGE_TYPE.warning,
                  contentText: msg,
                ),
              ),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
        barrierDismissible: false,
        barrierLabel: '',
        context: NavigationService.navigatorKey.currentContext!,
        pageBuilder: (context, animation1, animation2) {
          return const SizedBox();
        },
      )) ??
      false;
}
