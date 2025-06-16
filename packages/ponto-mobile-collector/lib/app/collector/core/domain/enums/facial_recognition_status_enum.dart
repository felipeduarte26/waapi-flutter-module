
import 'package:json_annotation/json_annotation.dart';

enum FacialRecognitionStatusEnum {
  @JsonValue('RECOGNIZED')
  successfullyRecognized(
    'RECOGNIZED',
    'Recognized',
  ),

  @JsonValue('NOT_SYNCED')
  notSynced(
    'NOT_SYNCED',
    'Not synced',
  ),

  @JsonValue('NO_CAMERA_PERMISSION')
  noCameraPermission(
    'NO_CAMERA_PERMISSION',
    'No camera permission',
  ),

  @JsonValue('CANCELLED')
  cancelled(
    'CANCELLED',
    'Cancelled',
  ),

  @JsonValue('NO_FACE_REGISTERED')
  noFaceRegistered(
    'NO_FACE_REGISTERED',
    'No face registered',
  ),

  @JsonValue('INTERNAL_EXCEPTION')
  internalException(
    'INTERNAL_EXCEPTION',
    'Internal exception',
  ),

  @JsonValue('INITIALIZATION_RUNNING')
  initializationRunning(
    'INITIALIZATION_RUNNING',
    'Initialization Running',
  ),
  ;

  final String id;
  final String value;

  const FacialRecognitionStatusEnum(
    this.id,
    this.value,
  );

  static FacialRecognitionStatusEnum build(String id) {
    switch (id) {
      case 'RECOGNIZED':
        return FacialRecognitionStatusEnum.successfullyRecognized;
      case 'NOT_SYNCED':
        return FacialRecognitionStatusEnum.notSynced;
      case 'NO_CAMERA_PERMISSION':
        return FacialRecognitionStatusEnum.noCameraPermission;
      case 'CANCELLED':
        return FacialRecognitionStatusEnum.cancelled;
      case 'NO_FACE_REGISTERED':
        return FacialRecognitionStatusEnum.noFaceRegistered;
      case 'INTERNAL_EXCEPTION':
        return FacialRecognitionStatusEnum.internalException;
      case 'INITIALIZATION_RUNNING':
        return FacialRecognitionStatusEnum.initializationRunning;

      default:
        return FacialRecognitionStatusEnum.internalException;
    }
  }
}
