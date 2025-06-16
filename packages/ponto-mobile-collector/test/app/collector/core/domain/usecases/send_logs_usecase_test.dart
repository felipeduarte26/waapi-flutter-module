import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/token_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/sync_logs_api_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/logs/delete_logs_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/logs/get_logs_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/logs/send_logs_service.dart.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/platform/iplatform_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/session/isession_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/delete_logs_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_access_token_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_execution_mode_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_logs_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_token_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/send_logs_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/drift/collector_database.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/repositories/database/logs_repository_db_impl.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/execution_mode_enum.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/iutils.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/get_clock_time_usecase.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../../../mocks/crash_log_mock.dart';
import '../../../../../mocks/device_info_mock.dart';
import '../../../../../mocks/employee_dto_mock.dart';
import '../../../../../mocks/import_clocking_event_dto_mock.dart';

class MockPlatformService extends Mock implements IPlatformService {}

class MockSessionService extends Mock implements ISessionService {}

class MockLogsService extends Mock implements SendLogsService {}

class MockUtils extends Mock implements IUtils {}

class MockGetExecutionModeUsecase extends Mock
    implements GetExecutionModeUsecase {}

class MockLogsUsecase extends Mock implements SendLogsUsecaseImpl {}

class MockCollectorDatabase extends Mock implements CollectorDatabase {}

class MockSyncLogsApiRepository extends Mock implements SyncLogsApiRepository {}

class MockGetLogsUsecase extends Mock implements GetLogsUsecaseImpl {}

class MockDeleteLogsUsecase extends Mock
    implements DeleteLogsUsecaseImpl {}

class MockLogsRepositoryDb extends Mock implements LogsRepositoryDbImpl {}

class MockGetLogsService extends Mock implements GetLogsService {}

class MockDeleteLogsService extends Mock implements DeleteLogsService {}

class MockGetTokenUsecase extends Mock implements GetTokenUsecase {}

class MockGetClockDateTimeUsecase extends Mock implements GetClockDateTimeUsecase {}

class MockGetAccessTokenUsecase extends Mock
    implements GetAccessTokenUsecaseImpl {}

void main() {
  late SendLogsUsecaseImpl logsUsecase;
  late MockPlatformService mockPlatformService;
  late MockSessionService mockSessionService;
  late MockLogsService mockLogsService;
  late MockUtils mockUtils;
  late MockGetExecutionModeUsecase mockGetExecutionModeUsecase;
  late MockGetAccessTokenUsecase mockGetAccessTokenUsecase;
  late Token fakeToken;
  late GetTokenUsecase getTokenUsecase;
  late GetClockDateTimeUsecase mockGetClockDateTimeUsecase;

  late CollectorDatabase mockCollectorDatabase;

  LazyDatabase openConnection() {
    return LazyDatabase(
      () async {
        return NativeDatabase.memory(logStatements: false);
      },
    );
  }

  setUp(() {
    mockPlatformService = MockPlatformService();
    mockSessionService = MockSessionService();
    mockLogsService = MockLogsService();
    mockUtils = MockUtils();
    mockGetExecutionModeUsecase = MockGetExecutionModeUsecase();
    mockGetAccessTokenUsecase = MockGetAccessTokenUsecase();
    getTokenUsecase = MockGetTokenUsecase();
    mockGetClockDateTimeUsecase = MockGetClockDateTimeUsecase();
    mockCollectorDatabase = CollectorDatabase(
      database: openConnection(),
    );

    logsUsecase = SendLogsUsecaseImpl(
      platformService: mockPlatformService,
      sessionService: mockSessionService,
      sendLogsService: mockLogsService,
      getTokenUsecase: getTokenUsecase,
      utils: mockUtils,
      getExecutionModeUsecase: mockGetExecutionModeUsecase,
      getAccessTokenUsecase: mockGetAccessTokenUsecase,
      getClockDateTimeUsecase: mockGetClockDateTimeUsecase,
    );

    fakeToken = const Token(
      accessToken: '123',
      expiresIn: 1234123,
      tokenType: 'bearer',
      refreshToken: '123',
    );
  });
  tearDown(
    () async {
      await mockCollectorDatabase.close();
    },
  );
  group('LogsUsecase', () {
    test('method should send log', () async {
      registerFallbackValue(crashLogMock);
      var operationMode = ExecutionModeEnum.multiple;

      when(() => mockPlatformService.getDeviceInfoDto())
          .thenAnswer((_) async => deviceMockInfo);
      when(() => getTokenUsecase.call(tokenType: TokenType.user))
          .thenAnswer((_) async => fakeToken);
      when(() => getTokenUsecase.call(tokenType: TokenType.key))
          .thenAnswer((_) async => fakeToken);
      when(() => mockSessionService.hasEmployee()).thenReturn(true);
      when(() => mockSessionService.getEmployee()).thenReturn(employeeMockDto);
      when(() => mockGetExecutionModeUsecase.call())
          .thenAnswer((_) async => operationMode);
      when(() => mockGetAccessTokenUsecase.call())
          .thenAnswer((_) async => fakeToken.accessToken);
      when(() => mockUtils.isNullOrWhitespace(str: deviceMockInfo.identifier))
          .thenReturn(false);
      when(() => mockLogsService.sendLog(crashLog: any(named: 'crashLog')))
          .thenAnswer((_) async => {});
      when(() => mockGetClockDateTimeUsecase.call())
          .thenReturn(DateTime.now());

      await logsUsecase.call(
        exception: 'Test Exception',
        stackTrace: 'Test StackTrace',
      );

      verify(() => mockLogsService.sendLog(crashLog: any(named: 'crashLog')))
          .called(1);
    });

    test('error sending logs test', () async {
      registerFallbackValue(crashLogMock);

      when(() => mockPlatformService.getDeviceInfoDto())
          .thenAnswer((_) async => deviceMockInfo);

      when(() => getTokenUsecase.call(tokenType: TokenType.user))
          .thenAnswer((_) async => null);

      when(() => getTokenUsecase.call(tokenType: TokenType.key))
          .thenAnswer((_) async => fakeToken);

      when(() => mockGetExecutionModeUsecase.call()).thenThrow(Exception());

      await logsUsecase.call(
        exception: 'Test Exception',
        stackTrace: 'Test StackTrace',
      );

      verify(() => mockPlatformService.getDeviceInfoDto());

      verify(() => getTokenUsecase.call(tokenType: TokenType.user));

      verify(() => getTokenUsecase.call(tokenType: TokenType.key));

      verify(() => mockGetExecutionModeUsecase.call());
    });

    test('method should send log with importClockingEvent', () async {
      registerFallbackValue(crashLogMock);
      var operationMode = ExecutionModeEnum.multiple;

      when(() => mockPlatformService.getDeviceInfoDto())
          .thenAnswer((_) async => deviceMockInfo);
      when(() => getTokenUsecase.call(tokenType: TokenType.user))
          .thenAnswer((_) async => fakeToken);
      when(() => getTokenUsecase.call(tokenType: TokenType.key))
          .thenAnswer((_) async => fakeToken);
      when(() => mockSessionService.hasEmployee()).thenReturn(true);
      when(() => mockSessionService.getEmployee()).thenReturn(employeeMockDto);
      when(() => mockGetExecutionModeUsecase.call())
          .thenAnswer((_) async => operationMode);
      when(() => mockGetAccessTokenUsecase.call())
          .thenAnswer((_) async => fakeToken.accessToken);
      when(() => mockUtils.isNullOrWhitespace(str: deviceMockInfo.identifier))
          .thenReturn(false);
      when(() => mockLogsService.sendLog(crashLog: any(named: 'crashLog')))
          .thenAnswer((_) async => {});
      when(() => mockGetClockDateTimeUsecase.call())
          .thenReturn(DateTime.now());

      await logsUsecase.call(
        exception: 'Test Exception',
        stackTrace: 'Test StackTrace',
        dateTimeOnDevice: DateTime.now(),
        importClockingEvent: importClockingEventDtoMock,
      );

      verify(() => mockLogsService.sendLog(crashLog: any(named: 'crashLog')))
          .called(1);
    });
  });
}
