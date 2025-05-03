import 'dart:async';

import 'package:app_resources/app_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:presentation/widgets/dialogs/components/app_dialog_widget.dart';

import 'components/alert_dialog.dart';
import 'components/confirm_dialog.dart';
import 'components/error_dialog.dart';

abstract class AppDialogBuilder {
  Widget buildDialog(Key key, BuildContext context);
}

abstract class AppDialogManager {
  static final AppDialogManager instance = AppDialogManagerImpl();

  setNavigatorKey(GlobalKey<NavigatorState> navKey);

  Future<void> showAlertDialog({
    required String title,
    Widget? content,
    String? oKText,
  });
  Future<bool> showConfirmDialog({
    String? title,
    Widget? content,
    String? oKText,
    String? cancelText,
  });
  Future<dynamic> showDialog({required AppDialogBuilder appDialogBuilder});
}

class AppDialogManagerImpl implements AppDialogManager {
  AppDialogBuilder? _currentDialogBuilder;

  final _dialogKey = GlobalKey<AppDialogWidgetState>();

  GlobalKey<NavigatorState>? _navKey;

  BuildContext? get _dialogOverlayContext => _navKey?.currentState?.context;

  OverlayEntry? _dialogOverlay;

  @override
  setNavigatorKey(GlobalKey<NavigatorState> navKey) {
    _navKey = navKey;
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

    forceHideDialog();
  }

  @override
  Future<void> showAlertDialog(
      {required String title, Widget? content, String? oKText}) async {
    final completer = Completer<void>();
    toggleDialog(true,
        appDialogBuilder: AlertDialogBuilder(
            title: title,
            contentBuilder: content,
            positiveText: oKText,
            onOk: () {
              forceHideDialog();
              completer.complete();
            },
            onTapOutside: () {
              forceHideDialog();
            }));

    return completer.future;
  }

  @override
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
      ),
    );

    return completer.future;
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

  Future<dynamic> toggleDialog(bool isShow,
      {AppDialogBuilder? appDialogBuilder}) {
    if (isShow) {
      assert(appDialogBuilder != null);
      return showDialog(appDialogBuilder: appDialogBuilder!);
    }

    hideDialog(dialogBuilder: appDialogBuilder ?? _currentDialogBuilder);
    return Future.value();
  }

  @override
  Future<dynamic> showDialog(
      {required AppDialogBuilder appDialogBuilder}) async {
    _currentDialogBuilder = appDialogBuilder;
    return _createAndInsertDialogOverlay(_dialogOverlayContext!);
  }

  Future<dynamic> _createAndInsertDialogOverlay(BuildContext context) async {
    if (_currentDialogBuilder == null) {
      return;
    }
    FocusScope.of(context).requestFocus(FocusNode());
    _removeDialogOverlay();
    _dialogOverlay = _createOverlayEntry();
    _insertDialogOverlay(_dialogOverlay);
  }

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
        child: _buildDialogContent(context),
      ),
    );
  }

  void _insertDialogOverlay(OverlayEntry? overlay) {
    if (overlay != null) {
      _navKey?.currentState?.overlay?.insert(_dialogOverlay!);
    }
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

  void dispose() {
    _currentDialogBuilder = null;
  }
}
