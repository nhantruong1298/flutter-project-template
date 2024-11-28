// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../events/app_event_bus.dart' as _i3;
import '../services/data_store/data_store_service.dart' as _i4;
import '../services/logger/log_service.dart' as _i5;

// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt init(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.singleton<_i3.AppEventBus>(
    () => _i3.AppEventBus(),
    dispose: (i) => i.dispose(),
  );
  gh.singleton<_i4.DataStoreService>(
    () => _i4.DataStoreService(),
    dispose: (i) => i.dispose(),
  );
  gh.singleton<_i5.LogService>(() => _i5.LogService());
  return getIt;
}
