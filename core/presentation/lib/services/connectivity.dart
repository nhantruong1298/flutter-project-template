import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';

abstract class NetworkConnectivity {
  static final NetworkConnectivity instance = _NetworkConnectivityImpl();

  bool get hasConnection;
  void start();
  void dispose();
}

class _NetworkConnectivityImpl implements NetworkConnectivity {
  bool _started = false;

  bool _hasConnection = true;
  @override
  bool get hasConnection => _hasConnection;

  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void start() async {
    if (_started) return;
    _started = true;

    final connectivity = Connectivity();

    _connectivitySubscription = connectivity.onConnectivityChanged
        .listen(_updateConnectionStatus, onError: (Object error) {
      _hasConnection = false;
    }, cancelOnError: false);
  }

  void _updateConnectionStatus(
      List<ConnectivityResult> connectionStatus) async {
    if (!_started) return;
    if (connectionStatus.isEmpty) return;

    final status = connectionStatus.first;
    if (status == ConnectivityResult.none) {
      _hasConnection = false;
    } else {
      _hasConnection = status == ConnectivityResult.mobile ||
          status == ConnectivityResult.wifi;

      var log = 'No Network Connection';
      if (_hasConnection) {
        log = 'Device connected via ${status.toString().split('.').last}';
      }

      debugPrint(log);
    }
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    _started = false;
  }
}
