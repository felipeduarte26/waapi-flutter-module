import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/clocking_event_origin.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/clocking_event_dto.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

import '../../../../mocks/employee_dto_mock.dart';
import '../../../../mocks/employee_entity_mock.dart';
import '../../../../mocks/overnight_entity_mock.dart';


class MockIEmployeeRepository extends Mock implements IEmployeeRepository {}
void main() {
  late IEmployeeRepository employeeRepository;

  setUp(
    () {
      employeeRepository = MockIEmployeeRepository();
    },
  );

  test(
    'DayInfoService Test generated days info.',
    () async {
      DateFormat formatter = DateFormat('yyyy-MM-dd');
      DateTime today = DateTime.now();
      DateTime initialDate = DateTime.parse('${formatter.format(today)} 01:00');
      DateTime finalDate = DateTime.parse('${formatter.format(today)} 23:00');

      DayInfoService service = DayInfoService(employeeRepository: employeeRepository);

      List<DayInfoModel> daysInfoList = await  service.generate(
        clockingEvents: [],
        initialDate: initialDate,
        finalDate: finalDate,
      );

      expect(daysInfoList.length, 1);
      expect(daysInfoList.first.isOdd, false);
      expect(daysInfoList.first.isRemoteness, false);
      expect(daysInfoList.first.isSynchronized, true);
      expect(daysInfoList.first.day.year, today.year);
      expect(daysInfoList.first.day.month, today.month);
      expect(daysInfoList.first.day.day, today.day);
      expect(daysInfoList.first.times.length, 0);

      ClockingEventDto clockingEvent1 = ClockingEventDto(
        clockingEventId: 'cf07036a-9caf-4f0c-8a66-d2d88d927e9e',
        dateEvent: formatter.format(today),
        timeEvent: '10:30',
        timeZone: '-0300',
        companyIdentifier: 'cnpj',
        cpf: 'cpf',
        appVersion: 'appVersion',
        platform: 'platform',
        employeeDto: employeeMockDto,
        use: '1',
        signature: 'signature',
        signatureVersion: 2,
        origin: ClockingEventOriginEnum.mobile,
        journeyId: 'journeyId',
        isMealBreak: false,
      );
      when(() => employeeRepository.findById(id: any(named: 'id'))).thenAnswer((_) async => employeeEntityMock);

      daysInfoList = await service.generate(
        clockingEvents: [clockingEvent1],
        initialDate: initialDate,
        finalDate: finalDate,
        journeyId: 'journeyId',
        overnights: [overnightEntityMock],
      );

      expect(daysInfoList.length, 1);
      expect(daysInfoList.first.isOdd, true);
      expect(daysInfoList.first.isRemoteness, false);
      expect(daysInfoList.first.isSynchronized, false);
      expect(daysInfoList.first.isOvernight, true);
      expect(daysInfoList.first.day.year, today.year);
      expect(daysInfoList.first.day.month, today.month);
      expect(daysInfoList.first.day.day, today.day);
      expect(daysInfoList.first.times.length, 1);
      expect(daysInfoList.first.times.first.isBold, true);
      expect(daysInfoList.first.times.first.isManual, false);
      expect(daysInfoList.first.times.first.isPhoneOrigin, true);
      expect(daysInfoList.first.times.first.isPlatformOrigin, false);
      expect(daysInfoList.first.times.first.isRemoteness, false);
      expect(daysInfoList.first.times.first.isSynchronized, false);
      expect(daysInfoList.first.times.first.isMealBreak, false);
      expect(daysInfoList.first.times.first.dateTime.year, today.year);
      expect(daysInfoList.first.times.first.dateTime.month, today.month);
      expect(daysInfoList.first.times.first.dateTime.day, today.day);

      ClockingEventDto clockingEvent2 = ClockingEventDto(
        clockingEventId: 'cf07036a-9caf-4f0c-8a66-d2d88d927e9e',
        dateEvent: formatter.format(today),
        timeEvent: '14:30',
        timeZone: '-0300',
        companyIdentifier: 'cnpj',
        cpf: 'cpf',
        appVersion: 'appVersion',
        platform: 'platform',
        employeeDto: employeeMockDto,
        use: '1',
        signature: 'signature',
        signatureVersion: 2,
        origin: ClockingEventOriginEnum.mobile,
        isSynchronized: true,
        journeyId: 'journeyId',
        isMealBreak: false,
      );

      daysInfoList = await service.generate(
        clockingEvents: [clockingEvent1, clockingEvent2],
        initialDate: initialDate,
        finalDate: finalDate,
      );

      expect(daysInfoList.length, 1);
      expect(daysInfoList.first.isOdd, false);
      expect(daysInfoList.first.isRemoteness, false);
      expect(daysInfoList.first.isSynchronized, false);
      expect(daysInfoList.first.isOvernight, false);
      expect(daysInfoList.first.day.year, today.year);
      expect(daysInfoList.first.day.month, today.month);
      expect(daysInfoList.first.day.day, today.day);
      expect(daysInfoList.first.times.length, 2);
      expect(daysInfoList.first.times[1].isBold, false);
      expect(daysInfoList.first.times[1].isManual, false);
      expect(daysInfoList.first.times[1].isPhoneOrigin, true);
      expect(daysInfoList.first.times[1].isPlatformOrigin, false);
      expect(daysInfoList.first.times[1].isRemoteness, false);
      expect(daysInfoList.first.times[1].isSynchronized, true);
      expect(daysInfoList.first.times[1].isMealBreak, false);
      expect(daysInfoList.first.times[1].dateTime.year, today.year);
      expect(daysInfoList.first.times[1].dateTime.month, today.month);
      expect(daysInfoList.first.times[1].dateTime.day, today.day);
    },
  );
}
