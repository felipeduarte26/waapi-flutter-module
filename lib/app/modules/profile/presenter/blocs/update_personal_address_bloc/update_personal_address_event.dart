import 'package:equatable/equatable.dart';

import '../../../domain/input_models/edit_personal_address_input_model.dart';

abstract class UpdatePersonalAddressEvent extends Equatable {
  const UpdatePersonalAddressEvent();
}

class SendUpdatePersonalAddressEvent extends UpdatePersonalAddressEvent {
  final EditPersonalAddressInputModel editPersonalAddressInputModel;

  const SendUpdatePersonalAddressEvent({
    required this.editPersonalAddressInputModel,
  });

  @override
  List<Object?> get props {
    return [
      editPersonalAddressInputModel,
    ];
  }
}
