import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart' as clock;
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_authentication/mobile_authentication_service.dart' as auth;
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/platform_user.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/platform_user_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/mappers/platform_user_mapper.dart';

void main() {
  group('PlatformUserMapper', () {
    test('fromClockToCollectorDtoList should map clock list to collector DTO list', () {
      final clockList = [
        clock.PlatformUserEmployeeDto(id: '1', username: 'user1'),
        clock.PlatformUserEmployeeDto(id: '2', username: 'user2'),
      ];

      final result = PlatformUserMapper.fromClockToCollectorDtoList(clockList);

      expect(result, isNotNull);
      expect(result!.length, 2);
      expect(result[0].id, '1');
      expect(result[0].username, 'user1');
      expect(result[1].id, '2');
      expect(result[1].username, 'user2');
    });

    test('fromClockToCollectorDtoList should return null for null input', () {
      final result = PlatformUserMapper.fromClockToCollectorDtoList(null);
      expect(result, isNull);
    });

    test('fromClockToCollectorDto should map clock DTO to collector DTO', () {
      final clockDto = clock.PlatformUserEmployeeDto(id: '1', username: 'user1');

      final result = PlatformUserMapper.fromClockToCollectorDto(clockDto);

      expect(result, isNotNull);
      expect(result!.id, '1');
      expect(result.username, 'user1');
    });

    test('fromClockToCollectorDto should return null for null input', () {
      final result = PlatformUserMapper.fromClockToCollectorDto(null);
      expect(result, isNull);
    });

    test('fromCollectorDtoToClockList should map collector DTO list to clock list', () {
      final dtoList = [
        PlatformUserDto(id: '1', username: 'user1'),
        PlatformUserDto(id: '2', username: 'user2'),
      ];

      final result = PlatformUserMapper.fromCollectorDtoToClockList(dtoList);

      expect(result, isNotNull);
      expect(result!.length, 2);
      expect(result[0].id, '1');
      expect(result[0].username, 'user1');
      expect(result[1].id, '2');
      expect(result[1].username, 'user2');
    });

    test('fromCollectorDtoToClockList should return null for null input', () {
      final result = PlatformUserMapper.fromCollectorDtoToClockList(null);
      expect(result, isNull);
    });

    test('fromCollectorDtoToClock should map collector DTO to clock DTO', () {
      final dto = PlatformUserDto(id: '1', username: 'user1');

      final result = PlatformUserMapper.fromCollectorDtoToClock(dto);

      expect(result, isNotNull);
      expect(result!.id, '1');
      expect(result.username, 'user1');
    });

    test('fromCollectorDtoToClock should return null for null input', () {
      final result = PlatformUserMapper.fromCollectorDtoToClock(null);
      expect(result, isNull);
    });

    test('fromAuthToCollectorDtoList should map auth list to collector DTO list', () {
      final authList = [
        auth.PlatformUserEmployeeDTO(id: '1', username: 'user1'),
        auth.PlatformUserEmployeeDTO(id: '2', username: 'user2'),
      ];

      final result = PlatformUserMapper.fromAuthToCollectorDtoList(authList);

      expect(result, isNotNull);
      expect(result!.length, 2);
      expect(result[0].id, '1');
      expect(result[0].username, 'user1');
      expect(result[1].id, '2');
      expect(result[1].username, 'user2');
    });

    test('fromAuthToCollectorDtoList should return null for null input', () {
      final result = PlatformUserMapper.fromAuthToCollectorDtoList(null);
      expect(result, isNull);
    });

    test('fromAuthToCollectorDto should map auth DTO to collector DTO', () {
      final authDto = auth.PlatformUserEmployeeDTO(id: '1', username: 'user1');

      final result = PlatformUserMapper.fromAuthToCollectorDto(authDto);

      expect(result, isNotNull);
      expect(result!.id, '1');
      expect(result.username, 'user1');
    });

    test('fromAuthToCollectorDto should return null for null input', () {
      final result = PlatformUserMapper.fromAuthToCollectorDto(null);
      expect(result, isNull);
    });

    test('fromDtoToEntityCollectorList should map DTO list to entity list', () {
      final dtoList = [
        PlatformUserDto(id: '1', username: 'user1'),
        PlatformUserDto(id: '2', username: 'user2'),
      ];

      final result = PlatformUserMapper.fromDtoToEntityCollectorList(dtoList);

      expect(result, isNotNull);
      expect(result!.length, 2);
      expect(result[0].id, '1');
      expect(result[0].platformUserName, 'user1');
      expect(result[1].id, '2');
      expect(result[1].platformUserName, 'user2');
    });

    test('fromDtoToEntityCollectorList should return null for null input', () {
      final result = PlatformUserMapper.fromDtoToEntityCollectorList(null);
      expect(result, isNull);
    });

    test('fromDtoToEntityCollector should map DTO to entity', () {
      final dto = PlatformUserDto(id: '1', username: 'user1');

      final result = PlatformUserMapper.fromDtoToEntityCollector(dto);

      expect(result, isNotNull);
      expect(result!.id, '1');
      expect(result.platformUserName, 'user1');
    });

    test('fromDtoToEntityCollector should return null for null input', () {
      final result = PlatformUserMapper.fromDtoToEntityCollector(null);
      expect(result, isNull);
    });

    test('fromEntityToDtoCollectorList should map entity list to DTO list', () {
      final entityList = [
        const PlatformUser(id: '1', platformUserName: 'user1'),
        const PlatformUser(id: '2', platformUserName: 'user2'),
      ];

      final result = PlatformUserMapper.fromEntityToDtoCollectorList(entityList);

      expect(result, isNotNull);
      expect(result!.length, 2);
      expect(result[0].id, '1');
      expect(result[0].username, 'user1');
      expect(result[1].id, '2');
      expect(result[1].username, 'user2');
    });

    test('fromEntityToDtoCollectorList should return null for null input', () {
      final result = PlatformUserMapper.fromEntityToDtoCollectorList(null);
      expect(result, isNull);
    });

    test('fromEntityToDtoCollector should map entity to DTO', () {
      const entity =  PlatformUser(id: '1', platformUserName: 'user1');

      final result = PlatformUserMapper.fromEntityToDtoCollector(entity);

      expect(result, isNotNull);
      expect(result!.id, '1');
      expect(result.username, 'user1');
    });

    test('fromEntityToDtoCollector should return null for null input', () {
      final result = PlatformUserMapper.fromEntityToDtoCollector(null);
      expect(result, isNull);
    });

    test('fromClockToCollectorEntityList should map clock list to entity list', () {
      final clockList = [
        clock.PlatformUserEmployeeDto(id: '1', username: 'user1'),
        clock.PlatformUserEmployeeDto(id: '2', username: 'user2'),
      ];

      final result = PlatformUserMapper.fromClockToCollectorEntityList(clockList);

      expect(result, isNotNull);
      expect(result!.length, 2);
      expect(result[0].id, '1');
      expect(result[0].platformUserName, 'user1');
      expect(result[1].id, '2');
      expect(result[1].platformUserName, 'user2');
    });

    test('fromClockToCollectorEntityList should return null for null input', () {
      final result = PlatformUserMapper.fromClockToCollectorEntityList(null);
      expect(result, isNull);
    });

    test('fromClockToCollectorEntity should map clock DTO to entity', () {
      final clockDto = clock.PlatformUserEmployeeDto(id: '1', username: 'user1');

      final result = PlatformUserMapper.fromClockToCollectorEntity(clockDto);

      expect(result, isNotNull);
      expect(result!.id, '1');
      expect(result.platformUserName, 'user1');
    });

    test('fromClockToCollectorEntity should return null for null input', () {
      final result = PlatformUserMapper.fromClockToCollectorEntity(null);
      expect(result, isNull);
    });
  });
}
