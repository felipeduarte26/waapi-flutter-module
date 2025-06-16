import 'package:equatable/equatable.dart';

import 'attachments_input_model.dart';
import 'edit_personal_contact_dto_input_model.dart';

class EditPersonalContactInputModel extends Equatable {
  final String? id;
  final String type;
  final String commentary;
  final EditPersonalContactDtoInputModel contactDTO;
  final List<AttachmentsInputModel>? attachments;

  const EditPersonalContactInputModel({
    this.id,
    required this.type,
    required this.commentary,
    required this.contactDTO,
    this.attachments,
  });

  @override
  List<Object?> get props {
    return [
      id,
      type,
      commentary,
      contactDTO,
      attachments,
    ];
  }
}
