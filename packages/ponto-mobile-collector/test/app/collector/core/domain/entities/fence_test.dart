import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/fence.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/perimeter.dart';

import '../../../../../mocks/location_dto_mock.dart';

void main() {
  group('Fence', () {
    test('should support value equality', () {
      var fence1 = Fence(
        id: '1',
        name: 'Test Fence',
        perimeters: [Perimeter(id: '1', radius: double.infinity, startPoint: locationMockDto)],
      );
      var fence2 = Fence(
        id: '1',
        name: 'Test Fence',
        perimeters: [Perimeter(id: '1', radius: double.infinity, startPoint: locationMockDto)],
      );

      expect(fence1, equals(fence2));
    });

    test('props should contain all fields', () {
      var fence = Fence(
        id: '1',
        name: 'Test Fence',
        perimeters: [Perimeter(id: '1', radius: double.infinity, startPoint: locationMockDto)],
      );

      expect(fence.props, [
        fence.id,
        fence.name,
        fence.perimeters,
      ]);
    });

    test('should create a Fence instance with required fields', () {
      const fence = Fence(name: 'Test Fence');

      expect(fence.id, isNull);
      expect(fence.name, 'Test Fence');
      expect(fence.perimeters, isNull);
    });

    test('should create a Fence instance with all fields', () {
      var fence = Fence(
        id: '1',
        name: 'Test Fence',
        perimeters: [Perimeter(id: '1', radius: double.infinity, startPoint: locationMockDto)],
      );

      expect(fence.id, '1');
      expect(fence.name, 'Test Fence');
      expect(fence.perimeters, isNotNull);
      expect(fence.perimeters!.length, 1);
      expect(fence.perimeters!.first.id, '1');
    });
  });
}
