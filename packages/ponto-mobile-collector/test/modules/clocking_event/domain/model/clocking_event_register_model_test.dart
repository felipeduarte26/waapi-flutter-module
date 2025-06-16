import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/clocking_event_register_type.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

import '../../../../mocks/employee_dto_mock.dart';

void main() {
  test(
    'ClockingEventRegisterModel test.',
    () {
      StatePhotoEntity photoEntity = StatePhotoEntity(
        hasPermission: true,
        success: true,
      );

      StateLocationEntity locationEntity = StateLocationEntity(
        hasPermission: true,
        isServiceEnabled: true,
        success: true,
        isMock: true,
      );

      ClockingEventRegisterEntity model = ClockingEventRegisterEntity(
        clockingEventRegisterType: ClockingEventRegisterTypeSession(),
        dateTime: DateTime(2024, 3, 5),
        employeeDto: employeeMockDto,
        successFacialRecognition: true,
        photo: photoEntity,
        location: locationEntity,
      );

      expect(
        model.clockingEventRegisterType,
        isA<ClockingEventRegisterTypeSession>(),
      );
      expect(model.dateTime, DateTime(2024, 3, 5));
      expect(model.employeeDto!.arpId, employeeDtoMock.arpId);
      expect(model.successFacialRecognition, true);
      expect(model.photo, photoEntity);
      expect(model.location, locationEntity);
    },
  );
}
