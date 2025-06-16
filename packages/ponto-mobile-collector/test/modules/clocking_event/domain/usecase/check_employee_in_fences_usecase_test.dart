import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/employee_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/fence_dto.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/check_employee_in_fences_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/util/iclocking_event_utill.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

class MockSessionService extends Mock implements ISessionService {}

class MockCreateClockingEventService extends Mock
    implements clock.ICreateClockingEventService {}

class MockClockingEventUtil extends Mock implements IClockingEventUtil {}

class FakeEmployeeDto extends Fake implements EmployeeDto {
  @override
  List<FenceDto>? fences;

  FakeEmployeeDto({required this.fences});
}

class FakeFenceDto extends Fake implements clock.FenceDto {}

void main() {
  late ISessionService sessionService;
  late clock.ICreateClockingEventService createClockingEventService;
  late IClockingEventUtil clockingEventUtil;

  StateLocationEntity locationModel = StateLocationEntity(
    hasPermission: true,
    isServiceEnabled: true,
    success: true,
    isMock: true,
    latitude: 1.0,
    longitude: 2.0,
  );

  clock.LocationDTO? locationDto = clock.LocationDTO(
    dateAndTime: DateTime.now(),
    latitude: 2.0,
    longitude: 3.0,
  );

  List<FenceDto>? fences;
  List<clock.FenceDto>? fencesClock;

  setUp(
    () {
      sessionService = MockSessionService();
      createClockingEventService = MockCreateClockingEventService();
      clockingEventUtil = MockClockingEventUtil();

      when(
        () => clockingEventUtil.convertToLocationDto(location: locationModel),
      ).thenReturn(locationDto);
    },
  );

  group(
    'CheckEmployeeInFencesUsecase',
    () {
      test(
        'call null fences test.',
        () {
          ICheckEmployeeInFencesUsecase checkEmployeeInFencesUsecase =
              CheckEmployeeInFencesUsecase(
            sessionService: sessionService,
            createClockingEventService: createClockingEventService,
            clockingEventUtil: clockingEventUtil,
          );

          when(
            () => createClockingEventService.verifyFencesBounds(
              fences: fencesClock,
              geolocation: locationDto,
            ),
          ).thenReturn(null);

          when(
            () => sessionService.getEmployee(),
          ).thenReturn(FakeEmployeeDto(fences: fences));

          bool inFences =
              checkEmployeeInFencesUsecase.call(location: locationModel);

          expect(inFences, true);

          verify(
            () =>
                clockingEventUtil.convertToLocationDto(location: locationModel),
          ).called(1);

          verify(
            () => createClockingEventService.verifyFencesBounds(
              fences: fencesClock,
              geolocation: locationDto,
            ),
          ).called(1);

          verify(
            () => sessionService.getEmployee(),
          ).called(1);

          verifyNoMoreInteractions(sessionService);
          verifyNoMoreInteractions(createClockingEventService);
          verifyNoMoreInteractions(clockingEventUtil);
        },
      );

      test(
        'call with fences test.',
        () {
          ICheckEmployeeInFencesUsecase checkEmployeeInFencesUsecase =
              CheckEmployeeInFencesUsecase(
            sessionService: sessionService,
            createClockingEventService: createClockingEventService,
            clockingEventUtil: clockingEventUtil,
          );

          when(
            () => createClockingEventService.verifyFencesBounds(
              fences: fencesClock,
              geolocation: locationDto,
            ),
          ).thenReturn(clock.FenceStatusEnum.out);

          when(
            () => sessionService.getEmployee(),
          ).thenReturn(FakeEmployeeDto(fences: fences));

          bool inFences =
              checkEmployeeInFencesUsecase.call(location: locationModel);

          expect(inFences, false);

          verify(
            () =>
                clockingEventUtil.convertToLocationDto(location: locationModel),
          ).called(1);

          verify(
            () => createClockingEventService.verifyFencesBounds(
              fences: fencesClock,
              geolocation: locationDto,
            ),
          ).called(1);

          verify(
            () => sessionService.getEmployee(),
          ).called(1);

          verifyNoMoreInteractions(sessionService);
          verifyNoMoreInteractions(createClockingEventService);
          verifyNoMoreInteractions(clockingEventUtil);
        },
      );
    },
  );
}
