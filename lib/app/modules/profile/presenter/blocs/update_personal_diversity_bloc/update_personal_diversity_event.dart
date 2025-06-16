import 'package:equatable/equatable.dart';

import '../../../domain/input_models/edit_personal_diversity_input_model.dart';

abstract class UpdatePersonalDiversityEvent extends Equatable {
  const UpdatePersonalDiversityEvent();
}

class SendUpdatePersonalDiversityEvent extends UpdatePersonalDiversityEvent {
  final EditPersonalDiversityInputModel editPersonalDiversityInputModel;

  const SendUpdatePersonalDiversityEvent({
    required this.editPersonalDiversityInputModel,
  });

  @override
  List<Object?> get props {
    return [
      editPersonalDiversityInputModel,
    ];
  }
}
