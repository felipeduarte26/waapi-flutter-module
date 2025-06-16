
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/clocking_event_origin.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/location_status.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/operation_mode_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/clocking_event_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/iutils.dart';
import 'package:ponto_mobile_collector/app/collector/modules/drivers_journey/domain/usecases/get_mandatory_break_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/drivers_journey/domain/usecases/get_meal_time_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/drivers_journey/domain/usecases/get_total_hours_in_journey_usecase.dart';

import '../../../../../../mocks/employee_dto_mock.dart';

class MockUtils extends Mock implements IUtils {}

class MockGetMandatoryBreakUsecase extends Mock
    implements GetMandatoryBreakUsecase {}

class MockGetMealTimeUsecase extends Mock implements GetMealTimeUsecase {}

void main() {
  late GetTotalHoursInJourneyUsecase getTotalHoursInJourneyUsecase;
  late GetMandatoryBreakUsecase getMandatoryBreakUsecase;
  late IUtils mockUtils;
  late ClockingEventDto clockingEventDto1;
  late ClockingEventDto clockingEventDto2;
  late ClockingEventDto clockingEventDto22;
  late ClockingEventDto clockingEventDto3;
  late ClockingEventDto clockingEventDto4;
  late ClockingEventDto clockingEventDto23;
  late List<ClockingEventDto> clockingEvents;
  late GetMealTimeUsecase getMealTimeUsecase;

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
      use: '2',
      timeZone: 'timeZone',
      photoNotCaptured: 'photo',
      geolocationIsMock: false,
      isSynchronized: true,
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
      timeEvent: '20:30:00',
      appointmentImage: 'appointmentImage',
      clientOriginInfo: 'clientOriginInfo',
      cpf: 'cpf',
      fenceState: 'into',
      locationStatus: LocationStatusEnum.location,
      mode: OperationModeType.single,
      online: true,
      origin: ClockingEventOriginEnum.mobile,
      use: '2',
      timeZone: 'timeZone',
      photoNotCaptured: 'photo',
      geolocationIsMock: false,
      isSynchronized: true,
    );

    clockingEventDto3 = ClockingEventDto(
      appVersion: 'appVersion',
      clockingEventId: 'clockingEventId',
      companyIdentifier: 'cnpj',
      dateEvent: '2024-08-04',
      employeeDto: employeeMockDto,
      platform: 'platform',
      signature: 'signature',
      signatureVersion: 1,
      timeEvent: '20:30:00',
      appointmentImage: 'appointmentImage',
      clientOriginInfo: 'clientOriginInfo',
      cpf: 'cpf',
      fenceState: 'into',
      locationStatus: LocationStatusEnum.location,
      mode: OperationModeType.single,
      online: true,
      origin: ClockingEventOriginEnum.mobile,
      use: '2',
      timeZone: 'timeZone',
      photoNotCaptured: 'photo',
      geolocationIsMock: false,
      isSynchronized: true,
    );

     clockingEventDto4 = ClockingEventDto(
      appVersion: 'appVersion',
      clockingEventId: 'clockingEventId',
      companyIdentifier: 'cnpj',
      dateEvent: '2024-08-04',
      employeeDto: employeeMockDto,
      platform: 'platform',
      signature: 'signature',
      signatureVersion: 1,
      timeEvent: '20:30:00',
      appointmentImage: 'appointmentImage',
      clientOriginInfo: 'clientOriginInfo',
      cpf: 'cpf',
      fenceState: 'into',
      locationStatus: LocationStatusEnum.location,
      mode: OperationModeType.single,
      online: true,
      origin: ClockingEventOriginEnum.mobile,
      use: '2',
      timeZone: 'timeZone',
      photoNotCaptured: 'photo',
      geolocationIsMock: false,
      isSynchronized: true,
    );

     clockingEventDto22 = ClockingEventDto(
      appVersion: 'appVersion',
      clockingEventId: 'clockingEventId',
      companyIdentifier: 'cnpj',
      dateEvent: '2024-08-04',
      employeeDto: employeeMockDto,
      platform: 'platform',
      signature: 'signature',
      signatureVersion: 1,
      timeEvent: '20:30:00',
      appointmentImage: 'appointmentImage',
      clientOriginInfo: 'clientOriginInfo',
      cpf: 'cpf',
      fenceState: 'into',
      locationStatus: LocationStatusEnum.location,
      mode: OperationModeType.single,
      online: true,
      origin: ClockingEventOriginEnum.mobile,
      use: '22',
      timeZone: 'timeZone',
      photoNotCaptured: 'photo',
      geolocationIsMock: false,
      isSynchronized: true,
    );
   clockingEventDto23 = ClockingEventDto(
      appVersion: 'appVersion',
      clockingEventId: 'clockingEventId',
      companyIdentifier: 'cnpj',
      dateEvent: '2024-08-04',
      employeeDto: employeeMockDto,
      platform: 'platform',
      signature: 'signature',
      signatureVersion: 1,
      timeEvent: '20:30:00',
      appointmentImage: 'appointmentImage',
      clientOriginInfo: 'clientOriginInfo',
      cpf: 'cpf',
      fenceState: 'into',
      locationStatus: LocationStatusEnum.location,
      mode: OperationModeType.single,
      online: true,
      origin: ClockingEventOriginEnum.mobile,
      use: '23',
      timeZone: 'timeZone',
      photoNotCaptured: 'photo',
      geolocationIsMock: false,
      isSynchronized: true,
    );

  clockingEvents = [
    clockingEventDto1,
    clockingEventDto2,
    clockingEventDto22,
    clockingEventDto3,
    clockingEventDto4,
  ];

  setUp(() {
    mockUtils = MockUtils();
    getMandatoryBreakUsecase = MockGetMandatoryBreakUsecase();
    getMealTimeUsecase = MockGetMealTimeUsecase();

    getTotalHoursInJourneyUsecase = GetTotalHoursInJourneyUsecaseImpl(
      utils: mockUtils,
      getMealTimeUsecase: getMealTimeUsecase,
      getMandatoryBreakUsecase: getMandatoryBreakUsecase,
    );
  });

  test('should return correct total hours in journey', () async {
    when(() => mockUtils.calculateDifferenceInSeconds(any(), any()))
        .thenReturn(14400);

    when(() => mockUtils.isEven(any())).thenAnswer((invocation) {
      final index = invocation.positionalArguments[0] as int;
      return index % 2 == 0;
    });

    when(() => (mockUtils.convertDateTimeToSeconds(any()))).thenReturn(1800);

    when(
      () => getMandatoryBreakUsecase.call(
        clockingEvents: clockingEvents,
      ),
    ).thenAnswer((_) => Future.value(DateTime(0, 0, 0, 0, 30)));
    when(
      () => getMealTimeUsecase.call(
        clockingEvents: clockingEvents,
      ),
    ).thenAnswer((_) => Future.value(DateTime(0, 0, 0, 0, 30)));

    final result = await getTotalHoursInJourneyUsecase.call(
      clockingEvents: clockingEvents,
    );

    expect(result, DateTime(0, 0, 0, 11, 00));

    verify(() => mockUtils.calculateDifferenceInSeconds(any(), any()))
        .called(greaterThan(0));
    verify(() => mockUtils.isEven(any())).called(greaterThan(0));
    verify(() => mockUtils.convertDateTimeToSeconds(any())).called(2);

    verify(
      () => getMealTimeUsecase.call(
        clockingEvents: clockingEvents,
      ),
    ).called(1);
    verify(
      () => getMandatoryBreakUsecase.call(
        clockingEvents: clockingEvents,
      ),
    ).called(1);
  });

  test('should return DateTime(0) on exception', () async {
    final clockingEvents = [
      clockingEventDto1,
      clockingEventDto2,
    ];

    when(() => mockUtils.calculateDifferenceInSeconds(any(), any()))
        .thenThrow(Exception('Test exception'));

    final result = await getTotalHoursInJourneyUsecase.call(
      clockingEvents: clockingEvents,
    );

    expect(result, DateTime(0));

    verify(() => mockUtils.calculateDifferenceInSeconds(any(), any()));
  });

  test(
      'should calculate working time correctly when appointmentsTypePoint length is odd',
      () async {
    final clockingEvents = [
      clockingEventDto1,
      clockingEventDto22,
      clockingEventDto2,
      clockingEventDto23,
    ];

    final appointmentsTypePoint = [
      clockingEventDto1,
      clockingEventDto2,
    ];

    when(() => mockUtils.isEven(appointmentsTypePoint.length))
        .thenReturn(false);
    when(() => mockUtils.calculateDifferenceInSeconds(any(), any()))
        .thenReturn(3600);

    final result = await getTotalHoursInJourneyUsecase.call(
      clockingEvents: clockingEvents,
    );

    expect(result, DateTime(0, 1, 1, 0, 0, 0));
  });
}
