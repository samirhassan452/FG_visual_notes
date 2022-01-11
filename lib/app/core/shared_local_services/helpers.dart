import 'dart:developer' as devtools show log;

import 'package:visual_notes/app/core/core_exports.dart'
    show NavigationService, RoutesNames;

// use it insead of print() or debugPrint()
extension Log<T extends Object> on T {
  void log() {
    devtools.log(toString());
  }
}

class Helpers {
  static void backNavigationToSpecificScreen({
    String? navigationKey,
    Object? arguments,
  }) {
    if (NavigationService.navigatorKey.currentState!.canPop()) {
      NavigationService.navigatorKey.currentState!.pop();
    } else {
      NavigationService.navigatorKey.currentState!.pushNamedAndRemoveUntil(
        // navigationKey ?? RoutesNames.BOTTOM_NAVIGATION_ROUTE,
        navigationKey ?? RoutesNames.splashRoute,
        (route) => false,
        arguments: arguments,
      );
    }
  }
}
