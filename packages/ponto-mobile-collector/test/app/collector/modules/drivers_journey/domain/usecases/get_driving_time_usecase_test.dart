import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/clocking_event_origin.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/location_status.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/operation_mode_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/clocking_event_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/iutils.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/utils.dart';
import 'package:ponto_mobile_collector/app/collector/modules/drivers_journey/domain/usecases/get_driving_time_usecase.dart';

import '../../../../../../mocks/employee_dto_mock.dart';

class MockUtils extends Mock implements IUtils {}

void main() {
  late GetDrivingTimeUsecase getDrivingTimeUsecase;
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
    use: '23',
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
    use: '23',
    timeZone: 'timeZone',
    photoNotCaptured: 'photo',
    geolocationIsMock: false,
    isSynchronized: true,
  );

  setUp(() {
    mockUtils = Utils();
    getDrivingTimeUsecase = GetDrivingTimeUsecaseImpl(utils: mockUtils);
  });

  group('GetDrivingTimeUsecaseImpl', () {
    test('should return DateTime(0) when clockingEvents is empty', () async {
      final result = await getDrivingTimeUsecase.call(clockingEvents: []);
      expect(result, DateTime(0));
    });

    test(
        'should return DateTime(0) when clockingEvents has less than 2 driving events',
        () async {
      final clockingEvents = [
        clockingEventDto1,
      ];

      final result =
          await getDrivingTimeUsecase.call(clockingEvents: clockingEvents);
      expect(result, DateTime(0));
    });

    test(
        'should return correct DateTime when clockingEvents has valid driving events',
        () async {
      final expectedDateTime = DateTime(0, 0, 0, 1, 30);
      final clockingEvents = [
        clockingEventDto1,
        clockingEventDto2,
      ];

      final result =
          await getDrivingTimeUsecase.call(clockingEvents: clockingEvents);

      expect(result, expectedDateTime);
    });

    test('should return DateTime(0) on exception', () async {
      final clockingEvents = [
        clockingEventDto1,
        clockingEventDto2,
      ];

      IUtils mockUtils1 = MockUtils();

      when(
        () => mockUtils1.isEven(any()),
      ).thenThrow(Exception());

      getDrivingTimeUsecase = GetDrivingTimeUsecaseImpl(utils: mockUtils1);

      final result =
          await getDrivingTimeUsecase.call(clockingEvents: clockingEvents);

      expect(result, DateTime(0));
    });
  });
}
