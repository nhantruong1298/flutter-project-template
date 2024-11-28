import 'dart:async';

import 'package:data/contracts/exceptions/app_exception.dart';
import 'package:flutter/material.dart';
import 'package:presentation/injectors/injectable.dart';
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

  Future<void> showDialog({
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

  AppDialogManager get _appDialogManager => getIt<AppDialogManager>();

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

  //TODO: Custom toggle dialogs here
}
