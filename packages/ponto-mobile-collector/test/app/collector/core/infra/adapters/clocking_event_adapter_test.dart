import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/clocking_event.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/drift/collector_database.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/adapters/clocking_event_adapter.dart';

import '../../../../../mocks/employee_dto_mock.dart';

void main() {
  group('ClockingEventAdapter', () {
    test('fromDataTable should convert ClockingEventTableData to ClockingEvent',
        () {
      final clockingEvent = ClockingEvent(
        id: '123456789',        
        appVersion: '2.0',
        platform: 'android',
        employeeId: employeeDtoMock.id,
        mode: 'motora',
        online: true,
        origin: '12345',
        signatureVersion: 323,
        isSynchronized: false,
        companyIdentifier: '123456',
        companyName: 'Test Company',
        cpf: '123.456.789-00',
        dateEvent: '23-12-2020',
        employeeName: 'John Doe',
        signature: 'signature',
        timeEvent: '20:30:00',
        timeZone: 'UTC',
        use: '2',
        isMealBreak: true,
        journeyEventName: 'Journey Event',);

      final dataTable = ClockingEventTableData(
        clockingEventId: '123456789',
        dateTimeEvent: DateTime.now(),
        appVersion: '2.0',
        platform: 'android',
        geolocationIsMock: true,
        employeeId: employeeDtoMock.id,
        mode: 'motora',
        online: true,
        origin: '12345',
        signatureVersion: 323,
        isSynchronized: false,
        companyIdentifier: '123456',
        companyName: 'Test Company',
        cpf: '123.456.789-00',
        dateEvent: '23-12-2020',
        employeeName: 'John Doe',
        signature: 'signature',
        timeEvent: '20:30:00',
        timeZone: 'UTC',
        use: 2,
        isMealBreak: true,
        journeyEventName: 'Journey Event',
      );

      var expectedClockingEvent = clockingEvent;

      final result = ClockingEventAdapter.fromDataTable(dataTable);

      expect(result.companyIdentifier, expectedClockingEvent.companyIdentifier);
      expect(result.companyName, expectedClockingEvent.companyName);
      expect(result.cpf, expectedClockingEvent.cpf);
      expect(result.dateEvent, expectedClockingEvent.dateEvent);
      expect(result.employeeName, expectedClockingEvent.employeeName);
      expect(result.signature, expectedClockingEvent.signature);
      expect(result.timeEvent, expectedClockingEvent.timeEvent);
      expect(result.timeZone, expectedClockingEvent.timeZone);
      expect(result.use, expectedClockingEvent.use);
      expect(result.isMealBreak, expectedClockingEvent.isMealBreak);
      expect(result.journeyEventName, expectedClockingEvent.journeyEventName);
    });
  });
}
