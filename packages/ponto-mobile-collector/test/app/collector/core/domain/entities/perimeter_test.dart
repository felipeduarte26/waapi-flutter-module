import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/perimeter.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/geometric_form_type.dart';

import '../../../../../mocks/location_dto_mock.dart';

void main() {
  group('Perimeter', () {
    test('should create a Perimeter instance with required radius', () {
      const perimeter = Perimeter(radius: 10.0);

      expect(perimeter.radius, 10.0);
      expect(perimeter.id, isNull);
      expect(perimeter.type, isNull);
      expect(perimeter.startPoint, isNull);
    });

    test('should create a Perimeter instance with all properties', () {
      var location = locationMockDto;
      var perimeter = Perimeter(
        id: '123',
        type: GeometricFormType.circle,
        startPoint: location,
        radius: 15.0,
      );

      expect(perimeter.id, '123');
      expect(perimeter.type, GeometricFormType.circle);
      expect(perimeter.startPoint, location);
      expect(perimeter.radius, 15.0);
    });

    test('should compare two Perimeter instances correctly', () {
      const perimeter1 = Perimeter(radius: 10.0);
      const perimeter2 = Perimeter(radius: 10.0);
      const perimeter3 = Perimeter(radius: 20.0);

      expect(perimeter1, perimeter2);
      expect(perimeter1, isNot(perimeter3));
    });
  });
}
