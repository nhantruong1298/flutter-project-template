import 'package:app_resources/app_resources.dart';
import 'package:flutter/material.dart';

import '../app_text/app_text.dart';

class Body extends AppText {
  static TextStyle get defaultStyle => TextStyle(
        fontSize: AppDimensions.bodyFontSize,
        color: AppScheme.colors.surface,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.01,
        height: 1.6,
      );

  Body(
    super.data, {
    super.key,
    super.style,
    super.color,
    super.textAlign = TextAlign.left,
    super.overflow,
    super.maxLines,
  }) : super(fallbackStyle: defaultStyle);
}
