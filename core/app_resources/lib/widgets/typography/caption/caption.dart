import 'package:app_resources/resources/all.dart';
import 'package:flutter/material.dart';
import '../app_text/app_text.dart';

class Caption extends AppText {
  static TextStyle get defaultStyle => TextStyle(
        fontSize: AppDimensions.captionFontSize,
        color: AppScheme.colors.surface,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.01,
        height: 1.6,
      );

  Caption(
    super.data, {
    super.key,
    super.style,
    super.color,
    super.textAlign = TextAlign.left,
    super.overflow,
    super.maxLines,
  }) : super(fallbackStyle: defaultStyle);
}

class Caption2 extends AppText {
  static TextStyle get defaultStyle => TextStyle(
        fontSize: AppDimensions.caption2FontSize,
        color: AppScheme.colors.surface,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.01,
        height: 1.6,
      );

  Caption2(
    super.data, {
    super.key,
    super.style,
    super.color,
    super.textAlign = TextAlign.left,
    super.overflow,
    super.maxLines,
  }) : super(fallbackStyle: defaultStyle);
}
