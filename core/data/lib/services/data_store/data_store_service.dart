import 'dart:async';
import 'package:injectable/injectable.dart';

@Singleton()
class DataStoreService {
  DataStoreService() {
    init();
  }

  @disposeMethod
  void dispose() async {}

  FutureOr<void> init() async {}

  Future<void> save(String key, String? value) async {
    if (value?.isNotEmpty == true) {}
  }

  Future<String?> load(String key) async {
    return null;
  }

  Future<void> delete(String key) async {}

  Future<void> clearAll() async {}

  Future<void> clearSpecific(Iterable<String> keys) async {}
}
