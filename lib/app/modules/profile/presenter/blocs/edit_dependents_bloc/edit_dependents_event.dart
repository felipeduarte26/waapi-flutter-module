part of 'edit_dependents_bloc.dart';

abstract class EditDependentsEvent extends Equatable {
  const EditDependentsEvent();
}

class SendEditDependentsEvent extends EditDependentsEvent {
  final DependentDtoInputModel dependentDtoInputModel;
  final String employeeId;

  const SendEditDependentsEvent({
    required this.dependentDtoInputModel,
    required this.employeeId,
  });

  @override
  List<Object> get props => [
        dependentDtoInputModel,
        employeeId,
      ];
}
