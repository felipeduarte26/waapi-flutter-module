import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/geometric_form_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/fence_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/perimeter_dto.dart';

import '../../../../../mocks/location_dto_mock.dart';

void main() {
  group('FenceDto', () {
    test('should create a FenceDto instance with correct values', () {
      final perimeters = [
        PerimeterDto(
          id: '1',
          type: GeometricFormType.circle,
          startPoint: locationMockDto,
          radius: double.infinity,
        ),
        PerimeterDto(
          id: '2',
          type: GeometricFormType.circle,
          startPoint: locationMockDto,
          radius: double.infinity,
        ),
      ];

      final fence = FenceDto(
        id: '123',
        name: 'Test Fence',
        perimeters: perimeters,
      );

      expect(fence.id, '123');
      expect(fence.name, 'Test Fence');
      expect(fence.perimeters, perimeters);
    });

    test('should convert FenceDto to JSON correctly', () {
      final perimeters = [
        PerimeterDto(
          id: '1',
          type: GeometricFormType.circle,
          startPoint: locationMockDto,
          radius: double.infinity,
        ),
        PerimeterDto(
          id: '2',
          type: GeometricFormType.circle,
          startPoint: locationMockDto,
          radius: double.infinity,
        ),
      ];


      final fence = FenceDto(
        id: '123',
        name: 'Test Fence',
        perimeters: perimeters,
      );

      final json = fence.toJson();

      expect(json['id'], '123');
      expect(json['name'], 'Test Fence');
      expect(json['perimeters'], isNotNull);
    });

    test('should create FenceDto from JSON correctly', () {
      final json = {
        'id': '123',
        'name': 'Test Fence',
        'perimeters': [
          {'id': '1', 'type': 'circle', 'startPoint': locationMockDto.toJson(), 'radius': double.infinity},
          {'id': '2', 'type': 'circle', 'startPoint': locationMockDto.toJson(), 'radius': double.infinity},
        ],
      };

      final fence = FenceDto.fromJson(json);

      expect(fence.id, '123');
      expect(fence.name, 'Test Fence');
      expect(fence.perimeters, isNotNull);
      expect(fence.perimeters!.length, 2);
      expect(fence.perimeters![0].id, '1');
    });
  });
}
