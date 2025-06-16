
import '../../../../../core/domain/input_model/clocking_event_register_type.dart';
import '../../../domain/entities/state_location_entity.dart';

abstract class RegisterClockingEventEvent {}

class NewRegisterEvent extends RegisterClockingEventEvent {
  final ClockingEventRegisterType clockingEventRegisterType;
  StateLocationEntity? stateLocationEntity;

  NewRegisterEvent({required this.clockingEventRegisterType, this.stateLocationEntity});
}
