import 'package:equatable/equatable.dart';

import '../../../domain/entities/dependent_entity.dart';

abstract class DependentState extends Equatable {
  final List<DependentEntity> dependents;
  final DependentEntity? dependentEntity;

  const DependentState({
    this.dependents = const [],
    this.dependentEntity,
  });

  LoadingDependentState loadingDependentState() {
    return LoadingDependentState(
      dependentEntity: dependentEntity,
    );
  }

  LoadedDependentState loadedDependentState({
    required List<DependentEntity> dependents,
  }) {
    return LoadedDependentState(
      dependents: dependents,
    );
  }

  DependentState emptyStateDependentState() {
    return const EmptyStateDependentState();
  }

  ErrorDependentState errorDependentState({
    String? message,
  }) {
    return ErrorDependentState(
      message: message,
      dependentEntity: dependentEntity,
    );
  }

  @override
  List<Object?> get props {
    return [
      dependentEntity,
    ];
  }
}

class InitialDependentState extends DependentState {
  const InitialDependentState({
    DependentEntity? dependentEntity,
  }) : super(dependentEntity: dependentEntity);
}

class LoadingDependentState extends DependentState {
  const LoadingDependentState({
    DependentEntity? dependentEntity,
  }) : super(dependentEntity: dependentEntity);
}

class LoadedDependentState extends DependentState {
  const LoadedDependentState({
    required List<DependentEntity> dependents,
  }) : super(dependents: dependents);
}

class ErrorDependentState extends DependentState {
  final String? message;

  const ErrorDependentState({
    required this.message,
    DependentEntity? dependentEntity,
  }) : super(dependentEntity: dependentEntity);

  @override
  List<Object?> get props {
    return [
      ...super.props,
      message,
    ];
  }
}

class ErrorUpdateDependentState extends DependentState {
  const ErrorUpdateDependentState({
    DependentEntity? dependentEntity,
  }) : super(dependentEntity: dependentEntity);
}

class EmptyStateDependentState extends DependentState {
  const EmptyStateDependentState({
    DependentEntity? dependentEntity,
  }) : super(
          dependents: const [],
          dependentEntity: dependentEntity,
        );
}
