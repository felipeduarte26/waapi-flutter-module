import 'package:equatable/equatable.dart';

import 'attachments_input_model.dart';
import 'edit_dependents_input_model.dart';

class DependentDtoInputModel extends Equatable {
  final EditDependentsInputModel editDependentsInputModel;
  final String dependentId;
  final List<AttachmentsInputModel> attachmentsInputModel;
  final String requestType;
  final String commentary;

  const DependentDtoInputModel({
    required this.editDependentsInputModel,
    required this.dependentId,
    required this.attachmentsInputModel,
    required this.requestType,
    required this.commentary,
  });
  @override
  List<Object?> get props => [
        editDependentsInputModel,
        dependentId,
        attachmentsInputModel,
        requestType,
        commentary,
      ];
}
