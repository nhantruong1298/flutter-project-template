import 'package:app_resources/app_resources.dart';
import 'package:flutter/material.dart';

import '../app_dialog_manager.dart';
import 'app_dialog_widget.dart';

class ConfirmDialogBuilder extends AppDialogBuilder {
  final VoidCallback? onCancel;
  final VoidCallback? onConfirm;
  final String? title;
  final String? message;
  final Widget? contentBuilder;
  final String? negativeText;
  final String? positiveText;
  final double? buttonWidth;
  final double width;
  final double height;
  final List<DialogButton>? additionalButton;
  Widget? image;
  final DialogButtonDirection dialogButtonDirection;

  @override
  final bool barrierDismissible;

  ConfirmDialogBuilder({
    this.onCancel,
    this.onConfirm,
    this.title,
    this.message,
    this.contentBuilder,
    this.negativeText,
    this.positiveText,
    this.buttonWidth = double.infinity,
    this.width = 300,
    this.height = 200,
    this.image,
    this.barrierDismissible = false,
    this.additionalButton,
    this.dialogButtonDirection = DialogButtonDirection.HORIZONTAL,
  });

  @override
  Widget buildDialog(Key key, BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: height, minWidth: width),
      child: AppDialogWidget(
        animated: true,
        title: title, fullButtonWidth: true,
        icon: image,
        iconStyle: DialogIconStyle.INNER,
        message: message,
        customWidget: contentBuilder,
        buttonDirection: dialogButtonDirection,
        // negativeButton: DialogButton(
        //     buttonText: negativeText ?? S.current.commonCancelButton,
        //     minWidth: buttonWidth ?? AppDimensions.buttonMinimalWidth,
        //     onButtonClick: () {
        //       onCancel?.call();
        //     }),
        positiveButton: DialogButton(
            buttonText:
                positiveText ?? AppLocalizations.of(context)!.commonOkButton,
            minWidth: buttonWidth ?? AppDimensions.padding,
            onButtonClick: () {
              onConfirm?.call();
            }),

        onCloseButtonPress: () {
          onCancel?.call();
        },
        additionalButton: additionalButton,
        // isShowCloseButton: true,
      ),
    );
  }
}
