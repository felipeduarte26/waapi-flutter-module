import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/util/clocking_event_util.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';


void main() {
  group(
    'ClockingEventUtil',
    () {
      test(
        'convertToLocationDto test.',
        () {
          StateLocationEntity locationFail = StateLocationEntity(
            hasPermission: false,
            isMock: false,
            isServiceEnabled: false,
            success: false,
          );

          StateLocationEntity locationSuccess = StateLocationEntity(
            hasPermission: true,
            isMock: true,
            isServiceEnabled: true,
            success: true,
            latitude: 2.0,
            longitude: 5.0,
          );

          ClockingEventUtil util = ClockingEventUtil();

          clock.LocationDTO? locationFailDto =
              util.convertToLocationDto(location: locationFail);

          clock.LocationDTO? locationSuccessDto =
              util.convertToLocationDto(location: locationSuccess);
          expect(locationFailDto, null);

          expect(locationSuccessDto!.latitude, locationSuccess.latitude);
          expect(locationSuccessDto.longitude, locationSuccess.longitude);
        },
      );
    },
  );

  group('ClockingEventUtil', () {
    final clockingEventUtil = ClockingEventUtil();

   /* test(
        'convertToClockingEvent should convert ImportClockingEventDto to ClockingEvent',
        () {
      final companyDtoMock = CompanyDto(
        name: 'Test Company',
        id: '234',
        identifier: '123456',
        timeZone: 'UTC',
      );

      final clockingEventDto = ImportClockingEventDto(
        appVersion: '2.0',
        platform: 'android',
        geolocationIsMock: true,
        employeeId: '12345',
        clockingEventId: '23456',
        signatureVersion: 31,
        companyIdentifier: '123456',
        cpf: '123.456.789-00',
        dateEvent: '23-10-2020',
        signature: 'signature',
        employeeDto: employeeDtoMock,
        timeEvent: '23-10-2020',
        companyDto: companyDtoMock,
        timeZone: 'UTC',
        use: 2,
      );

      var expectedClockingEvent = ClockingEvent(
        companyIdentifier: '123456',
        companyName: 'Test Company',
        cpf: '123.456.789-00',
        dateEvent: '23-10-2020',
        employeeName: 'name',
        signature: 'signature',
        timeEvent: '23-10-2020',
        timeZone: 'UTC',
        use: '2',
        isMealBreak: true,
        journeyEventName: 'Journey Event',
        id: '123',
        employeeId: '1234',
        signatureVersion: 2,
      );

      // Act
      final result = clockingEventUtil.convertToClockingEvent(clockingEventDto);

      // Assert
      expect(result.companyIdentifier, expectedClockingEvent.companyIdentifier);
      expect(result.companyName, expectedClockingEvent.companyName);
      expect(result.cpf, expectedClockingEvent.cpf);
      expect(result.dateEvent, expectedClockingEvent.dateEvent);
      expect(result.employeeName, expectedClockingEvent.employeeName);
      expect(result.signature, expectedClockingEvent.signature);
      expect(result.timeEvent, expectedClockingEvent.timeEvent);
      expect(result.timeZone, expectedClockingEvent.timeZone);
      expect(result.use, expectedClockingEvent.use);
      expect(result.location, expectedClockingEvent.location);
      expect(result.locationStatus, expectedClockingEvent.locationStatus);
    });*/

    test(
        'getDateTimes should return list of DateTime from list of ClockingEvent',
        () {
      String dateEvent = '2023-10-01';
      String timeEvent = '20:30:00.000';
      // Arrange
      final clockingEvents = [
        ClockingEvent(
          companyIdentifier: '123456',
          companyName: 'Test Company',
          cpf: '123.456.789-00',
          dateEvent: '2023-10-01',
          employeeName: 'John Doe',
          signature: 'signature',
          timeEvent: '20:30',
          timeZone: 'UTC',
          use: '2',
          isMealBreak: true,
          journeyEventName: 'Journey Event',
          id: '123',
          employeeId: '3456',
          signatureVersion: 3,
        ),
        ClockingEvent(
          companyIdentifier: '123456',
          companyName: 'Test Company',
          cpf: '123.456.789-00',
          dateEvent: '2023-10-01',
          employeeName: 'John Doe',
          signature: 'signature',
          timeEvent: '20:30',
          timeZone: 'UTC',
          use: '2',
          isMealBreak: true,
          journeyEventName: 'Journey Event',
          id: '123',
          employeeId: '3456',
          signatureVersion: 3,
        ),
      ];

      final expectedDateTimes = [
        DateTime.parse('$dateEvent ${timeEvent}Z'),
        DateTime.parse('$dateEvent ${timeEvent}Z'),
      ];

      // Act
      final result = clockingEventUtil.getDateTimes(clockingEvents);

      // Assert
      expect(result, expectedDateTimes);
    });
  });
}
