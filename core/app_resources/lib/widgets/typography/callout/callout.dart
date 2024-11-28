import 'package:app_resources/resources/all.dart';
import 'package:flutter/material.dart';
import '../app_text/app_text.dart';

class Callout extends AppText {
  static TextStyle get defaultStyle => TextStyle(
        fontSize: AppDimensions.calloutFontSize,
        color: AppScheme.colors.surface,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.01,
        height: 1.6,
      );

  Callout(
    super.data, {
    super.key,
    super.style,
    super.color,
    super.textAlign = TextAlign.left,
    super.overflow,
    super.maxLines,
  }) : super(fallbackStyle: defaultStyle);
}
