import 'package:equatable/equatable.dart';

import 'attachments_input_model.dart';
import 'edit_personal_address_dto_input_model.dart';

class EditPersonalAddressInputModel extends Equatable {
  final String updateDate;
  final List<EditPersonalAddressDtoInputModel>? addresses;
  final List<AttachmentsInputModel>? attachments;

  const EditPersonalAddressInputModel({
    required this.updateDate,
    required this.addresses,
    this.attachments,
  });

  @override
  List<Object?> get props {
    return [
      updateDate,
      addresses,
      attachments,
    ];
  }
}
