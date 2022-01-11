import 'package:flutter/material.dart' show WidgetsFlutterBinding, runApp;
import 'package:visual_notes/app/app.dart';
import 'package:visual_notes/app/core/core_exports.dart';

void main() {
  // wait untill everything is initilaized if needed before run app
  WidgetsFlutterBinding.ensureInitialized();
  // initialize db services
  DatabaseServices().init();
  runApp(const App());
}
