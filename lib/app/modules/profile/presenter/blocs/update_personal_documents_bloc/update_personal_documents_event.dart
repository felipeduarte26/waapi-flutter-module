import 'package:equatable/equatable.dart';

import '../../../domain/input_models/edit_personal_documents_input_model.dart';

abstract class UpdatePersonalDocumentsEvent extends Equatable {
  const UpdatePersonalDocumentsEvent();
}

class SendUpdatePersonalDocumentsEvent extends UpdatePersonalDocumentsEvent {
  final EditPersonalDocumentsInputModel editPersonalDocumentsInputModel;

  const SendUpdatePersonalDocumentsEvent({
    required this.editPersonalDocumentsInputModel,
  });

  @override
  List<Object?> get props {
    return [
      editPersonalDocumentsInputModel,
    ];
  }
}
