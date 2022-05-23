import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:rxdart/subjects.dart';

class ConnectionServices {
  final BehaviorSubject<ConnectivityResult> _connectionResultBS = BehaviorSubject<ConnectivityResult>();
  late final StreamSink<ConnectivityResult?> _connectionResultSink;
  late final Stream<ConnectivityResult?> _connectionResultObs;

  static ConnectionServices? _instance;

  static ConnectionServices getInstance() {
    _instance ??= ConnectionServices._();
    return _instance!;
  }

  ConnectionServices._() {
    _connectionResultObs = _connectionResultBS.stream;
    _connectionResultSink = _connectionResultBS.sink;

    Connectivity().onConnectivityChanged.listen((event) {
      this.emitConnectionResult(event);
    });
  }

  Stream<ConnectivityResult?> get connectionResult {
    return _connectionResultObs;
  }

  emitConnectionResult(ConnectivityResult result) {
    _connectionResultSink.add(result);
  }

  dispose() {
    this._connectionResultBS.close();
    this._connectionResultSink.close();
  }
}
