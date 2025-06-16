import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_device_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/drift/collector_database.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/repositories/database/device_repository.dart';

import '../../../../../mocks/device_entity_mock.dart';

class MockDeviceRepository extends Mock implements DeviceRepository {}

void main() {
  late MockDeviceRepository mockDeviceRepository;
  late GetDeviceUsecaseImpl getDeviceUsecase;

  setUp(() {
    mockDeviceRepository = MockDeviceRepository();
    getDeviceUsecase =
        GetDeviceUsecaseImpl(deviceRepository: mockDeviceRepository);
  });

  group('GetDeviceUsecase', () {
    test('should return a Device when the identifier exists in the repository',
        () async {
      // Arrange
      const identifier = 'device123';
      const mockDeviceTable = DeviceTableData(
        id: 'id',
        imei: 'imei',
        status: 'AUTHORIZED',
        model: 'model',
        name: 'name',
      );
      final mockDevice = deviceEntityMock;

      when(() => mockDeviceRepository.findByIdentifier(id: identifier))
          .thenAnswer((_) async => mockDeviceTable);

      // Act
      final result = await getDeviceUsecase.call(identifier);

      // Assert
      expect(result, isNotNull);
      expect(result?.id, equals(mockDevice.id));
      expect(result?.name, equals(mockDevice.name));
      verify(() => mockDeviceRepository.findByIdentifier(id: identifier)).called(1);
    });

    test(
        'should return null when the identifier does not exist in the repository',
        () async {
      // Arrange
      const identifier = 'nonexistent_device';

      when(() => mockDeviceRepository.findByIdentifier(id: identifier))
          .thenAnswer((_) async => null);

      // Act
      final result = await getDeviceUsecase.call(identifier);

      // Assert
      expect(result, isNull);
      verify(() => mockDeviceRepository.findByIdentifier(id: identifier)).called(1);
    });
  });
}
