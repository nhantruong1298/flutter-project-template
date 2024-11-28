import 'package:app_resources/app_resources.dart';
import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  static final TextStyle _defaultStyle = TextStyle(
      height: AppDimensions.bodyHeight,
      color: AppScheme.colors.onSurface,
      fontFamily: FontFamily.openSans,
      fontSize: AppDimensions.bodyFontSize,
      fontWeight: FontWeight.w400);

  TextStyle getTextStyle(Color? color, TextStyle? style) {
    TextStyle mergedStyle;
    TextStyle clonedStyle = (fallbackStyle ?? _defaultStyle).copyWith();
    mergedStyle = style != null ? clonedStyle.merge(style) : clonedStyle;
    if (color != null) {
      mergedStyle = mergedStyle.copyWith(color: color);
    }
    return mergedStyle;
  }

  final Color? color;
  final TextStyle? style;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final String? data;

  final TextStyle? fallbackStyle;

  const AppText(
    this.data, {
    super.key,
    this.style,
    this.color,
    this.textAlign = TextAlign.left,
    this.overflow,
    this.maxLines,
    this.fallbackStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      data ?? '',
      key: key,
      style: getTextStyle(color, style),
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
    );
  }
}
