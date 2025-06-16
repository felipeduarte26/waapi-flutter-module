
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/clocking_event_origin.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/location_status.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/operation_mode_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/clocking_event_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/iutils.dart';
import 'package:ponto_mobile_collector/app/collector/modules/drivers_journey/domain/functions/calculate_total_time_clocking_event_pair_function.dart';
import 'package:ponto_mobile_collector/app/collector/modules/drivers_journey/domain/usecases/get_waiting_time_usecase.dart';

import '../../../../../../mocks/employee_dto_mock.dart';

class MockUtils extends Mock implements IUtils {}

void main() {
  late GetWaitingTimeUsecaseImpl getWaitingTimeUsecase;
  late MockUtils mockUtils;
  late ClockingEventDto clockingEventDto1;
  late ClockingEventDto clockingEventDto2;
  late List<ClockingEventDto> clockingEvents;

  setUp(() {
    mockUtils = MockUtils();
    getWaitingTimeUsecase = GetWaitingTimeUsecaseImpl(utils: mockUtils);
  clockingEventDto1 = ClockingEventDto(
      appVersion: 'appVersion',
      clockingEventId: 'clockingEventId',
      companyIdentifier: 'cnpj',
      dateEvent: '2024-08-04',
      employeeDto: employeeMockDto,
      platform: 'platform',
      signature: 'signature',
      signatureVersion: 1,
      timeEvent: '19:00:00',
      appointmentImage: 'appointmentImage',
      clientOriginInfo: 'clientOriginInfo',
      cpf: 'cpf',
      fenceState: 'into',
      locationStatus: LocationStatusEnum.location,
      mode: OperationModeType.single,
      online: true,
      origin: ClockingEventOriginEnum.mobile,
      use: '21',
      timeZone: 'timeZone',
      photoNotCaptured: 'photo',
      facialRecognitionStatus: 'facialRecognitionStatus',
    );
    clockingEventDto2 = ClockingEventDto(
      appVersion: 'appVersion',
      clockingEventId: 'clockingEventId',
      companyIdentifier: 'cnpj',
      dateEvent: '2024-08-04',
       employeeDto: employeeMockDto,
      platform: 'platform',
      signature: 'signature',
      signatureVersion: 1,
      timeEvent: '19:00:00',
      appointmentImage: 'appointmentImage',
      clientOriginInfo: 'clientOriginInfo',
      cpf: 'cpf',
      fenceState: 'into',
      locationStatus: LocationStatusEnum.location,
      mode: OperationModeType.single,
      online: true,
      origin: ClockingEventOriginEnum.mobile,
      use: '21',
      timeZone: 'timeZone',
      photoNotCaptured: 'photo',
    );
    clockingEvents = [
      clockingEventDto1,
      clockingEventDto2,
    ];
  });
  test('should return correct waiting time', () async {
    when(
      () => calculateTotaltimeClockingEventPair(
        clockingEvents: clockingEvents,
        typeUse: 21,
        utils: mockUtils,
      ),
    ).thenReturn(DateTime(0, 0, 0, 1, 30));

    when(
      () => calculateTotalTimeInSeconds(
        typeClockingEventList: clockingEvents,
        utils: mockUtils,
      ),
    ).thenAnswer((_) => 5400);

    when(
      () => mockUtils.isEven(any()),
    ).thenAnswer((_) => false);

    when(
      () => mockUtils.calculateDifferenceInSeconds(any(), any()),
    ).thenAnswer((_) => 5400);
    when(
      () => mockUtils.convertDateTimeToSeconds(any()),
    ).thenAnswer((_) => 5400);

    final result = await getWaitingTimeUsecase.call(clockingEvents: clockingEvents);

    expect(result, DateTime(0, 0, 0, 1, 30));

    verify(
      () => calculateTotaltimeClockingEventPair(
        clockingEvents: clockingEvents,
        typeUse: 21,
        utils: mockUtils,
      ),
    ).called(1);
  });

  test('should return DateTime(0) on exception', () async {
    when(
      () => calculateTotaltimeClockingEventPair(
        clockingEvents: clockingEvents,
        typeUse: 21,
        utils: mockUtils,
      ),
    ).thenThrow(Exception('Test exception'));

    final result = await getWaitingTimeUsecase.call(clockingEvents: clockingEvents);

    expect(result, DateTime(0));

    verify(
      () => calculateTotaltimeClockingEventPair(
        clockingEvents: clockingEvents,
        typeUse: 21,
        utils: mockUtils,
      ),
    ).called(1);
  });
}
