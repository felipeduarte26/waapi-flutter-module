import 'package:equatable/equatable.dart';

import 'attachments_input_model.dart';
import 'edit_personal_documents_dto_input_model.dart';

class EditPersonalDocumentsInputModel extends Equatable {
  final String type;
  final EditPersonalDocumentsDtoInputModel documents;
  final List<AttachmentsInputModel>? attachments;

  const EditPersonalDocumentsInputModel({
    required this.type,
    required this.documents,
    this.attachments,
  });

  @override
  List<Object?> get props {
    return [
      type,
      documents,
      attachments,
    ];
  }
}
