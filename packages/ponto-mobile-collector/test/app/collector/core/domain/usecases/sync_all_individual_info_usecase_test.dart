import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/mobile_login_usecase_return.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/sync_individual_status_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/token_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/work_indicator_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/synchronization_result.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/firebase/log_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/work_indicator_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/check_conection_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_environment_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_token_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/mobile_login_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/sync_all_individual_info_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/sync_face_employee_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/environment_enum.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/synchronization_enum.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/init_clock_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/synchronize_clocking_event_usecase.dart';

import '../../../../../mocks/token_mock.dart';

class MockGetTokenUsecase extends Mock implements GetTokenUsecase {}

class MockHasConnectivityUsecase extends Mock
    implements IHasConnectivityUsecase {}

class MockGetEnvironmentUsecase extends Mock implements GetEnvironmentUsecase {}

class MockMobileLoginUsecase extends Mock implements MobileLoginUsecase {}

class MockInitClockUsecase extends Mock implements IInitClockUsecase {}

class MockLogService extends Mock implements LogService {}

class MockSyncFaceEmployeeUsecase extends Mock
    implements SyncFaceEmployeeUsecase {}

class MockSynchronizeClockingEventUsecase extends Mock
    implements ISynchronizeClockingEventUsecase {}

class MockWorkIndicatorService extends Mock implements WorkIndicatorService {}

void main() {
  late SyncAllIndividualInfoUsecaseImpl usecase;
  late GetTokenUsecase mockGetTokenUsecase;
  late IHasConnectivityUsecase mockHasConnectivityUsecase;
  late GetEnvironmentUsecase mockGetEnvironmentUsecase;
  late MobileLoginUsecase mockMobileLoginUsecase;
  late IInitClockUsecase mockInitClockUsecase;
  late SyncFaceEmployeeUsecase mockSyncFaceEmployeeUsecase;
  late ISynchronizeClockingEventUsecase mockSynchronizeClockingEventUsecase;
  late WorkIndicatorService mockWorkIndicatorService;
  late LogService logService;

  setUp(() {
    mockGetTokenUsecase = MockGetTokenUsecase();
    mockHasConnectivityUsecase = MockHasConnectivityUsecase();
    mockGetEnvironmentUsecase = MockGetEnvironmentUsecase();
    mockMobileLoginUsecase = MockMobileLoginUsecase();
    mockInitClockUsecase = MockInitClockUsecase();
    mockSyncFaceEmployeeUsecase = MockSyncFaceEmployeeUsecase();
    mockSynchronizeClockingEventUsecase = MockSynchronizeClockingEventUsecase();
    mockWorkIndicatorService = MockWorkIndicatorService();
    logService = MockLogService();

    when(
      () => logService.saveLocalLog(
        exception: any(named: 'exception'),
        stackTrace: any(named: 'stackTrace'),
      ),
    ).thenReturn(null);

    usecase = SyncAllIndividualInfoUsecaseImpl(
      getTokenUsecase: mockGetTokenUsecase,
      hasConnectivityUsecase: mockHasConnectivityUsecase,
      getEnvironmentUsecase: mockGetEnvironmentUsecase,
      mobileLoginUsecase: mockMobileLoginUsecase,
      initClockUsecase: mockInitClockUsecase,
      syncFaceEmployeeUsecase: mockSyncFaceEmployeeUsecase,
      synchronizeClockingEventUsecase: mockSynchronizeClockingEventUsecase,
      workIndicatorService: mockWorkIndicatorService,
      logService: logService,
    );

    when(
      () => mockWorkIndicatorService.addWorkIndicator(
        workIndicatorType: WorkIndicatorType.syncAllIndividualInfo,
      ),
    ).thenAnswer((_) => true);

    when(
      () => mockWorkIndicatorService.removeWorkIndicator(
        workIndicatorType: WorkIndicatorType.syncAllIndividualInfo,
      ),
    ).thenAnswer((_) => true);
  });

  group('SyncAllIndividualInfoUsecaseImpl', () {
    test('should return tokenUnavailable when user access token is null',
        () async {
      when(() => mockGetTokenUsecase.call(tokenType: TokenType.user))
          .thenAnswer((_) async => null);

      final result = await usecase.call();

      expect(result, SyncIndividualStatusType.tokenUnavailable);
    });

    test('should return connectionUnavailable when there is no connectivity',
        () async {
      when(() => mockGetTokenUsecase.call(tokenType: TokenType.user))
          .thenAnswer((_) async => tokenMock);
      when(() => mockHasConnectivityUsecase.call())
          .thenAnswer((_) async => false);

      final result = await usecase.call();

      expect(result, SyncIndividualStatusType.connectionUnavailable);
    });

    test('should return failure when mobile login fails', () async {
      when(() => mockGetTokenUsecase.call(tokenType: TokenType.user))
          .thenAnswer((_) async => tokenMock);
      when(() => mockHasConnectivityUsecase.call())
          .thenAnswer((_) async => true);
      when(() => mockGetEnvironmentUsecase.call())
          .thenAnswer((_) async => EnvironmentEnum.prod);
      when(() => mockMobileLoginUsecase.call(EnvironmentEnum.prod, tokenMock))
          .thenAnswer((_) async => null);

      final result = await usecase.call();

      expect(result, SyncIndividualStatusType.failure);
    });

    test('should return failure when sync face employee fails', () async {
      when(() => mockInitClockUsecase.call()).thenAnswer((_) async => {});
      when(() => mockGetTokenUsecase.call(tokenType: TokenType.user))
          .thenAnswer((_) async => tokenMock);
      when(() => mockHasConnectivityUsecase.call())
          .thenAnswer((_) async => true);
      when(() => mockGetEnvironmentUsecase.call())
          .thenAnswer((_) async => EnvironmentEnum.prod);
      when(() => mockMobileLoginUsecase.call(EnvironmentEnum.prod, tokenMock))
          .thenAnswer((_) async => MobileLoginUsecaseReturn(success: true));
      when(() => mockSyncFaceEmployeeUsecase.call()).thenAnswer(
        (_) async => SynchronizationResult(
          SynchronizationStatus.error,
          SynchronizationMessage.syncClockingEventSyncFailure,
        ),
      );
      when(() => mockSynchronizeClockingEventUsecase.call()).thenAnswer(
        (_) async => SynchronizationResult(
          SynchronizationStatus.success,
          SynchronizationMessage.syncClockingEventSyncSuccess,
        ),
      );

      final result = await usecase.call();

      expect(result, SyncIndividualStatusType.failure);
    });

    test('should return failure when sync clocking event fails', () async {
      when(() => mockInitClockUsecase.call()).thenAnswer((_) async => {});
      when(() => mockGetTokenUsecase.call(tokenType: TokenType.user))
          .thenAnswer((_) async => tokenMock);
      when(() => mockHasConnectivityUsecase.call())
          .thenAnswer((_) async => true);
      when(() => mockGetEnvironmentUsecase.call())
          .thenAnswer((_) async => EnvironmentEnum.prod);
      when(() => mockMobileLoginUsecase.call(EnvironmentEnum.prod, tokenMock))
          .thenAnswer((_) async => MobileLoginUsecaseReturn(success: true));
      when(() => mockSyncFaceEmployeeUsecase.call()).thenAnswer(
        (_) async => SynchronizationResult(
          SynchronizationStatus.success,
          SynchronizationMessage.syncClockingEventSyncSuccess,
        ),
      );
      when(() => mockSynchronizeClockingEventUsecase.call()).thenAnswer(
        (_) async => SynchronizationResult(
          SynchronizationStatus.error,
          SynchronizationMessage.syncClockingEventSyncFailure,
        ),
      );

      final result = await usecase.call();

      expect(result, SyncIndividualStatusType.failure);
    });

    test('should return success when all sync operations are successful',
        () async {
      when(() => mockInitClockUsecase.call()).thenAnswer((_) async => {});
      when(() => mockGetTokenUsecase.call(tokenType: TokenType.user))
          .thenAnswer((_) async => tokenMock);
      when(() => mockHasConnectivityUsecase.call())
          .thenAnswer((_) async => true);
      when(() => mockGetEnvironmentUsecase.call())
          .thenAnswer((_) async => EnvironmentEnum.prod);
      when(() => mockMobileLoginUsecase.call(EnvironmentEnum.prod, tokenMock))
          .thenAnswer((_) async => MobileLoginUsecaseReturn(success: true));
      when(() => mockSyncFaceEmployeeUsecase.call()).thenAnswer(
        (_) async => SynchronizationResult(
          SynchronizationStatus.success,
          SynchronizationMessage.syncClockingEventSyncSuccess,
        ),
      );
      when(() => mockSynchronizeClockingEventUsecase.call()).thenAnswer(
        (_) async => SynchronizationResult(
          SynchronizationStatus.success,
          SynchronizationMessage.syncClockingEventSyncSuccess,
        ),
      );

      final result = await usecase.call();

      expect(result, SyncIndividualStatusType.success);
    });
  });
}
