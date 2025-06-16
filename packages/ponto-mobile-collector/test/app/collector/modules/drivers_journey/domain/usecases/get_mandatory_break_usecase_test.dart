
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/clocking_event_origin.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/location_status.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/operation_mode_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/clocking_event_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/iutils.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/utils.dart';
import 'package:ponto_mobile_collector/app/collector/modules/drivers_journey/domain/usecases/get_mandatory_break_usecase.dart';

import '../../../../../../mocks/employee_dto_mock.dart';

class MockUtils extends Mock implements IUtils {}

void main() {
  late GetMandatoryBreakUsecase getMandatoryBreakUsecase;
  late IUtils mockUtils;

  ClockingEventDto clockingEventDto1 =
      ClockingEventDto(
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
    use: '22',
    timeZone: 'timeZone',
    photoNotCaptured: 'photo',
    geolocationIsMock: false,
    isSynchronized: true,
    facialRecognitionStatus: 'facialRecognitionStatus',
  );

  late ClockingEventDto clockingEventDto2 =
      ClockingEventDto(
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

  late List<ClockingEventDto> clockingEvents = [
    clockingEventDto1,
    clockingEventDto2,
  ];

  setUp(() {
    mockUtils = Utils();
    getMandatoryBreakUsecase = GetMandatoryBreakUsecaseImpl(utils: mockUtils);
  });

  test('should return mandatory break time as DateTime', () async {
    final expectedDateTime = DateTime(0, 0, 0, 1, 30);

    final result =
        await getMandatoryBreakUsecase.call(clockingEvents: clockingEvents);

    expect(result, expectedDateTime);
  });

  test('should return DateTime(0) on exception', () async {
    final clockingEvents = [clockingEventDto1, clockingEventDto2];
    IUtils mockUtils1 = MockUtils();
    when(() => mockUtils1.isEven(0)).thenThrow(Exception());

    getMandatoryBreakUsecase = GetMandatoryBreakUsecaseImpl(utils: mockUtils1);

    final result =
        await getMandatoryBreakUsecase.call(clockingEvents: clockingEvents);

    expect(result, DateTime(0));
  });
}
