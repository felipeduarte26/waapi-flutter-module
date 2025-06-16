import 'package:equatable/equatable.dart';

import '../../../domain/input_models/edit_personal_data_input_model.dart';

abstract class UpdatePersonalDataEvent extends Equatable {
  const UpdatePersonalDataEvent();
}

class SendUpdatePersonalDataEvent extends UpdatePersonalDataEvent {
  final EditPersonalDataInputModel editPersonalDataInputModel;

  const SendUpdatePersonalDataEvent({
    required this.editPersonalDataInputModel,
  });

  @override
  List<Object?> get props {
    return [
      editPersonalDataInputModel,
    ];
  }
}
