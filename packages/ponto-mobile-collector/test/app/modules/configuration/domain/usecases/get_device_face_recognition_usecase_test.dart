import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/device_configuration.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/database/i_device_configuration_repository.dart';
import 'package:ponto_mobile_collector/app/collector/modules/configuration/domain/usecases/get_device_face_recognition_usecase.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

class MockSessionService extends Mock implements ISessionService {}

class MockDeviceConfigurationRepository extends Mock
    implements IDeviceConfigurationRepository {}

void main() {
  late IDeviceConfigurationRepository configurationRepository;
  late IGetDeviceFaceRecognitionUsecase getDeviceFaceRecognitionUsecase;

  setUp(() {
    configurationRepository = MockDeviceConfigurationRepository();
    getDeviceFaceRecognitionUsecase = GetDeviceFaceRecognitionUsecase(
      configurationRepository: configurationRepository,
    );
  });

  group('GetDeviceFaceRecognitionUsecase', () {
    test('should return false when there is no deviceConfifuration test',
        () async {
      when(
        () => configurationRepository.getConfiguration(),
      ).thenAnswer((_) async => null);

      expect((await getDeviceFaceRecognitionUsecase.call()), false);

      verify(() => configurationRepository.getConfiguration()).called(1);
    });

    test('should return false when enableFacial is false test', () async {
      DeviceConfiguration deviceConfiguration = DeviceConfiguration(
        id: '',
        enableNfc: false,
        enableQrCode: false,
        enableFacial: false,
        timeZone: '',
        lastUpdate: DateTime(2024),
        lastSync: DateTime(2024),
        enableUserPassword: false,
        allowChangeTime: false,
      );

      when(
        () => configurationRepository.getConfiguration(),
      ).thenAnswer((_) async => deviceConfiguration);

      expect((await getDeviceFaceRecognitionUsecase.call()), false);

      verify(() => configurationRepository.getConfiguration()).called(1);
    });

    test('should return true when enableFacial is true test', () async {
      DeviceConfiguration deviceConfiguration = DeviceConfiguration(
        id: '',
        enableNfc: false,
        enableQrCode: false,
        enableFacial: true,
        timeZone: '',
        lastUpdate: DateTime(2024),
        lastSync: DateTime(2024),
        enableUserPassword: false,
        allowChangeTime: false,
      );

      when(
        () => configurationRepository.getConfiguration(),
      ).thenAnswer((_) async => deviceConfiguration);

      expect((await getDeviceFaceRecognitionUsecase.call()), true);

      verify(() => configurationRepository.getConfiguration()).called(1);
    });
  });
}
