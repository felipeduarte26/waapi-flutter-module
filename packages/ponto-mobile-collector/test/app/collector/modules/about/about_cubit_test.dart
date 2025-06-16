import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/device_info_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/services/platform/platform_service.dart';
import 'package:ponto_mobile_collector/app/collector/modules/about/domain/presenter/cubit/about_cubit.dart';

import '../../../../modules/clocking_event/infra/service/register_clocking_event_service_test.dart';

class MockPlatformService extends Mock implements PlatformService {}

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late AboutCubit aboutCubit;
  late PlatformService mockPlatformService;

  PackageInfoMock packageInfoMock = PackageInfoMock();

  DeviceInfo deviceInfo = DeviceInfo(
    identifier: '9ed66fde-fe99-4063-b4fb-0f8f40461336',
    model: 'Emulador',
    name: 'emux86',
  );
  setUp(() {
    mockPlatformService = MockPlatformService();
    aboutCubit = AboutCubit(platformService: mockPlatformService);
  });

  tearDown(() {
    aboutCubit.close();
  });

  test('initialize should update state and check permissions', () async {
    when(
      () => mockPlatformService.getPackageinfo(),
    ).thenAnswer((invocation) => Future.value(packageInfoMock));

    when(
      () => mockPlatformService.getDeviceInfoDto(),
    ).thenAnswer(
      (invocation) => Future.value(deviceInfo),
    );

    await aboutCubit.loadData();

    expect(aboutCubit.version, packageInfoMock.version);
    expect(aboutCubit.identifier, deviceInfo.identifier);
    expect(aboutCubit.model, deviceInfo.model);
    expect(aboutCubit.name, deviceInfo.name);
  });
}
