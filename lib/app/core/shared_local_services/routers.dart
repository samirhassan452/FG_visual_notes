import 'package:flutter/material.dart'
    show MaterialPageRoute, Route, RouteSettings;
import 'package:visual_notes/app/core/core_exports.dart' show RoutesNames;
import 'package:visual_notes/app/features/error/error_exports.dart'
    show ErrorNotFoundScreen;
import 'package:visual_notes/app/features/home/home_exports.dart'
    show HomeScreen;
import 'package:visual_notes/app/features/splash/splash_exports.dart'
    show SplashScreen;
import 'package:visual_notes/app/features/visual_note/visual_note_exports.dart'
    show AddEditVisualNoteScreen, ViewVisualNoteScreen;

class Routers {
  static Route<dynamic> allRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesNames.splashRoute:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case RoutesNames.homeRoute:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case RoutesNames.addEditVisualNoteRoute:
        final args = settings.arguments != null
            ? settings.arguments as AddEditVisualNoteScreen
            : null;
        return MaterialPageRoute(
          builder: (_) => AddEditVisualNoteScreen(
            visualNoteData: args?.visualNoteData,
          ),
        );
      case RoutesNames.viewVisualNoteRoute:
        final args = settings.arguments as ViewVisualNoteScreen;
        return MaterialPageRoute(
          builder: (_) => ViewVisualNoteScreen(
            visualNoteData: args.visualNoteData,
          ),
        );
      default:
        return MaterialPageRoute(builder: (_) => const ErrorNotFoundScreen());
    }
  }
}
