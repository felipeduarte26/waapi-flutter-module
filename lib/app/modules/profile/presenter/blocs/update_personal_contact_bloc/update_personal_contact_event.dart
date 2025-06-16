import 'package:equatable/equatable.dart';

import '../../../domain/input_models/edit_personal_contact_input_model.dart';

abstract class UpdatePersonalContactEvent extends Equatable {
  const UpdatePersonalContactEvent();
}

class SendUpdatePersonalContactEvent extends UpdatePersonalContactEvent {
  final EditPersonalContactInputModel editPersonalContactInputModel;

  const SendUpdatePersonalContactEvent({
    required this.editPersonalContactInputModel,
  });

  @override
  List<Object?> get props {
    return [
      editPersonalContactInputModel,
    ];
  }
}
