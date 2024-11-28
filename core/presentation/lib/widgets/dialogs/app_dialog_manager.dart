import 'dart:async';

import 'package:app_resources/app_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:injectable/injectable.dart';
import 'package:presentation/widgets/buttons/button_type.dart';
import 'package:presentation/widgets/dialogs/components/app_dialog_widget.dart';

import 'components/alert_dialog.dart';
import 'components/confirm_dialog.dart';
import 'components/error_dialog.dart';

abstract class AppDialogBuilder {
  /// @code to identify the dialog, help the dialog manager
  /// to recognize the correct dialog for showing and hiding correctly
  /// in case the screen contain multiple same dialog types
  int code = 0;
  bool barrierDismissible = false;

  Widget buildDialog(
    Key key,
    BuildContext context,
  );

  AppDialogBuilder withCode(int code) {
    this.code = code;
    return this;
  }
}

@Singleton()
class AppDialogManager {
  AppDialogBuilder? _currentDialogBuilder;

  final GlobalKey<AppDialogWidgetState> _dialogKey =
      GlobalKey<AppDialogWidgetState>();

  GlobalKey<NavigatorState>? _navKey;

  AppDialogManager();

  bool get isShowingDialog {
    return _currentDialogBuilder != null;
  }

  BuildContext? get dialogOverlayContext => _navKey?.currentState?.context;

  void dispose() {
    _currentDialogBuilder = null;
  }

  void forceHideDialog() {
    _currentDialogBuilder = null;
    _removeDialogOverlay();
  }

  void hideDialog({AppDialogBuilder? dialogBuilder}) {
    if (dialogBuilder == null || _currentDialogBuilder == null) {
      return;
    }
    if (dialogBuilder.runtimeType != _currentDialogBuilder.runtimeType) {
      return;
    }

    if (dialogBuilder.code != _currentDialogBuilder!.code) {
      return;
    }
    forceHideDialog();
  }

  void registerNavigatorKey(GlobalKey<NavigatorState> navKey) {
    _navKey = navKey;
  }

  Future<bool> showAlertDialog({
    required String title,
    Widget? content,
    Widget? image,
    String? oKText,
    String? message,
    AppButtonType? buttonType,
    String? cancelText,
  }) async {
    Completer<bool> completer = Completer<bool>();

    toggleDialog(
      true,
      appDialogBuilder: AlertDialogBuilder(
          title: title,
          contentBuilder: content,
          message: message,
          onCancel: () {
            forceHideDialog();
            completer.complete(false);
          },
          onClose: () {
            forceHideDialog();
            completer.complete(false);
          },
          positiveText: oKText,
          buttonType: buttonType,
          negativeText: cancelText,
          onOk: () {
            forceHideDialog();
            completer.complete(true);
          }),
    );

    return completer.future;
  }

  Future<bool> showConfirmDialog({
    String? title,
    Widget? content,
    Widget? image,
    String? oKText,
    String? message,
    String? cancelText,
    List<Widget>? additionalButton,
  }) async {
    Completer<bool> completer = Completer<bool>();

    toggleDialog(
      true,
      appDialogBuilder: ConfirmDialogBuilder(
        title: title,
        contentBuilder: content,
        message: message,
        // dialogButtonDirection:
        //     dialogButtonDirection ?? DialogButtonDirection.HORIZONTAL,
        image: image,
        onCancel: () {
          forceHideDialog();
          completer.complete(false);
        },
        onConfirm: () {
          forceHideDialog();
          completer.complete(true);
        },
        positiveText: oKText,
        negativeText: cancelText,
        // additionalButton: additionalButton?.map(
        //   (e) {
        //     return DialogButton(
        //       buttonText: e.buttonText,
        //       buttonType: e.buttonType,
        //       minWidth: AppDimensions.buttonMinimalWidth,
        //       onButtonClick: () {
        //         e.onButtonClick?.call();
        //         forceHideDialog();
        //         completer.complete(true);
        //       },
        //     );
        //   },
        // ).toList(),
      ),
    );

    return completer.future;
  }

  Future<dynamic> showDialog(
      {required AppDialogBuilder appDialogBuilder}) async {
    _currentDialogBuilder = appDialogBuilder;
    return _createAndInsertDialogOverlay(dialogOverlayContext!);
  }

  Future<dynamic> showErrorDialog(BuildContext context, Exception exception) {
    return showDialog(
        appDialogBuilder: ErrorDialogBuilder(
            exception: exception,
            title: LargeTitle(
              AppLocalizations.of(context)!.commonErrorTitleText,
            ),
            onCloseButtonPress: () {
              // TODO: handle error crash report if wanted
            }));
  }

  toggleDialog(bool isShow, {AppDialogBuilder? appDialogBuilder}) {
    if (isShow) {
      assert(appDialogBuilder != null);
      return showDialog(appDialogBuilder: appDialogBuilder!);
    }
    return hideDialog(dialogBuilder: appDialogBuilder ?? _currentDialogBuilder);
  }

  Widget _buildDialogContent(BuildContext context) {
    if (_currentDialogBuilder != null) {
      return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: _currentDialogBuilder!.buildDialog(_dialogKey, context),
      );
    }

    return Container();
  }

  OverlayEntry? _dialogOverlay;

  void _removeDialogOverlay() {
    if (_dialogOverlay != null) {
      _dialogOverlay!.remove();
      _dialogOverlay = null;
    }
  }

  OverlayEntry _createOverlayEntry() {
    double screenWidth = 1.sw;
    double screenHeight = 1.sh;

    return OverlayEntry(
      builder: (context) => Positioned(
        left: 0,
        top: 0,
        width: screenWidth,
        height: screenHeight,
        child: Material(
          color: Colors.transparent,
          child: _buildDialogContent(context),
        ),
      ),
    );
  }

  Future<dynamic> _createAndInsertDialogOverlay(BuildContext context) async {
    if (_currentDialogBuilder == null) {
      return;
    }
    FocusScope.of(context).requestFocus(FocusNode());
    _removeDialogOverlay();
    _dialogOverlay = _createOverlayEntry();
    Overlay.of(context).insert(_dialogOverlay!);
  }
}
