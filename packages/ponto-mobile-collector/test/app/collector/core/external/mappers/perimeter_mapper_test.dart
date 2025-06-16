import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/perimeter.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/geometric_form_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/perimeter_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/mappers/perimeter_mapper.dart';

import '../../../../../mocks/location_dto_mock.dart';

void main() {
  group('PerimeterMapper', () {
    test('fromClockToCollectorDtoList should return null when input is null', () {
      final result = PerimeterMapper.fromClockToCollectorDtoList(null);
      expect(result, isNull);
    });

    test('fromClockToCollectorDtoList should map a list of clock.PerimeterDto to PerimeterDto', () {
      final clockList = [
        clock.PerimeterDto(
          id: '1',
          radius: 10,
          startPoint: locationDtoMock,
          type: clock.GeometricFormType.circle,
        ),
      ];

      final result = PerimeterMapper.fromClockToCollectorDtoList(clockList);

      expect(result, isNotNull);
      expect(result!.length, 1);
      expect(result.first.id, '1');
      expect(result.first.radius, 10);
      expect(result.first.startPoint.latitude, 1.0);
      expect(result.first.startPoint.longitude, 2.0);
      expect(result.first.type, GeometricFormType.circle);
    });

    test('fromClockToCollectorDto should return null when input is null', () {
      final result = PerimeterMapper.fromClockToCollectorDto(null);
      expect(result, isNull);
    });

    test('fromClockToCollectorDto should map clock.PerimeterDto to PerimeterDto', () {
      final clockDto = clock.PerimeterDto(
        id: '1',
        radius: 10,
        startPoint: locationDtoMock,
        type: clock.GeometricFormType.circle,
      );

      final result = PerimeterMapper.fromClockToCollectorDto(clockDto);

      expect(result, isNotNull);
      expect(result!.id, '1');
      expect(result.radius, 10);
      expect(result.startPoint.latitude, 1.0);
      expect(result.startPoint.longitude, 2.0);
      expect(result.type, GeometricFormType.circle);
    });

    test('fromCollectorDtoToClockList should return null when input is null', () {
      final result = PerimeterMapper.fromCollectorDtoToClockList(null);
      expect(result, isNull);
    });

    test('fromCollectorDtoToClockList should map a list of PerimeterDto to clock.PerimeterDto', () {
      final dtoList = [
        PerimeterDto(
          id: '1',
          radius: 10,
          startPoint: locationMockDto,
          type: GeometricFormType.circle,
        ),
      ];

      final result = PerimeterMapper.fromCollectorDtoToClockList(dtoList);

      expect(result, isNotNull);
      expect(result!.length, 1);
      expect(result.first.id, '1');
      expect(result.first.radius, 10);
      expect(result.first.startPoint.latitude, 1.0);
      expect(result.first.startPoint.longitude, 2.0);
      expect(result.first.type, clock.GeometricFormType.circle);
    });

    test('fromCollectorDtoToClock should return null when input is null', () {
      final result = PerimeterMapper.fromCollectorDtoToClock(null);
      expect(result, isNull);
    });

    test('fromCollectorDtoToClock should map PerimeterDto to clock.PerimeterDto', () {
      final dto = PerimeterDto(
        id: '1',
        radius: 10,
        startPoint: locationMockDto,
        type: GeometricFormType.circle,
      );

      final result = PerimeterMapper.fromCollectorDtoToClock(dto);

      expect(result, isNotNull);
      expect(result!.id, '1');
      expect(result.radius, 10);
      expect(result.startPoint.latitude, 1.0);
      expect(result.startPoint.longitude, 2.0);
      expect(result.type, clock.GeometricFormType.circle);
    });

    test('fromDtoToEntityCollector should return null when input is null', () {
      final result = PerimeterMapper.fromDtoToEntityCollector(null);
      expect(result, isNull);
    });

    test('fromDtoToEntityCollector should map PerimeterDto to Perimeter', () {
      final dto = PerimeterDto(
        id: '1',
        radius: 10,
        startPoint: locationMockDto,
        type: GeometricFormType.circle,
      );

      final result = PerimeterMapper.fromDtoToEntityCollector(dto);

      expect(result, isNotNull);
      expect(result!.id, '1');
      expect(result.radius, 10);
      expect(result.startPoint!.latitude, 1.0);
      expect(result.startPoint!.longitude, 2.0);
      expect(result.type, GeometricFormType.circle);
    });

    test('fromEntityToDtoCollector should return null when input is null', () {
      final result = PerimeterMapper.fromEntityToDtoCollector(null);
      expect(result, isNull);
    });

    test('fromEntityToDtoCollector should map Perimeter to PerimeterDto', () {
      final entity = Perimeter(
        id: '1',
        radius: 10,
        startPoint: locationMockDto,
        type: GeometricFormType.circle,
      );

      final result = PerimeterMapper.fromEntityToDtoCollector(entity);

      expect(result, isNotNull);
      expect(result!.id, '1');
      expect(result.radius, 10);
      expect(result.startPoint.latitude, 1.0);
      expect(result.startPoint.longitude, 2.0);
      expect(result.type, GeometricFormType.circle);
    });
  });
}
