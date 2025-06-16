import 'dart:io';

import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
    
abstract class IUploadPhotosService {
  /// Send to AWS S3 all photos from a specific directory
  Future<void> sendFromDirectory({required Directory directory, required String employeeId, required clock.OperationModeEnum operationMode});
}
