import 'package:ponto_mobile_collector/app/collector/core/domain/enums/facial_recognition_status_enum.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/clocking_event_register_type.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/entities/clocking_event_register_entity.dart';

import 'employee_dto_mock.dart';
import 'state_location_entity_mock.dart';
import 'state_photo_entity_mock.dart';

ClockingEventRegisterEntity clockingEventRegisterEntityMock =
    ClockingEventRegisterEntity(
  clockingEventRegisterType: ClockingEventRegisterTypeSession(),
  dateTime: DateTime(2024, 03, 04),
  employeeDto: employeeMockDto,
  location: stateLocationEntityMock,
  photo: statePhotoEntityMock,
  successFacialRecognition: true,
  facialRecognitionStatus: FacialRecognitionStatusEnum.successfullyRecognized,
);
