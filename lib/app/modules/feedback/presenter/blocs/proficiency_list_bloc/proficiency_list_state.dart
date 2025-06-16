import 'package:equatable/equatable.dart';

import '../../../domain/entities/proficiency_feedback_entity.dart';

abstract class ProficiencyListState extends Equatable {
  final List<ProficiencyFeedbackEntity> proficiencyList;
  final ProficiencyFeedbackEntity? selectedProficiencyEntity;

  const ProficiencyListState({
    this.proficiencyList = const [],
    this.selectedProficiencyEntity,
  });

  ProficiencyListState initialProficiencyListState() {
    return InitialProficiencyListState(
      proficiencyEntity: selectedProficiencyEntity,
    );
  }

  ProficiencyListState loadingProficiencyListState() {
    return LoadingProficiencyListState(
      proficiencyEntity: selectedProficiencyEntity,
    );
  }

  ProficiencyListState emptyProficiencyListState() {
    return EmptyProficiencyListState(
      proficiencyEntity: selectedProficiencyEntity,
    );
  }

  ProficiencyListState loadedProficiencyListState({
    required List<ProficiencyFeedbackEntity> proficiencyList,
  }) {
    return LoadedProficiencyListState(
      proficiencyList: proficiencyList,
      proficiencyEntity: selectedProficiencyEntity,
    );
  }

  ProficiencyListState loadingSelectProficiencyState() {
    return LoadingSelectProficiencyState(
      proficiencyEntity: selectedProficiencyEntity,
    );
  }

  ProficiencyListState loadedSelectProficiencyState({
    required ProficiencyFeedbackEntity proficiencyEntity,
  }) {
    return LoadedSelectProficiencyState(
      proficiencyEntity: proficiencyEntity,
    );
  }

  ProficiencyListState errorProficiencyListState({
    String? message,
  }) {
    return ErrorProficiencyListState(
      message: message,
      proficiencyEntity: selectedProficiencyEntity,
    );
  }

  ProficiencyListState errorSelectProficiencyState({
    String? message,
    required String proficiencyId,
  }) {
    return ErrorSelectProficiencyState(
      message: message,
      proficiencyId: proficiencyId,
      proficiencyEntity: selectedProficiencyEntity,
    );
  }

  @override
  List<Object?> get props {
    return [
      proficiencyList,
      selectedProficiencyEntity,
    ];
  }
}

class InitialProficiencyListState extends ProficiencyListState {
  const InitialProficiencyListState({
    ProficiencyFeedbackEntity? proficiencyEntity,
  }) : super(
          proficiencyList: const [],
          selectedProficiencyEntity: proficiencyEntity,
        );
}

class LoadingProficiencyListState extends ProficiencyListState {
  const LoadingProficiencyListState({
    ProficiencyFeedbackEntity? proficiencyEntity,
  }) : super(
          proficiencyList: const [],
          selectedProficiencyEntity: proficiencyEntity,
        );
}

class EmptyProficiencyListState extends ProficiencyListState {
  const EmptyProficiencyListState({
    ProficiencyFeedbackEntity? proficiencyEntity,
  }) : super(
          proficiencyList: const [],
          selectedProficiencyEntity: proficiencyEntity,
        );
}

class LoadedProficiencyListState extends ProficiencyListState {
  const LoadedProficiencyListState({
    required List<ProficiencyFeedbackEntity> proficiencyList,
    ProficiencyFeedbackEntity? proficiencyEntity,
  }) : super(
          proficiencyList: proficiencyList,
          selectedProficiencyEntity: proficiencyEntity,
        );
}

class LoadingSelectProficiencyState extends ProficiencyListState {
  const LoadingSelectProficiencyState({
    ProficiencyFeedbackEntity? proficiencyEntity,
  }) : super(selectedProficiencyEntity: proficiencyEntity);
}

class LoadedSelectProficiencyState extends ProficiencyListState {
  const LoadedSelectProficiencyState({
    required ProficiencyFeedbackEntity proficiencyEntity,
  }) : super(selectedProficiencyEntity: proficiencyEntity);
}

class ErrorProficiencyListState extends ProficiencyListState {
  final String? message;

  const ErrorProficiencyListState({
    this.message,
    ProficiencyFeedbackEntity? proficiencyEntity,
  }) : super(selectedProficiencyEntity: proficiencyEntity);

  @override
  List<Object?> get props {
    return [
      ...super.props,
      message,
    ];
  }
}

class ErrorSelectProficiencyState extends ProficiencyListState {
  final String? message;
  final String proficiencyId;

  const ErrorSelectProficiencyState({
    this.message,
    required this.proficiencyId,
    ProficiencyFeedbackEntity? proficiencyEntity,
  }) : super(selectedProficiencyEntity: proficiencyEntity);

  @override
  List<Object?> get props {
    return [
      ...super.props,
      message,
      proficiencyId,
    ];
  }
}
