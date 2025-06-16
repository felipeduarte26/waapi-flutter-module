
import '../../exception/clocking_event_exception.dart';

enum GeometricFormType {
  circle('CIRCLE');

  final String value;

  const GeometricFormType(this.value);

  static GeometricFormType build(String value) {
    if (value == GeometricFormType.circle.value) {
      return GeometricFormType.circle;
    }

    throw ClockingEventException('GeometricFormType not found');
  }
}
