import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/clocking_event_origin.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/location_status.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/operation_mode_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/clocking_event_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/iutils.dart';
import 'package:ponto_mobile_collector/app/collector/modules/drivers_journey/domain/usecases/get_meal_time_usecase.dart';

import '../../../../../../mocks/employee_dto_mock.dart';

class MockUtils extends Mock implements IUtils {}

void main() {
  late GetMealTimeUsecaseImpl getMealTimeUsecase;
  late MockUtils mockUtils;
  late ClockingEventDto clockingEventDto1;
  late ClockingEventDto clockingEventDto2;
  late ClockingEventDto clockingEventDto3;
  late List<ClockingEventDto> clockingEvents;
  setUp(() {
    mockUtils = MockUtils();
    getMealTimeUsecase = GetMealTimeUsecaseImpl(utils: mockUtils);
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

    clockingEvents = [
      clockingEventDto1,
      clockingEventDto2,
      clockingEventDto3,
    ];
  });
  test(
      'should return correct meal time when utils.isPar returns true and false alternately',
      () async {
    when(() => mockUtils.isEven(any())).thenAnswer((invocation) {
      final index = invocation.positionalArguments[0] as int;
      return index % 2 == 0;
    });

    when(() => mockUtils.calculateDifferenceInSeconds(any(), any()))
        .thenReturn(5400);

    final result = await getMealTimeUsecase.call(clockingEvents: clockingEvents);

    expect(result, DateTime(0, 0, 0, 1, 30));

    verify(() => mockUtils.isEven(any())).called(3);
    verify(() => mockUtils.calculateDifferenceInSeconds(any(), any()))
        .called(1);
  });

  test('should return DateTime(0) on exception', () async {
    when(() => mockUtils.isEven(any())).thenThrow(Exception('test expetion'));

    final result = await getMealTimeUsecase.call(clockingEvents: clockingEvents);

    expect(result, DateTime(0));

    verify(() => mockUtils.isEven(any())).called(1);
  });
}
