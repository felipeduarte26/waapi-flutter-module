import 'package:equatable/equatable.dart';

import 'attachments_input_model.dart';
import 'edit_personal_data_personal_dto_input_model.dart';

class EditPersonalDataInputModel extends Equatable {
  final String type;
  final String commentary;
  final EditPersonalDataPersonalDtoInputModel personalDTO;
  final List<AttachmentsInputModel>? attachments;

  const EditPersonalDataInputModel({
    required this.type,
    required this.commentary,
    required this.personalDTO,
    this.attachments,
  });

  @override
  List<Object?> get props {
    return [
      type,
      commentary,
      personalDTO,
      attachments,
    ];
  }
}
