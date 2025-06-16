import 'package:equatable/equatable.dart';

import '../../../../domain/input_models/emergencial_contact_input_model.dart';

abstract class EmergencialContactsEvent extends Equatable {}

class SendEmergencialContactsEvent extends EmergencialContactsEvent {
  final EmergencialContactInputModel emergencialContactInputModel;

  SendEmergencialContactsEvent({
    required this.emergencialContactInputModel,
  });

  @override
  List<Object?> get props {
    return [
      emergencialContactInputModel,
    ];
  }
}

class SendUpdateEmergencialContactsEvent extends EmergencialContactsEvent {
  final String emergencialContactId;
  final EmergencialContactInputModel emergencialContactInputModel;

  SendUpdateEmergencialContactsEvent({
    required this.emergencialContactInputModel,
    required this.emergencialContactId,
  });

  @override
  List<Object?> get props {
    return [
      emergencialContactInputModel,
      emergencialContactId,
    ];
  }
}

class SendDeletionEmergencialContactEvent extends EmergencialContactsEvent {
  final String idEmergencialContact;

  SendDeletionEmergencialContactEvent({
    required this.idEmergencialContact,
  });

  @override
  List<Object?> get props {
    return [
      idEmergencialContact,
    ];
  }
}
