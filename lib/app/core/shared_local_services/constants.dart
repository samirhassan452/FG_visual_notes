import 'package:flutter/material.dart' show SizedBox;

class Constants {
  // vertical space
  static const SizedBox verticalSpaceSmall = SizedBox(height: 12.0);
  static const SizedBox verticalSpaceMedium = SizedBox(height: 24.0);
  static const SizedBox verticalSpaceLarge = SizedBox(height: 60.0);

  // horizontal space
  static const SizedBox horizontalSpaceSmall = SizedBox(width: 12.0);
  static const SizedBox horizontalSpaceMedium = SizedBox(width: 24.0);
  static const SizedBox horizontalSpaceLarge = SizedBox(width: 60.0);

  // Default padding
  static const double semiSmallPadding = 8.0;
  static const double smallPadding = 12.0;
  static const double semiMediumPadding = 18.0;
  static const double mediumPadding = 24.0;
  static const double semiLargePadding = 32.0;
  static const double largePadding = 60.0;

  /// keys
  // visual note key
  static const String visualNotePictureKey = 'visual-note-picture';
  static const String visualNoteTitleKey = 'visual-note-title';
  static const String visualNoteDescriptionKey = 'visual-note-description';
  static const String visualNoteStatusKey = 'visual-note-status';

  /// icons

  /// images
  static const String logoImg = 'assets/images/logo.png';
  static const String placeholderImg = 'assets/images/placeholder.jpg';
}
