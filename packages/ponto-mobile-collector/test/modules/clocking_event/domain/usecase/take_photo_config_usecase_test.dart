
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/configuration.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/clocking_event_register_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/database/iglobal_configuration_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_execution_mode_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/execution_mode_enum.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/take_photo_config_usecase.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

import '../../../../mocks/configuration_dto_mock.dart';
import '../../../../mocks/configuration_entity_mock.dart';
import '../../../../mocks/global_configuration_entity_mock.dart';

class MockSessionService extends Mock implements ISessionService {}

class MockGetExecutionModeUsecase extends Mock
    implements GetExecutionModeUsecase {}

class MockGlobalConfigurationRepository extends Mock
    implements IGlobalConfigurationRepository {}

class MockConfigurationRepository extends Mock
    implements IConfigurationRepository {}

class FakeConfiguration extends Fake
    implements Configuration {
  @override
  final bool takePhoto;

  FakeConfiguration({required this.takePhoto});
}

void main() {
  late ITakePhotoConfigUsecase takePhotoConfigUsecase;
  late ISessionService sessionService;
  late IGlobalConfigurationRepository globalConfigurationRepository;
  late GetExecutionModeUsecase getExecutionModeUsecase;
  late IConfigurationRepository configurationRepository;
  const String tEmployeeId = 'employeeId';

  setUp(
    () {
      sessionService = MockSessionService();
      globalConfigurationRepository = MockGlobalConfigurationRepository();
      getExecutionModeUsecase = MockGetExecutionModeUsecase();
      configurationRepository = MockConfigurationRepository();

      takePhotoConfigUsecase = TakePhotoConfigUsecase(
        sessionService: sessionService,
        globalConfigurationRepository: globalConfigurationRepository,
        getExecutionModeUsecase: getExecutionModeUsecase,
        configurationRepository: configurationRepository,
      );
    },
  );

  group(
    'TakePhotoConfigUsecase',
    () {
      test('call in individual mode shold return true test.', () async {
        when(
          () => getExecutionModeUsecase.call(),
        ).thenAnswer(
          (_) async => ExecutionModeEnum.individual,
        );

        when(
          () => sessionService.getConfiguration(),
        ).thenReturn(configurationDTOMock);

        expect(await takePhotoConfigUsecase.call(), true);

        verify(
          () => sessionService.getConfiguration(),
        ).called(1);

        verifyNoMoreInteractions(sessionService);
      });

      test('multiple mode should return true test.', () async {
        when(
          () => getExecutionModeUsecase.call(),
        ).thenAnswer(
          (_) async => ExecutionModeEnum.multiple,
        );

        when(
          () => globalConfigurationRepository.getAll(),
        ).thenAnswer((_) async => [globalConfigurationEntityMock]);

        expect(
          await takePhotoConfigUsecase.call(
            clockingEventRegisterType:
                ClockingEventRegisterTypeNFC(employeeId: tEmployeeId),
          ),
          true,
        );

        expect(
          await takePhotoConfigUsecase.call(
            clockingEventRegisterType:
                ClockingEventRegisterTypeQRCode(employeeId: tEmployeeId),
          ),
          true,
        );

        expect(
          await takePhotoConfigUsecase.call(
            clockingEventRegisterType: ClockingEventRegisterTypeEmailPassword(
              employeeId: tEmployeeId,
            ),
          ),
          true,
        );

        expect(
          await takePhotoConfigUsecase.call(
            clockingEventRegisterType:
                ClockingEventRegisterTypeFacialRecognition(
              employeeId: tEmployeeId,
            ),
          ),
          false,
        );

        verify(() => getExecutionModeUsecase.call()).called(4);
        verify(() => globalConfigurationRepository.getAll()).called(4);

        verifyNoMoreInteractions(getExecutionModeUsecase);
        verifyNoMoreInteractions(globalConfigurationRepository);
      });

      test(
          'multiple mode returns true when there is no global '
          'configuration test', () async {
        when(
          () => getExecutionModeUsecase.call(),
        ).thenAnswer(
          (_) async => ExecutionModeEnum.multiple,
        );

        when(
          () => globalConfigurationRepository.getAll(),
        ).thenAnswer((_) async => []);

        when(
          () => configurationRepository.findByEmployeeId(
            employeeId: tEmployeeId,
          ),
        ).thenAnswer((_) async => configurationEntityMock);

        expect(
          await takePhotoConfigUsecase.call(
            clockingEventRegisterType:
                ClockingEventRegisterTypeEmailPassword(employeeId: tEmployeeId),
          ),
          true,
        );

        verify(() => getExecutionModeUsecase.call());
        verify(() => globalConfigurationRepository.getAll());

        verify(
          () => configurationRepository.findByEmployeeId(
            employeeId: tEmployeeId,
          ),
        );

        verifyNoMoreInteractions(getExecutionModeUsecase);
        verifyNoMoreInteractions(globalConfigurationRepository);
        verifyNoMoreInteractions(configurationRepository);
      });
    },
  );
}
