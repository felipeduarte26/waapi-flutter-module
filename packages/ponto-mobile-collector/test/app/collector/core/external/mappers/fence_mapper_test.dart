import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_authentication/mobile_authentication_service.dart' as auth;
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/fence.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/fence_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/mappers/fence_mapper.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/mappers/perimeter_mapper.dart';

class MockPerimeterMapper extends Mock implements PerimeterMapper {}

void main() {
  group('FenceMapper', () {
    test('fromClockToCollectorDtoList should return null when input is null', () {
      final result = FenceMapper.fromClockToCollectorDtoList(null);
      expect(result, isNull);
    });

    test('fromClockToCollectorDtoList should map list correctly', () {
      final clockFence = clock.FenceDto(id: '1', name: 'Fence 1', perimeters: []);
      final result = FenceMapper.fromClockToCollectorDtoList([clockFence]);

      expect(result, isNotNull);
      expect(result!.length, 1);
      expect(result.first.id, '1');
      expect(result.first.name, 'Fence 1');
    });

    test('fromClockToCollectorDto should return null when input is null', () {
      final result = FenceMapper.fromClockToCollectorDto(null);
      expect(result, isNull);
    });

    test('fromClockToCollectorDto should map correctly', () {
      final clockFence = clock.FenceDto(id: '1', name: 'Fence 1', perimeters: []);
      final result = FenceMapper.fromClockToCollectorDto(clockFence);

      expect(result, isNotNull);
      expect(result!.id, '1');
      expect(result.name, 'Fence 1');
    });

    test('fromCollectorDtoToClockList should return null when input is null', () {
      final result = FenceMapper.fromCollectorDtoToClockList(null);
      expect(result, isNull);
    });

    test('fromCollectorDtoToClockList should map list correctly', () {
      final collectorFence = FenceDto(id: '1', name: 'Fence 1', perimeters: []);
      final result = FenceMapper.fromCollectorDtoToClockList([collectorFence]);

      expect(result, isNotNull);
      expect(result!.length, 1);
      expect(result.first.id, '1');
      expect(result.first.name, 'Fence 1');
    });

    test('fromCollectorDtoToClock should return null when input is null', () {
      final result = FenceMapper.fromCollectorDtoToClock(null);
      expect(result, isNull);
    });

    test('fromCollectorDtoToClock should map correctly', () {
      final collectorFence = FenceDto(id: '1', name: 'Fence 1', perimeters: []);
      final result = FenceMapper.fromCollectorDtoToClock(collectorFence);

      expect(result, isNotNull);
      expect(result!.id, '1');
      expect(result.name, 'Fence 1');
    });

    test('fromDtoToEntityCollectorList should return null when input is null', () {
      final result = FenceMapper.fromDtoToEntityCollectorList(null);
      expect(result, isNull);
    });

    test('fromDtoToEntityCollectorList should map list correctly', () {
      final dtoFence = FenceDto(id: '1', name: 'Fence 1', perimeters: []);
      final result = FenceMapper.fromDtoToEntityCollectorList([dtoFence]);

      expect(result, isNotNull);
      expect(result!.length, 1);
      expect(result.first.id, '1');
      expect(result.first.name, 'Fence 1');
    });

    test('fromDtoToEntityCollector should return null when input is null', () {
      final result = FenceMapper.fromDtoToEntityCollector(null);
      expect(result, isNull);
    });

    test('fromDtoToEntityCollector should map correctly', () {
      final dtoFence = FenceDto(id: '1', name: 'Fence 1', perimeters: []);
      final result = FenceMapper.fromDtoToEntityCollector(dtoFence);

      expect(result, isNotNull);
      expect(result!.id, '1');
      expect(result.name, 'Fence 1');
    });

    test('fromEntityToDtoCollectorList should return null when input is null', () {
      final result = FenceMapper.fromEntityToDtoCollectorList(null);
      expect(result, isNull);
    });

    test('fromEntityToDtoCollectorList should map list correctly', () {
      const entityFence = Fence(id: '1', name: 'Fence 1', perimeters: []);
      final result = FenceMapper.fromEntityToDtoCollectorList([entityFence]);

      expect(result, isNotNull);
      expect(result!.length, 1);
      expect(result.first.id, '1');
      expect(result.first.name, 'Fence 1');
    });

    test('fromEntityToDtoCollector should return null when input is null', () {
      final result = FenceMapper.fromEntityToDtoCollector(null);
      expect(result, isNull);
    });

    test('fromEntityToDtoCollector should map correctly', () {
      const entityFence = Fence(id: '1', name: 'Fence 1', perimeters: []);
      final result = FenceMapper.fromEntityToDtoCollector(entityFence);

      expect(result, isNotNull);
      expect(result!.id, '1');
      expect(result.name, 'Fence 1');
    });

    test('fromAuthToCollectorDtoList should return null when input is null', () {
      final result = FenceMapper.fromAuthToCollectorDtoList(null);
      expect(result, isNull);
    });

    test('fromAuthToCollectorDtoList should map list correctly', () {
      final authFence = auth.FenceDTO(id: '1', name: 'Fence 1', perimeters: []);
      final result = FenceMapper.fromAuthToCollectorDtoList([authFence]);

      expect(result, isNotNull);
      expect(result!.length, 1);
      expect(result.first.id, '1');
      expect(result.first.name, 'Fence 1');
    });

    test('fromAuthToCollectorDto should return null when input is null', () {
      final result = FenceMapper.fromAuthToCollectorDto(null);
      expect(result, isNull);
    });

    test('fromAuthToCollectorDto should map correctly', () {
      final authFence = auth.FenceDTO(id: '1', name: 'Fence 1', perimeters: []);
      final result = FenceMapper.fromAuthToCollectorDto(authFence);

      expect(result, isNotNull);
      expect(result!.id, '1');
      expect(result.name, 'Fence 1');
    });

    test('fromClockToCollectorEntityList should return null when input is null', () {
      final result = FenceMapper.fromClockToCollectorEntityList(null);
      expect(result, isNull);
    });

    test('fromClockToCollectorEntityList should map list correctly', () {
      final clockFence = clock.FenceDto(id: '1', name: 'Fence 1', perimeters: []);
      final result = FenceMapper.fromClockToCollectorEntityList([clockFence]);

      expect(result, isNotNull);
      expect(result!.length, 1);
      expect(result.first.id, '1');
      expect(result.first.name, 'Fence 1');
    });

    test('fromClockToCollectorEntity should map correctly', () {
      final clockFence = clock.FenceDto(id: '1', name: 'Fence 1', perimeters: []);
      final result = FenceMapper.fromClockToCollectorEntity(clockFence);

      expect(result, isNotNull);
      expect(result!.id, '1');
      expect(result!.name, 'Fence 1');
    });
  });
}
