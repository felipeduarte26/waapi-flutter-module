
import 'package:json_annotation/json_annotation.dart';

import '../../exception/service_exception.dart';

enum OperationModeType {
  @JsonValue('MULTI')
  multi('MULTI'),

  @JsonValue('SINGLE')
  single('SINGLE'),

  @JsonValue('DRIVER')
  driver('DRIVER'),

  @JsonValue('NFC')
  nfc('NFC'),

  @JsonValue('BIOMETRIC')
  biometric('BIOMETRIC'),

  @JsonValue('QRCODE')
  qrCode('QRCODE'),

  @JsonValue('FACE_RECOGNITION')
  faceRecognition('FACE_RECOGNITION');

  final String value;

  const OperationModeType(this.value);

  static OperationModeType build(String value) {
    if (value == OperationModeType.biometric.value) {
      return OperationModeType.biometric;
    }

    if (value == OperationModeType.driver.value) {
      return OperationModeType.driver;
    }

    if (value == OperationModeType.multi.value) {
      return OperationModeType.multi;
    }

    if (value == OperationModeType.nfc.value) {
      return OperationModeType.nfc;
    }

    if (value == OperationModeType.qrCode.value) {
      return OperationModeType.qrCode;
    }

    if (value == OperationModeType.single.value) {
      return OperationModeType.single;
    }

    if (value == OperationModeType.faceRecognition.value) {
      return OperationModeType.faceRecognition;
    }

    throw ServiceException(message: 'OperationModeType not found');
  }
}
