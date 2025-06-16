import '../enums/developer_mode.dart';
import '../enums/gps_operation_mode.dart';
import '../enums/status_device.dart';

class Device {
  final String? id;
  final String identifier;
  final String? name;
  final String? model;
  final StatusDevice? status;
  final DeveloperModeEnum? developerMode;
  final GPSoperationModeEnum? gpsOperationMode;
  final bool? dateTimeAutomatic;
  final bool? timeZoneAutomatic;


  const Device({
    this.id,
    this.status,
    required this.identifier,
    this.name,
    this.model,
    this.developerMode,
    this.gpsOperationMode,
    this.dateTimeAutomatic,
    this.timeZoneAutomatic,
  });
}
