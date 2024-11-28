// import 'package:app_resources/app_resources.dart';
import 'package:flutter/material.dart';
// import 'package:presentation/widgets/buttons/button_type.dart';

import '../app_dialog_manager.dart';
import 'app_dialog_widget.dart';

class ErrorDialogBuilder extends AppDialogBuilder {
  final VoidCallback? onCloseButtonPress;
  final Exception exception;
  final Widget? title;
  final double width;
  final double height;
  final double? buttonWidth;

  ErrorDialogBuilder(
      {this.onCloseButtonPress,
      required this.exception,
      this.title,
      this.buttonWidth,
      this.width = 300,
      this.height = 200});

  @override
  Widget buildDialog(Key key, BuildContext context) {
    return Container(
        constraints: BoxConstraints(minHeight: height, minWidth: width),
        child: ErrorDialog(
          exception: exception,
          onCloseButtonPress: () {
            onCloseButtonPress?.call();
          },
        ));
  }
}

class ErrorDialog extends AppDialogWidget {
  final Exception exception;

  ErrorDialog(
      {super.key,
      required this.exception,
      super.onCloseButtonPress,
      double? buttonWidth})
      : super(
          animated: true,
          iconStyle: DialogIconStyle.INNER,
          // icon: exception.errorCode ==
          //         BusinessExceptionCode.UNEXPECTED_ERROR.value
          //     ? Container(
          //         padding: const EdgeInsets.all(8),
          //         child: Assets.images.errorIcon
          //             .svg(height: 115, fit: BoxFit.fitHeight),
          //       )
          //     : null,
          // title: exception.errorCode ==
          //         BusinessExceptionCode.UNEXPECTED_ERROR.value
          //     ? S.current.exceptionUnknownError
          //     : S.current.commonErrorTitleText,
          // message: exception.message,
          isShowCloseButton: false,
          buttonDirection: DialogButtonDirection.HORIZONTAL,
          // positiveButton: DialogButton(
          //     buttonType: AppButtonType.primary,
          //     buttonText:AppLocalizations.of(context).commonOkButton,
          //     minWidth: buttonWidth ?? AppDimensions.buttonMinimalWidth,
          //     onButtonClick: onCloseButtonPress),
        );
}
