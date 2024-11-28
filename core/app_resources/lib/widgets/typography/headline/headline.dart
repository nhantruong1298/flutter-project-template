import 'package:app_resources/resources/all.dart';
import 'package:flutter/material.dart';
import '../app_text/app_text.dart';


class Headline extends AppText {
  static TextStyle get defaultStyle => TextStyle(
        fontSize: AppDimensions.headlineFontSize,
        color: AppScheme.colors.surface,
        fontWeight: FontWeight.w500,
        letterSpacing: -0.01,
        height: 1.6,
      );

  Headline(
    super.data, {
    super.key,
    super.style,
    super.color,
    super.textAlign = TextAlign.left,
    super.overflow,
    super.maxLines,
  }) : super(fallbackStyle: defaultStyle);
}


class SubHeadline extends AppText {
  static TextStyle get defaultStyle => TextStyle(
        fontSize: AppDimensions.subHeadlineFontSize,
        color: AppScheme.colors.surface,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.01,
        height: 1.6,
      );

  SubHeadline(
    super.data, {
    super.key,
    super.style,
    super.color,
    super.textAlign = TextAlign.left,
    super.overflow,
    super.maxLines,
  }) : super(fallbackStyle: defaultStyle);
}