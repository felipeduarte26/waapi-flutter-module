import 'package:equatable/equatable.dart';

import '../../../domain/entities/sexual_orientation_entity.dart';

abstract class SexualOrientationState extends Equatable {
  final List<SexualOrientationEntity> sexualOrientations;
  final SexualOrientationEntity? selectedSexualOrientationEntity;

  const SexualOrientationState({
    this.sexualOrientations = const [],
    this.selectedSexualOrientationEntity,
  });

  SexualOrientationState initialSexualOrientationState() {
    return InitialSexualOrientationState(
      sexualOrientationEntity: selectedSexualOrientationEntity,
    );
  }

  SexualOrientationState loadingSexualOrientationState() {
    return LoadingSexualOrientationState(
      sexualOrientationEntity: selectedSexualOrientationEntity,
    );
  }

  SexualOrientationState emptyStateSexualOrientationState() {
    return EmptyStateSexualOrientationState(
      sexualOrientationEntity: selectedSexualOrientationEntity,
    );
  }

  SexualOrientationState loadedSexualOrientationState({
    required List<SexualOrientationEntity> sexualOrientations,
  }) {
    return LoadedSexualOrientationState(
      sexualOrientations: sexualOrientations,
      sexualOrientationEntity: selectedSexualOrientationEntity,
    );
  }

  SexualOrientationState errorSexualOrientationState({
    String? message,
  }) {
    return ErrorSexualOrientationState(
      message: message,
      sexualOrientationEntity: selectedSexualOrientationEntity,
    );
  }

  SexualOrientationState loadedSelectSexualOrientationState({
    required SexualOrientationEntity sexualOrientationEntity,
  }) {
    return LoadedSelectSexualOrientationState(
      sexualOrientations: sexualOrientations,
      sexualOrientationEntity: sexualOrientationEntity,
    );
  }

  SexualOrientationState unselectSexualOrientationState({
    required SexualOrientationEntity sexualOrientationEntity,
  }) {
    return UnselectSexualOrientationState(
      sexualOrientations: sexualOrientations,
      sexualOrientationEntity: sexualOrientationEntity,
    );
  }

  @override
  List<Object?> get props {
    return [
      sexualOrientations,
      selectedSexualOrientationEntity,
    ];
  }
}

class InitialSexualOrientationState extends SexualOrientationState {
  const InitialSexualOrientationState({
    SexualOrientationEntity? sexualOrientationEntity,
  }) : super(
          sexualOrientations: const [],
          selectedSexualOrientationEntity: sexualOrientationEntity,
        );
}

class LoadingSexualOrientationState extends SexualOrientationState {
  const LoadingSexualOrientationState({
    SexualOrientationEntity? sexualOrientationEntity,
  }) : super(
          sexualOrientations: const [],
          selectedSexualOrientationEntity: sexualOrientationEntity,
        );
}

class EmptyStateSexualOrientationState extends SexualOrientationState {
  const EmptyStateSexualOrientationState({
    SexualOrientationEntity? sexualOrientationEntity,
  }) : super(
          sexualOrientations: const [],
          selectedSexualOrientationEntity: sexualOrientationEntity,
        );
}

class LoadedSexualOrientationState extends SexualOrientationState {
  const LoadedSexualOrientationState({
    required List<SexualOrientationEntity> sexualOrientations,
    SexualOrientationEntity? sexualOrientationEntity,
  }) : super(
          sexualOrientations: sexualOrientations,
          selectedSexualOrientationEntity: sexualOrientationEntity,
        );
}

class LoadingSelectSexualOrientationState extends SexualOrientationState {
  const LoadingSelectSexualOrientationState({
    SexualOrientationEntity? sexualOrientationEntity,
  }) : super(selectedSexualOrientationEntity: sexualOrientationEntity);
}

class LoadedSelectSexualOrientationState extends SexualOrientationState {
  const LoadedSelectSexualOrientationState({
    required List<SexualOrientationEntity> sexualOrientations,
    required SexualOrientationEntity sexualOrientationEntity,
  }) : super(
          sexualOrientations: sexualOrientations,
          selectedSexualOrientationEntity: sexualOrientationEntity,
        );
}

class UnselectSexualOrientationState extends SexualOrientationState {
  const UnselectSexualOrientationState({
    required List<SexualOrientationEntity> sexualOrientations,
    SexualOrientationEntity? sexualOrientationEntity,
  }) : super(
          sexualOrientations: sexualOrientations,
          selectedSexualOrientationEntity: sexualOrientationEntity,
        );
}

class ErrorSexualOrientationState extends SexualOrientationState {
  final String? message;

  const ErrorSexualOrientationState({
    required this.message,
    SexualOrientationEntity? sexualOrientationEntity,
  }) : super(selectedSexualOrientationEntity: sexualOrientationEntity);

  @override
  List<Object?> get props {
    return [
      ...super.props,
      message,
    ];
  }
}
