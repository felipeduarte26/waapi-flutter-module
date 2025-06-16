
import '../../exception/service_exception.dart';

enum DataOriginType {
  g5('G5'),
  manual('MANUAL');

  final String value;

  const DataOriginType(this.value);

  static DataOriginType build(String value) {
    if (value == DataOriginType.g5.value) {
      return DataOriginType.g5;
    }

    if (value == DataOriginType.manual.value) {
      return DataOriginType.manual;
    }

    throw ServiceException(message: 'DataOriginType not found');
  }
}
