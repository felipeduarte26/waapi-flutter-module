import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart';

class OvernightEntity {
  final String id;
  final bool? synchronized;
  final DateTime date;
  final LocationDTO? geolocation;
  final String type;
  final EmployeeDto employee;
  final LocationStatusEnum locationStatus;

  OvernightEntity({
    required this.id,
    required this.date,
    this.geolocation,
    required this.type,
    required this.employee,
    required this.locationStatus,
    this.synchronized = false,
  });

  OvernightEntity copyWith({
    required bool synchronized,
    LocationDTO? geolocation,
  }) {
    return OvernightEntity(
      id: id,
      date: date,
      geolocation: geolocation,
      type: type,
      employee: employee,
      locationStatus: locationStatus,
      synchronized: synchronized,
    );
  }
}
