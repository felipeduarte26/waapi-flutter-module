import 'package:flutter_gryfo_lib/flutter_gryfo_lib.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/firebase/log_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/check_conection_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/deauthenticate_user_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_facial_recognition_is_enable_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/logoff_usecase.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

class MockFlutterGryfoLib extends Mock implements FlutterGryfoLib {}

class MockSharedPreferencesService extends Mock
    implements ISharedPreferencesService {}

class MockICollectorModuleService extends Mock
    implements ICollectorModuleService {}

class MockHasConnectivityUsecase extends Mock
    implements HasConnectivityUsecase {}

class MockGetFacialRecognitionIsEnableUsecase extends Mock
    implements GetFacialRecognitionIsEnableUsecase {}

class MockDeauthenticateUserUsecase extends Mock
    implements DeauthenticateUserUsecase {}

class MockLogService extends Mock implements LogService {}

void main() {
  late ILogoffUsecase logoffUsecase;
  late FlutterGryfoLib gryfoLib;
  late ICollectorModuleService collectorModuleService;
  late ISharedPreferencesService sharedPreferencesService;
  late HasConnectivityUsecase hasConnectivityUsecase;
  late GetFacialRecognitionIsEnableUsecase getFacialRecognitionIsEnableUsecase;
  late DeauthenticateUserUsecase deauthenticateUserUsecase;
  late LogService logService;

  setUp(() {
    gryfoLib = MockFlutterGryfoLib();
    collectorModuleService = MockICollectorModuleService();
    sharedPreferencesService = MockSharedPreferencesService();
    hasConnectivityUsecase = MockHasConnectivityUsecase();
    getFacialRecognitionIsEnableUsecase =
        MockGetFacialRecognitionIsEnableUsecase();
    deauthenticateUserUsecase = MockDeauthenticateUserUsecase();
    logService = MockLogService();

    when(
      () => logService.saveLocalLog(
        exception: any(named: 'exception'),
        stackTrace: any(named: 'stackTrace'),
      ),
    ).thenReturn(null);

    when(() => sharedPreferencesService.removeTenant())
        .thenAnswer((_) async => true);

    when(() => hasConnectivityUsecase.call()).thenAnswer((_) async => true);

    when(
      () => collectorModuleService.finalize(),
    ).thenAnswer((_) async => {});

    when(
      () => getFacialRecognitionIsEnableUsecase.call(),
    ).thenAnswer(
      (_) async => true,
    );

    when(
      () => deauthenticateUserUsecase.call(),
    ).thenAnswer((_) async => {});

    when(
      () => gryfoLib.synchronizeExternalIds([]),
    ).thenAnswer((_) async => {});

    logoffUsecase = LogoffUsecase(
      gryfoLib: gryfoLib,
      collectorModuleService: collectorModuleService,
      sharedPreferencesService: sharedPreferencesService,
      deauthenticateUserUsecase: deauthenticateUserUsecase,
      hasConnectivityUsecase: hasConnectivityUsecase,
      getFacialRecognitionIsEnableUsecase: getFacialRecognitionIsEnableUsecase,
      logService: logService,
    );
  });

  group('LogoffUsecase', () {
    test('facial recognition not enable logoff test', () async {
      when(
        () => getFacialRecognitionIsEnableUsecase.call(),
      ).thenAnswer((_) async => false);

      await logoffUsecase.call(cleanTenant: true);

      verify(() => sharedPreferencesService.removeTenant());
      verify(() => hasConnectivityUsecase.call());
      verify(() => getFacialRecognitionIsEnableUsecase.call());
      verify(() => deauthenticateUserUsecase.call());
      verify(() => collectorModuleService.finalize());

      verifyNoMoreInteractions(sharedPreferencesService);
      verifyNoMoreInteractions(hasConnectivityUsecase);
      verifyNoMoreInteractions(getFacialRecognitionIsEnableUsecase);
      verifyZeroInteractions(gryfoLib);
      verifyNoMoreInteractions(deauthenticateUserUsecase);
      verifyNoMoreInteractions(collectorModuleService);
    });

    test('not clean tenant logoff test', () async {
      await logoffUsecase.call();

      verify(() => hasConnectivityUsecase.call());
      verify(() => getFacialRecognitionIsEnableUsecase.call());
      verify(() => gryfoLib.synchronizeExternalIds([]));
      verify(() => deauthenticateUserUsecase.call());
      verify(() => collectorModuleService.finalize());

      verifyZeroInteractions(sharedPreferencesService);
      verifyNoMoreInteractions(hasConnectivityUsecase);
      verifyNoMoreInteractions(getFacialRecognitionIsEnableUsecase);
      verifyNoMoreInteractions(gryfoLib);
      verifyNoMoreInteractions(deauthenticateUserUsecase);
      verifyNoMoreInteractions(collectorModuleService);
    });

    test('successful logoff test', () async {
      await logoffUsecase.call(cleanTenant: true);
      verify(() => sharedPreferencesService.removeTenant());
      verify(() => hasConnectivityUsecase.call());
      verify(() => getFacialRecognitionIsEnableUsecase.call());
      verify(() => gryfoLib.synchronizeExternalIds([]));
      verify(() => deauthenticateUserUsecase.call());
      verify(() => collectorModuleService.finalize());

      verifyNoMoreInteractions(sharedPreferencesService);
      verifyNoMoreInteractions(hasConnectivityUsecase);
      verifyNoMoreInteractions(getFacialRecognitionIsEnableUsecase);
      verifyNoMoreInteractions(gryfoLib);
      verifyNoMoreInteractions(deauthenticateUserUsecase);
      verifyNoMoreInteractions(collectorModuleService);
    });
  });
}
