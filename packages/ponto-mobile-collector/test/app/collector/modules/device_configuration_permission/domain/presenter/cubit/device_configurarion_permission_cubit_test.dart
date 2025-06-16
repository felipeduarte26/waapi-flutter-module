import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/permission/ipermission_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_execution_mode_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/device_permission_enum.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/execution_mode_enum.dart';
import 'package:ponto_mobile_collector/app/collector/modules/device_configuration_permission/domain/presenter/cubit/device_configuration_permission_cubit.dart';

class MockPermissionService extends Mock implements IPermissionService {}

class MockNfcManager extends Mock implements NfcManager {}

class MockGetExecutionModeUsecase extends Mock
    implements GetExecutionModeUsecase {}

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late DeviceConfigurationPermissionCubit cubit;
  late MockPermissionService mockPermissionService;
  late NfcManager nfcManager;
  late GetExecutionModeUsecase getExecutionModeUsecase;

  setUp(() {
    mockPermissionService = MockPermissionService();
    nfcManager = MockNfcManager();
    getExecutionModeUsecase = MockGetExecutionModeUsecase();

    cubit = DeviceConfigurationPermissionCubit(
      permissionService: mockPermissionService,
      nfcManager: nfcManager,
      getExecutionModeUsecase: getExecutionModeUsecase,
    );
  });

  tearDown(() {
    cubit.close();
  });


  test('initialize should update state and check permissions', () async {
    when(
      () => nfcManager.isAvailable(),
    ).thenAnswer((_) async => true);

    when(
      () => (getExecutionModeUsecase.call()),
    ).thenAnswer((_) async => ExecutionModeEnum.multiple);
    when(
      () => mockPermissionService.checkPermissionIsAuthorized(
        permission: DevicePermissionEnum.camera,
      ),
    ).thenAnswer((_) async => true);

    when(
      () => mockPermissionService.checkPermissionIsAuthorized(
        permission: DevicePermissionEnum.location,
      ),
    ).thenAnswer((_) async => true);
    when(
      () => mockPermissionService.checkPermissionIsAuthorized(
        permission: DevicePermissionEnum.photos,
      ),
    ).thenAnswer((_) async => true);

      when(
      () => mockPermissionService.checkPermissionIsAuthorized(
        permission: DevicePermissionEnum.manageExternalStorage,
      ),
    ).thenAnswer((_) async => true);

    await cubit.initialize();

   //expect(cubit.state, isA<ReadContentState>());
    expect(cubit.hasCameraPermission, true);
    expect(cubit.hasGPSPermission, true);
    expect(cubit.hasNFCPermission, true);
    expect(cubit.hasStoragePermission, true);
  });

  test('openSystemAppSettings should call permission service', () async {
    when(
      () => mockPermissionService.openSystemAppSettings(),
    ).thenAnswer((_) async => true);

    await cubit.openSystemAppSettings();

    verify(
      () => mockPermissionService.openSystemAppSettings(),
    ).called(1);
  });
}
