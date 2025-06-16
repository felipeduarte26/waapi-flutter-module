import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/activation.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/activation_situation_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/status_device.dart';

void main() {
  group('Activation', () {
    test('should create an Activation instance with correct values', () {
      const activation = Activation(
        id: '123',
        deviceSituation: StatusDevice.authorized,
        employeeSituation: ActivationSituationType.authorized,
        requestDate: '2023-01-01',
        requestTime: '12:00:00',
      );

      expect(activation.id, '123');
      expect(activation.deviceSituation, StatusDevice.authorized);
      expect(activation.employeeSituation, ActivationSituationType.authorized);
      expect(activation.requestDate, '2023-01-01');
      expect(activation.requestTime, '12:00:00');
    });

    test('copyWith should return a new instance with updated values', () {
      const activation = Activation(
        id: '123',
        deviceSituation: StatusDevice.authorized,
        employeeSituation: ActivationSituationType.authorized,
        requestDate: '2023-01-01',
        requestTime: '12:00:00',
      );

      final updatedActivation = activation.copyWith(
        id: '456',
        requestTime: '14:00:00',
      );

      expect(updatedActivation.id, '456');
      expect(updatedActivation.deviceSituation, StatusDevice.authorized);
      expect(updatedActivation.employeeSituation, ActivationSituationType.authorized);
      expect(updatedActivation.requestDate, '2023-01-01');
      expect(updatedActivation.requestTime, '14:00:00');
    });

    test('props should contain all properties', () {
      const activation = Activation(
        id: '123',
        deviceSituation: StatusDevice.authorized,
        employeeSituation: ActivationSituationType.authorized,
        requestDate: '2023-01-01',
        requestTime: '12:00:00',
      );

      expect(activation.props, [
        '123',
        StatusDevice.authorized,
        ActivationSituationType.authorized,
        '2023-01-01',
        '12:00:00',
      ]);
    });
  });
}
