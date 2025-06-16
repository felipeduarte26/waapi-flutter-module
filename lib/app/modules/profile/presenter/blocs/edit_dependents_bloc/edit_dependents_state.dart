part of 'edit_dependents_bloc.dart';

abstract class EditDependentsState extends Equatable {
  const EditDependentsState();

  @override
  List<Object?> get props => [];
}

class InitialEditDependents extends EditDependentsState {}

class LoadingEditDependents extends EditDependentsState {}

class SentEditDependents extends EditDependentsState {}

class ErrorEditDependents extends EditDependentsState {
  final String? errorMessage;

  const ErrorEditDependents({
    this.errorMessage,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      errorMessage,
    ];
  }
}
