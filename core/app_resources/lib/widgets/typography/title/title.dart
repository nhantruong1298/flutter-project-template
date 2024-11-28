import 'package:app_resources/resources/all.dart';
import 'package:flutter/material.dart';
import '../app_text/app_text.dart';

class LargeTitle extends AppText {
  static TextStyle get defaultStyle => TextStyle(
        fontSize: AppDimensions.largeTitleFontSize,
        color: AppScheme.colors.surface,
        fontWeight: FontWeight.w500,
        letterSpacing: -0.01,
        height: 1.6,
        
      );

  LargeTitle(
    super.data, {
    super.key,
    super.style,
    super.color,
    super.textAlign = TextAlign.left,
    super.overflow,
    super.maxLines,
  }) : super(fallbackStyle: defaultStyle);
}

class Title extends AppText {
  static TextStyle get defaultStyle => TextStyle(
        fontSize: 28,
        color: AppScheme.colors.surface,
        fontWeight: FontWeight.w500,
        letterSpacing: -0.01,
        height: 1.6,
      );

  Title(
    super.data, {
    super.key,
    super.style,
    super.color,
    super.textAlign = TextAlign.left,
    super.overflow,
    super.maxLines,
  }) : super(fallbackStyle: defaultStyle);
}

class Title2 extends AppText {
  static TextStyle get defaultStyle => TextStyle(
        fontSize: 22,
        color: AppScheme.colors.surface,
        fontWeight: FontWeight.w500,
        letterSpacing: -0.01,
        height: 1.6,
      );

  Title2(
    super.data, {
    super.key,
    super.style,
    super.color,
    super.textAlign = TextAlign.left,
    super.overflow,
    super.maxLines,
  }) : super(fallbackStyle: defaultStyle);
}

class Title3 extends AppText {
  static TextStyle get defaultStyle => TextStyle(
        fontSize: 20,
        color: AppScheme.colors.surface,
        fontWeight: FontWeight.w500,
        letterSpacing: -0.01,
        height: 1.6,
      );

  Title3(
    super.data, {
    super.key,
    super.style,
    super.color,
    super.textAlign = TextAlign.left,
    super.overflow,
    super.maxLines,
  }) : super(fallbackStyle: defaultStyle);
}








class Footnote extends AppText {
  static TextStyle get defaultStyle => TextStyle(
        fontSize: 13,
        color: AppScheme.colors.surface,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.01,
        height: 1.6,
      );

  Footnote(
    super.data, {
    super.key,
    super.style,
    super.color,
    super.textAlign = TextAlign.left,
    super.overflow,
    super.maxLines,
  }) : super(fallbackStyle: defaultStyle);
}

