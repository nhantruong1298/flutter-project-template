import 'dart:async';

import 'package:app_resources/app_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:presentation/widgets/buttons/button_type.dart';
// import 'package:presentation/widgets/dialogs/app_dialog_manager.dart';

enum DialogIconStyle {
  OUTER,
  INNER,
}

enum DialogButtonDirection {
  VERTICAL,
  HORIZONTAL,
}

class AppDialogWidgetState extends State<AppDialogWidget>
    with TickerProviderStateMixin {
  final double outerIconWidth = 135.0;
  final double outerIconHeight = 110.0;
  final double outerIconTopSpace = 70.0;
  final Duration animationDuration = AppConstants.animationDuration;

  late Animation<double> animatedScale;
  late Animation<double> animatedOpacity;
  late AnimationController animationController;
  @override
  void initState() {
    super.initState();
    initAnimation();
  }

  void initAnimation() {
    if (!widget.animated) return;
    animationController =
        AnimationController(duration: animationDuration, vsync: this);
    animatedScale = Tween<double>(
      begin: 1.08,
      end: 1.0,
    ).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );
    animatedOpacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeOut),
    );
    animationController.forward();
  }

  @override
  void dispose() {
    disposeAnimation();
    super.dispose();
  }

  void disposeAnimation() {
    if (!widget.animated) return;
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animated) {
      return FadeTransition(
        opacity: animatedOpacity,
        child: Material(
          color: AppScheme.colors.onPrimary.withOpacity(0.5),
          child: ScaleTransition(
            scale: animatedScale,
            child: buildMainContent(context),
          ),
        ),
      );
    }
    return Material(
      color: AppScheme.colors.onPrimary.withOpacity(0.2),
      child: buildMainContent(context),
    );
  }

  Widget buildMainContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.padding),
      color: AppScheme.colors.primary.withOpacity(0.5),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Material(
              type: MaterialType.transparency,
              child: Stack(
                children: <Widget>[
                  buildContent(),
                  buildOuterIcon(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> startHideDialogAnimation() {
    if (!widget.animated) return Future.value();
    animationController.reverse();
    return Future.delayed(animationDuration);
  }

  Widget buildOuterIcon() {
    if (widget.iconStyle != DialogIconStyle.OUTER || widget.icon == null) {
      return Container();
    }

    return Center(
      child: SizedBox(
        height: outerIconHeight,
        width: outerIconWidth,
        child: widget.icon,
      ),
    );
  }

  Widget buildContent() {
    return Stack(
      children: [
        Container(
          // margin: getDialogOuterMargin(),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildInnerImage(),
              Container(
                // padding: getDialogInnerPadding(),
                child: Column(
                  children: <Widget>[
                    _buildTittle(),
                    _buildMessage(),
                    _buildCustomWidget(),
                    _buildBottomButtons(),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              // padding: getDialogInnerPadding(),
              child: _buildBottomButtons(),
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () {
                forceHideDialog();
                widget.onCloseButtonPress?.call();
              },
              child: Container(
                width: 24.sp,
                height: 24.sp,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                margin: EdgeInsets.only(top: 8.sp, right: 8.sp),
                child: Icon(
                  Icons.close,
                  size: 14.sp,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInnerImage() {
    if (widget.iconStyle != DialogIconStyle.INNER || widget.icon == null) {
      return Container();
    }

    return Row(
      children: [
        Expanded(
          child: Container(child: widget.icon),
        ),
      ],
    );
  }

  Widget _buildTittle() {
    if (widget.title == null) {
      return Container();
    }

    return SizedBox(
      width: double.infinity,
      child: Text(widget.title!,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.start),
    );
  }

  Widget _buildMessage() {
    if (widget.message == null) {
      return Container();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.padding / 2),
      child: Text(
        widget.message ?? '',
        textAlign: TextAlign.start,
      ),
    );
  }

  Widget _buildCustomWidget() {
    if (widget.customWidget == null) {
      return Container();
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.padding / 2,
        vertical: AppDimensions.padding / 2,
      ),
      child: widget.customWidget,
    );
  }

  _buildBottomButtons() {
    List<Widget> buttons = [];
    widget.additionalButton?.forEach(
      (element) {
        buttons.add(Flexible(
          child: buildBottomButton(
            element,
            type: element.buttonType ?? AppButtonType.primary,
            block: widget.fullButtonWidth,
          ),
        ));
      },
    );
    if (widget.positiveButton != null) {
      buttons.add(Flexible(
        child: buildBottomButton(
          widget.positiveButton!,
          type: widget.positiveButton!.buttonType ?? AppButtonType.primary,
          block: widget.fullButtonWidth,
        ),
      ));
    }
    if (widget.negativeButton != null) {
      buttons.add(const SizedBox(
        height: AppDimensions.padding,
        width: AppDimensions.padding,
      ));
      buttons.add(Flexible(
        child: buildBottomButton(
          widget.negativeButton!,
          block: widget.fullButtonWidth,
        ),
      ));
    }

    if (buttons.isEmpty) {
      return Container();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(
        top: AppDimensions.padding,
      ),
      child: Container(
        constraints: BoxConstraints(maxWidth: 100.sw, maxHeight: 30.sh),
        child: widget.buttonDirection == DialogButtonDirection.HORIZONTAL
            ? Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: buttons.reversed.toList())
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: buttons,
              ),
      ),
    );
  }

  Widget buildCloseButton() {
    if (!widget.isShowCloseButton) {
      return Container();
    }

    return Container(
      margin: const EdgeInsets.only(
        top: AppDimensions.padding,
      ),
      child: TextButton(
        child: SizedBox(
          width: AppDimensions.iconSize,
          height: AppDimensions.iconSize,
          child: Text(AppLocalizations.of(context)!.commonCancelButton),
        ),
        onPressed: () {
          forceHideDialog();
          widget.onCloseButtonPress?.call();
        },
      ),
    );
  }

  Widget buildBottomButton(DialogButton dialogButton,
      {Color? backgroundColor,
      AppButtonType type = AppButtonType.primary,
      block = false}) {
    Widget button = InkWell(
      // text: dialogButton.buttonText,
      // textStyle: dialogButton.buttonTextStyle,
      // width: dialogButton.minWidth,
      // block: block,
      onTap: dialogButton.disabled
          ? null
          : () {
              forceHideDialog();
              dialogButton.onButtonClick?.call();
            },

      // text: dialogButton.buttonText,
      // textStyle: dialogButton.buttonTextStyle,
      // width: dialogButton.minWidth,
      // block: block,
      child: Text(dialogButton.buttonText ?? ''),
    );

    if (widget.buttonDirection == DialogButtonDirection.VERTICAL) {
      return button;
    }
    return dialogButton.minWidth != null
        ? button
        : Expanded(
            flex: 1,
            child: button,
          );
  }

  void forceHideDialog() {
    // getIt<AppDialogManager>().forceHideDialog();
    // Navigator.of(context, rootNavigator: true).pop();
  }
}

class AppDialogWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppDialogWidgetState();

  const AppDialogWidget({
    super.key,
    this.iconStyle = DialogIconStyle.OUTER,
    this.icon,
    this.title,
    this.message,
    this.customWidget,
    this.buttonDirection = DialogButtonDirection.HORIZONTAL,
    this.negativeButton,
    this.positiveButton,
    this.isShowCloseButton = false,
    this.onCloseButtonPress,
    this.animated = false,
    this.dialogPadding,
    this.fullButtonWidth = false,
    this.additionalButton,
  });
  final EdgeInsets? dialogPadding;
  final DialogIconStyle iconStyle;
  final Widget? icon;
  final String? title;
  final String? message;
  final Widget? customWidget;
  final DialogButtonDirection buttonDirection;
  final DialogButton? negativeButton;
  final DialogButton? positiveButton;
  final bool isShowCloseButton;
  final VoidCallback? onCloseButtonPress;
  final bool animated;
  final bool fullButtonWidth;
  final List<DialogButton>? additionalButton;
}

class DialogButton {
  final String? buttonText;
  final VoidCallback? onButtonClick;
  final Color? buttonColor;
  final TextStyle? buttonTextStyle;
  final double? minWidth;
  final bool disabled;
  final AppButtonType? buttonType;
  DialogButton({
    this.buttonColor,
    this.buttonText,
    this.onButtonClick,
    this.buttonTextStyle,
    this.minWidth,
    this.buttonType,
    this.disabled = false,
  });
}

class SpecialText extends StatelessWidget {
  // ignore: unnecessary_string_escapes
  final RegExp exp = RegExp('<\s*(.*?)>(.*?)<\s*/\s*(.*?)>');

  final String? text;
  final TextStyle? style;
  final TextAlign textAlign;
  final String? keyString;

  SpecialText(
      {super.key,
      this.text,
      this.style,
      this.textAlign = TextAlign.start,
      this.keyString});

  @override
  Widget build(BuildContext context) {
    List<TextSpan> textSpans = splitText(text ?? '');
    return RichText(
      key: keyString != null ? Key(keyString!) : null,
      textAlign: textAlign,
      text: TextSpan(
        style: style ?? Callout.defaultStyle,
        children: textSpans,
      ),
    );
  }

  List<TextSpan> splitText(String text) {
    List<TextSpan> results = [];
    Iterable<Match> matches = exp.allMatches(text);
    int start = 0;
    for (var match in matches) {
      String? tag = 'n';
      if (match.start != start) {
        String normalText = text.substring(start, match.start);
        results.add(buildText(normalText, tag));
      }
      String? htmlText = match.group(2);
      tag = match.group(1);
      results.add(buildText(htmlText, tag));
      start = match.end;
    }

    if (start < text.length) {
      String normalText = text.substring(start, text.length);
      results.add(buildText(normalText, 'n'));
    }
    return results;
  }

  TextSpan buildText(String? text, String? tag) {
    return TextSpan(
      text: text,
      style: buildStyleByTag(tag),
    );
  }

  TextStyle buildStyleByTag(String? tag) {
    switch (tag) {
      case 'n':
        return const TextStyle(fontWeight: FontWeight.normal);

      case 'b':
        return const TextStyle(fontWeight: FontWeight.bold);

      case 'i':
        return const TextStyle(fontStyle: FontStyle.italic);

      default:
        return const TextStyle(fontWeight: FontWeight.normal);
    }
  }
}
