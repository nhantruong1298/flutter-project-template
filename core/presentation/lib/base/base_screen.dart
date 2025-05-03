import 'dart:async';

import 'package:data/contracts/exceptions/app_exception.dart';
import 'package:flutter/material.dart';
import 'package:presentation/widgets/dialogs/all.dart';

abstract class _IBaseScreen {
  void toggleLoading(bool value, {bool showSpinner = false});
  void showErrorDialog(Object error, StackTrace stackTrace);
  void showErrorDialogByAppException(AppException exception);
  void showSnackBar(String message,
      {Duration? duration,
      Color? color,
      Color? textColor,
      EdgeInsetsGeometry? margin,
      EdgeInsetsGeometry? padding});

  void showUnderDevelopmentDialog();

  toggleAppDialog();

  Future<void> showAlertDialog({
    required String title,
    Widget? content,
    String? message,
    String? oKText,
  });

  Future<bool> showConfirmDialog(
      {required String title,
      Widget? content,
      String? message,
      String? oKText,
      String? cancelText});

  void hideKeyBoard(BuildContext context);

  Future<U?> showModalBottomSheet<U>(
      Widget Function(BuildContext context) builder);

  void copyTextToClipboard(String text);
}

abstract class BaseScreenState<T extends StatefulWidget> extends State<T>
    with AutomaticKeepAliveClientMixin<T>
    implements _IBaseScreen {
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _canPop,
      onPopInvokedWithResult: (didPop, result) {},
      child: builder(context),
    );
  }

  AppDialogManager get _appDialogManager => AppDialogManager.instance;

  bool get _canPop => ModalRoute.of(context)?.canPop ?? false;

  Widget builder(BuildContext context);

  @override
  bool get wantKeepAlive => false;

  @override
  void toggleLoading(bool value, {bool showSpinner = false}) {}

  @override
  void hideKeyBoard(BuildContext context) {
    if (FocusScope.of(context).hasFocus) {
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Future<void> showAlertDialog({
    required String title,
    Widget? content,
    String? message,
    String? oKText,
  }) async {
    return _appDialogManager.showAlertDialog(
      title: title,
      content: content,
      oKText: oKText,
    );
  }

  @override
  void copyTextToClipboard(String text) {
    // TODO: implement copyTextToClipboard
  }

  @override
  Future<bool> showConfirmDialog({required String title, Widget? content, String? message, String? oKText, String? cancelText}) {
    // TODO: implement showConfirmDialog
    throw UnimplementedError();
  }

  @override
  void showErrorDialog(Object error, StackTrace stackTrace) {
    // TODO: implement showErrorDialog
  }

  @override
  void showErrorDialogByAppException(AppException exception) {
    // TODO: implement showErrorDialogByAppException
  }

  @override
  Future<U?> showModalBottomSheet<U>(Widget Function(BuildContext context) builder) {
    // TODO: implement showModalBottomSheet
    throw UnimplementedError();
  }

  @override
  void showSnackBar(String message, {Duration? duration, Color? color, Color? textColor, EdgeInsetsGeometry? margin, EdgeInsetsGeometry? padding}) {
    // TODO: implement showSnackBar
  }

  @override
  void showUnderDevelopmentDialog() {
    // TODO: implement showUnderDevelopmentDialog
  }

  @override
  toggleAppDialog() {
    // TODO: implement toggleAppDialog
    throw UnimplementedError();
  }
}
