import '../../../../core/domain/enums/facial_recognition_status_enum.dart';
import '../../../../core/domain/input_model/clocking_event_register_type.dart';
import '../../../../core/domain/input_model/employee_dto.dart';
import 'state_location_entity.dart';
import 'state_photo_entity.dart';

class ClockingEventRegisterEntity {
  EmployeeDto? employeeDto;
  StatePhotoEntity? photo;
  StateLocationEntity? location;
  DateTime dateTime;
  ClockingEventRegisterType clockingEventRegisterType;
  bool successFacialRecognition;
  String? journeyId;
  String? journeyEventName;
  bool? isMealBreak;
  FacialRecognitionStatusEnum? facialRecognitionStatus;

  ClockingEventRegisterEntity({
    this.employeeDto,
    this.location,
    this.photo,
    required this.dateTime,
    required this.clockingEventRegisterType,
    this.successFacialRecognition = false,
    this.journeyId,
    this.journeyEventName,
    this.isMealBreak,
    this.facialRecognitionStatus,
  });
}
