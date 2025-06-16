import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart' as clock;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/manager_employee_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/mappers/employee_mapper.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/mappers/manager_mapper.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/mappers/platform_user_mapper.dart';

class MockPlatformUserMapper extends Mock implements PlatformUserMapper {}

class MockEmployeeMapper extends Mock implements EmployeeMapper {}

void main() {
  group('ManagerMapper', () {
    test('fromClockToCollectorDtoList should return null when clockList is null', () {
      final result = ManagerMapper.fromClockToCollectorDtoList(null);
      expect(result, isNull);
    });

    test('fromClockToCollectorDtoList should map clockList to ManagerEmployeeDto list', () {
      final clockList = [
        clock.ManagerEmployeeDto(
          id: '1',
          platformUserName: 'user1',
          platformUsers: [],
        ),
        clock.ManagerEmployeeDto(
          id: '2',
          platformUserName: 'user2',
          platformUsers: [],
        ),
      ];

      final result = ManagerMapper.fromClockToCollectorDtoList(clockList);

      expect(result, isNotNull);
      expect(result!.length, equals(2));
      expect(result[0].id, equals('1'));
      expect(result[0].platformUserName, equals('user1'));
      expect(result[1].id, equals('2'));
      expect(result[1].platformUserName, equals('user2'));
    });

    test('fromClockToCollectorDto should return null when dto is null', () {
      final result = ManagerMapper.fromClockToCollectorDto(null);
      expect(result, isNull);
    });

    test('fromClockToCollectorDto should map clock.ManagerEmployeeDto to ManagerEmployeeDto', () {
      final clockDto = clock.ManagerEmployeeDto(
        id: '1',
        platformUserName: 'user1',
        platformUsers: [],
      );

      final result = ManagerMapper.fromClockToCollectorDto(clockDto);

      expect(result, isNotNull);
      expect(result!.id, equals('1'));
      expect(result.platformUserName, equals('user1'));
    });

    test('fromCollectorDtoToClockList should return null when dtoList is null', () {
      final result = ManagerMapper.fromCollectorDtoToClockList(null);
      expect(result, isNull);
    });

    test('fromCollectorDtoToClockList should map ManagerEmployeeDto list to clock.ManagerEmployeeDto list', () {
      final dtoList = [
        ManagerEmployeeDto(
          id: '1',
          platformUserName: 'user1',
          platformUsers: [],
        ),
        ManagerEmployeeDto(
          id: '2',
          platformUserName: 'user2',
          platformUsers: [],
        ),
      ];

      final result = ManagerMapper.fromCollectorDtoToClockList(dtoList);

      expect(result, isNotNull);
      expect(result!.length, equals(2));
      expect(result[0].id, equals('1'));
      expect(result[0].platformUserName, equals('user1'));
      expect(result[1].id, equals('2'));
      expect(result[1].platformUserName, equals('user2'));
    });

    test('fromCollectorDtoToClock should return null when dto is null', () {
      final result = ManagerMapper.fromCollectorDtoToClock(null);
      expect(result, isNull);
    });

    test('fromCollectorDtoToClock should map ManagerEmployeeDto to clock.ManagerEmployeeDto', () {
      final dto = ManagerEmployeeDto(
        id: '1',
        platformUserName: 'user1',
        platformUsers: [],
      );

      final result = ManagerMapper.fromCollectorDtoToClock(dto);

      expect(result, isNotNull);
      expect(result!.id, equals('1'));
      expect(result.platformUserName, equals('user1'));
    });
  });
}
