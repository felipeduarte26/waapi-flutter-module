import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/shared_preferences/ishared_preferences_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/send_logs_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/services/firebase/log_service_impl.dart';

class MockSharedPreferences extends Mock implements ISharedPreferencesService {}

class MockLogsUsecase extends Mock implements SendLogsUsecase {}

class MockFirebaseServiceCollector extends Mock
    implements LogServiceImpl {}


void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockSharedPreferences mockPrefs;
  late MockLogsUsecase mockLogsUsecase;
  late LogServiceImpl firebaseServiceCollector;

  setUp(() {
    mockPrefs = MockSharedPreferences();
    mockLogsUsecase = MockLogsUsecase();
    firebaseServiceCollector = LogServiceImpl(
      sendLogsUsecase: mockLogsUsecase,
      sharedPreferencesService: mockPrefs,
    );
  });

  group('Save local logs on database', () {
    test('should call logsUsecase when sendCrashLog is true ', () async {
      when(() => mockPrefs.getSendCrashLog()).thenAnswer((_) async => true);

      when(
        () => mockLogsUsecase.call(
          exception: 'Exception: testException',
          stackTrace: 'testStackTrace',
        ),
      ).thenAnswer((_) async => {});

      await firebaseServiceCollector.saveLocalLog(
        exception: Exception('testException'),
        stackTrace: 'testStackTrace',
      );

      verify(
        () => mockLogsUsecase.call(
          exception: 'Exception: testException',
          stackTrace: 'testStackTrace',
        ),
      ).called(1);
    });

    test('should not call logsUsecase when sendCrashLog is false', () async {
      when(() => mockPrefs.getSendCrashLog()).thenAnswer((_) async => false);

      await firebaseServiceCollector.saveLocalLog(
        exception: 'testException',
        stackTrace: 'testStackTrace',
      );

      verifyNever(
        () => mockLogsUsecase.call(
          exception: 'Exception: testException',
          stackTrace: 'testStackTrace',
        ),
      );
    });
  });

}
