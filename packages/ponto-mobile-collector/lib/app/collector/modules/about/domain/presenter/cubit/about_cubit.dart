import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/infra/services/platform/platform_service.dart';
import 'about_state.dart';

class AboutCubit extends Cubit<AboutBaseState> {
  final PlatformService _platformService;

  late String version;
  late String identifier;
  late String model;
  late String name;

  AboutCubit({required PlatformService platformService})
      : _platformService = platformService,
        super(LoadingContentState());

  Future<void> loadData() async {
    emit(LoadingContentState());
    var packageinfo = await _platformService.getPackageinfo();
    var deviceInfo = await _platformService.getDeviceInfoDto();

    version = packageinfo.version;
    identifier = deviceInfo.identifier;
    model = deviceInfo.model;
    name = deviceInfo.name;

    emit(ReadContentState());
  }
}
