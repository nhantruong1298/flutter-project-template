import 'package:app_resources/app_resources.dart';
import 'package:flutter/material.dart';
import 'package:presentation/widgets/buttons/button_type.dart';

import '../app_dialog_manager.dart';
import 'app_dialog_widget.dart';

class AlertDialogBuilder extends AppDialogBuilder {
  final VoidCallback? onCancel;
  final VoidCallback? onClose;
  final VoidCallback? onOk;
  final String? title;
  final String? message;
  final String? negativeText;
  final String? positiveText;
  final Widget? contentBuilder;
  final AppButtonType? buttonType;
  final bool fullButtonWidth;
  final VoidCallback? onTapOutside;
  final GlobalKey<AppDialogWidgetState> _dialogKey =
      GlobalKey<AppDialogWidgetState>();

  AlertDialogBuilder({
    this.onCancel,
    this.onClose,
    this.title,
    this.message,
    this.negativeText,
    this.positiveText,
    this.contentBuilder,
    this.buttonType,
    this.fullButtonWidth = false,
    this.onOk,
    this.onTapOutside,
  });

  @override
  Widget buildDialog(Key key, BuildContext context) {
    return AppDialogWidget(
      key: _dialogKey,
      animated: true,
      title: title,
      message: message,
      customWidget: contentBuilder,
      buttonDirection: DialogButtonDirection.HORIZONTAL,
      fullButtonWidth: fullButtonWidth,
      positiveButton: DialogButton(
          buttonText:
              positiveText ?? AppLocalizations.of(context)!.commonOkButton,
          // minWidth: AppDimensions.buttonMinimalWidth,
          onButtonClick: () {
            onOk?.call();
          },
          buttonType: buttonType),
      negativeButton: negativeText?.isNotEmpty == true
          ? DialogButton(
              buttonText: negativeText,
              // minWidth: AppDimensions.buttonMinimalWidth,
              onButtonClick: () {
                onClose?.call();
              },
              buttonType: buttonType)
          : null,
      onCloseButtonPress: () {
        onClose?.call();
      },
      onTapOutside: onTapOutside,
    );
  }
}
