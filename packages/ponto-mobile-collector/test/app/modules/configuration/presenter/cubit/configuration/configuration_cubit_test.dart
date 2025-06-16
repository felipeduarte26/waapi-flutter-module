import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/user_permissions_entity.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/data_source_response_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/navigator/navigator_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/check_conection_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/check_user_permission_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_logs_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/sync_logs_api_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/drift/collector_database.dart';
import 'package:ponto_mobile_collector/app/collector/modules/configuration/presenter/cubit/configuration/configuration_cubit.dart';
import 'package:ponto_mobile_collector/app/collector/modules/configuration/presenter/cubit/configuration/configuration_state.dart';
import 'package:ponto_mobile_collector/app/collector/modules/routes/privacy_policy_routes.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

import '../../../../../../mocks/logs_table_data_mock.dart';

class MockGetUserFaceRecognitionUsecase extends Mock
    implements IGetUserFaceRecognitionUsecase {}

class MockISharedPreferencesService extends Mock
    implements ISharedPreferencesService {}

class MockAllLogsUsecase extends Mock implements GetLogsUsecase {}

class MockSyncLogsApiUsecase extends Mock implements SyncLogsApiUsecase {}

class MockCheckUserPermissionUsecase extends Mock
    implements CheckUserPermissionUsecase {}

class MockHasConnectivityUsecase extends Mock
    implements HasConnectivityUsecase {}

class MockNavigatorService extends Mock implements NavigatorService {}

void main() {
  late ConfigurationCubit configurationCubit;
  late IGetUserFaceRecognitionUsecase getUserFaceRecognitionUsecase;
  late ISharedPreferencesService sharedPreferencesService;
  late GetLogsUsecase getLogsUsecase;
  late SyncLogsApiUsecase syncLogsApiUsecase;
  late CheckUserPermissionUsecase checkUserPermissionUsecase;
  late HasConnectivityUsecase hasConnectivityUsecase;
  late NavigatorService navigatorService;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();

    getUserFaceRecognitionUsecase = MockGetUserFaceRecognitionUsecase();
    getLogsUsecase = MockAllLogsUsecase();
    syncLogsApiUsecase = MockSyncLogsApiUsecase();
    sharedPreferencesService = MockISharedPreferencesService();
    checkUserPermissionUsecase = MockCheckUserPermissionUsecase();
    hasConnectivityUsecase = MockHasConnectivityUsecase();
    navigatorService = MockNavigatorService();

    configurationCubit = ConfigurationCubit(
      getUserFaceRecognitionUsecase: getUserFaceRecognitionUsecase,
      sharedPreferencesService: sharedPreferencesService,
      getLogsUsecase: getLogsUsecase,
      syncLogsApiUsecase: syncLogsApiUsecase,
      checkUserPermissionUsecase: checkUserPermissionUsecase,
      hasConnectivityUsecase: hasConnectivityUsecase,
      navigatorService: navigatorService,
    );

    when(
      () => getUserFaceRecognitionUsecase.call(),
    ).thenAnswer((_) async => true);
  });

  group('ConfigurationCubit', () {
    blocTest(
      'call loadContent test',
      setUp: () {
        when(() => sharedPreferencesService.getSendCrashLog())
            .thenAnswer((_) async => false);
        when(
          () => checkUserPermissionUsecase.call(
            userPermissionCheckEntity: any(named: 'userPermissionCheckEntity'),
          ),
        ).thenAnswer(
          (_) async => const UserPermissionsEntity(
            authorized: true,
            permissions: [],
          ),
        );
      },
      build: () => configurationCubit,
      act: (bloc) => bloc.loadContent(),
      expect: () => [
        isA<LoadingContentState>(),
        isA<ReadContentState>(),
        isA<LogInactiveState>(),
      ],
      verify: (bloc) {
        verify(() => getUserFaceRecognitionUsecase.call()).called(1);
        verify(() => sharedPreferencesService.getSendCrashLog()).called(1);
        verify(
          () => checkUserPermissionUsecase.call(
            userPermissionCheckEntity: any(named: 'userPermissionCheckEntity'),
          ),
        ).called(1);
        verifyNoMoreInteractions(getUserFaceRecognitionUsecase);
        verifyNoMoreInteractions(sharedPreferencesService);
        verifyNoMoreInteractions(checkUserPermissionUsecase);
      },
    );
  });

  group('ConfigurationCubit', () {
    blocTest<ConfigurationCubit, ConfigurationBaseState>(
      'emits [LogActiveState] when toggleLogs is called and logs are activated',
      build: () {
        when(() => sharedPreferencesService.setSendCrashLog(value: true))
            .thenAnswer((_) async => {});
        return configurationCubit;
      },
      act: (cubit) => cubit.toggleLogs(),
      expect: () => [isA<LogActiveState>()],
      verify: (_) {
        verify(() => sharedPreferencesService.setSendCrashLog(value: true))
            .called(1);
      },
    );

    blocTest<ConfigurationCubit, ConfigurationBaseState>(
      'emits [LogInactiveState] when isActiveLogs is toggled to false',
      setUp: () {
        configurationCubit.isActiveLogs = true;
        when(() => sharedPreferencesService.setSendCrashLog(value: false))
            .thenAnswer((_) async => {});
      },
      build: () => configurationCubit,
      act: (cubit) => cubit.toggleLogs(),
      expect: () => [isA<LogInactiveState>()],
      verify: (_) {
        verify(() => sharedPreferencesService.setSendCrashLog(value: false))
            .called(1);
        verifyNoMoreInteractions(sharedPreferencesService);
      },
    );

    test('emits NoLogsToSyncState when notl logs in DB', () async {
      when(() => hasConnectivityUsecase.call()).thenAnswer((_) async => true);
      when(() => getLogsUsecase.fetchPaginatedLogsByDateAsc(batchSize:  any(named: 'batchSize'), offset: any(named: 'offset')))
          .thenAnswer((_) async => <LogsTableData>[]);

      await configurationCubit.syncLogsApi();

      expect(
        configurationCubit.state,
        isA<NoLogsToSyncState>(),
      );
    });

    test('emits SuccessSyncLogsApiState when response is success', () async {
      int callCount = 0;

      final dataResponse = DataSourceResponseDto(
        success: true,
        message: 'Success',
        statusCode: 202,
      );
      List<LogsTableData> logs = [
        logsTableDataMock,
        logsTableDataMock,
      ];
      
      when(() => hasConnectivityUsecase.call()).thenAnswer((_) async => true);

      when(() => getLogsUsecase.fetchPaginatedLogsByDateAsc(batchSize: 100, offset: 0))
          .thenAnswer((_) async {
        if (callCount == 0) {
          callCount++;
          return logs;
        } else {
          return <LogsTableData>[];
        }
      });

      when(() => syncLogsApiUsecase.call(listLogs: logs))
          .thenAnswer((_) async => dataResponse);

      await configurationCubit.syncLogsApi();

      expect(
        configurationCubit.state,
        isA<SuccessSyncLogsApiState>(),
      );
    });

    test('emits NoConnectionSyncLogsApiState when hasConnectivityUsecase return false', () async {
      when(() => hasConnectivityUsecase.call()).thenAnswer((_) async => false);

      await configurationCubit.syncLogsApi();

      expect(
        configurationCubit.state,
        isA<NoConnectionSyncLogsApiState>(),
      );
    });

    test('emits FaliedSyncLogsApiState when response is falied', () async {
      final dataResponse = DataSourceResponseDto(
        success: false,
        message: 'Falied',
        statusCode: 400,
      );

      List<LogsTableData> logs = [
        logsTableDataMock,
        logsTableDataMock,
      ];
      when(() => hasConnectivityUsecase.call()).thenAnswer((_) async => true);

      when(() => getLogsUsecase.fetchPaginatedLogsByDateAsc(batchSize: 100, offset: 0))
          .thenAnswer((invocation) async => logs);

      when(() => getLogsUsecase.fetchPaginatedLogsByDateAsc(batchSize: 100, offset: 100))
          .thenAnswer((invocation) async => <LogsTableData>[]);

      when(() => syncLogsApiUsecase.call(listLogs: logs))
          .thenAnswer((_) async => dataResponse);

      await configurationCubit.syncLogsApi();

      expect(
        configurationCubit.state,
        isA<FaliedSyncLogsApiState>(),
      );
    });

    test('emits UnexpectedErrorSyncLogsApiState when response is null',
        () async {
      int callCount = 0;

      final dataResponseSuccess = DataSourceResponseDto(
        success: true,
        message: 'Success',
        statusCode: 202,
      );

      final dataResponseError =
          DataSourceResponseDto(success: false, message: 'Falied');

      List<LogsTableData> logs = [
        logsTableDataMock,
        logsTableDataMock,
      ];

      List<LogsTableData> logsWithError = [
        logsTableDataMock,
      ];

      when(() => hasConnectivityUsecase.call()).thenAnswer((_) async => true);
      
      when(() => getLogsUsecase.fetchPaginatedLogsByDateAsc(batchSize: 100, offset: 0))
          .thenAnswer((_) async {
        if (callCount == 0) {
          callCount++;
          return logs;
        } else {
          return logsWithError;
        }
      });

      when(() => getLogsUsecase.fetchPaginatedLogsByDateAsc(batchSize: 100, offset: 100))
          .thenAnswer((invocation) async => <LogsTableData>[]);

      when(() => syncLogsApiUsecase.call(listLogs: logs))
          .thenAnswer((_) async => dataResponseSuccess);

      when(() => syncLogsApiUsecase.call(listLogs: logsWithError))
          .thenAnswer((_) async => dataResponseError);

      await configurationCubit.syncLogsApi();

      expect(
        configurationCubit.state,
        isA<PartialSuccessSyncLogs>(),
      );
    });
  });

  group('getLastPrivacyPoliceVersion', () {
    test('should open privacy policy url sucesufully - Not ready', () {
      when(
        () => navigatorService.pushNamed(
          route: PrivacyPolicyRoutes.homeFull,
        ),
      ).thenAnswer((_) async => null);

      configurationCubit.goToLastPrivacyPoliceVersion();

      verify(
        () => navigatorService.pushNamed(
          route: PrivacyPolicyRoutes.homeFull,
        ),
      ).called(1);
    });
  });
}
