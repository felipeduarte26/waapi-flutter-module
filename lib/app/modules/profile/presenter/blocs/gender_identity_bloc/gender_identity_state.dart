import 'package:equatable/equatable.dart';

import '../../../domain/entities/gender_identity_entity.dart';

abstract class GenderIdentityState extends Equatable {
  final List<GenderIdentityEntity> genderIdentities;
  final GenderIdentityEntity? selectedGenderIdentityEntity;

  const GenderIdentityState({
    this.genderIdentities = const [],
    this.selectedGenderIdentityEntity,
  });

  GenderIdentityState initialGenderIdentityState() {
    return InitialGenderIdentityState(
      genderIdentityEntity: selectedGenderIdentityEntity,
    );
  }

  GenderIdentityState loadingGenderIdentityState() {
    return LoadingGenderIdentityState(
      genderIdentityEntity: selectedGenderIdentityEntity,
    );
  }

  GenderIdentityState emptyStateGenderIdentityState() {
    return EmptyStateGenderIdentityState(
      genderIdentityEntity: selectedGenderIdentityEntity,
    );
  }

  GenderIdentityState loadedGenderIdentityState({
    required List<GenderIdentityEntity> genderIdentities,
  }) {
    return LoadedGenderIdentityState(
      genderIdentities: genderIdentities,
      genderIdentityEntity: selectedGenderIdentityEntity,
    );
  }

  GenderIdentityState errorGenderIdentityState({
    String? message,
  }) {
    return ErrorGenderIdentityState(
      message: message,
      genderIdentityEntity: selectedGenderIdentityEntity,
    );
  }

  GenderIdentityState loadedSelectGenderIdentityState({
    required GenderIdentityEntity genderIdentityEntity,
  }) {
    return LoadedSelectGenderIdentityState(
      genderIdentities: genderIdentities,
      genderIdentityEntity: genderIdentityEntity,
    );
  }

  GenderIdentityState unselectGenderIdentityState({
    required GenderIdentityEntity genderIdentityEntity,
  }) {
    return UnselectGenderIdentityState(
      genderIdentities: genderIdentities,
      genderIdentityEntity: genderIdentityEntity,
    );
  }

  @override
  List<Object?> get props {
    return [
      genderIdentities,
      selectedGenderIdentityEntity,
    ];
  }
}

class InitialGenderIdentityState extends GenderIdentityState {
  const InitialGenderIdentityState({
    GenderIdentityEntity? genderIdentityEntity,
  }) : super(
          genderIdentities: const [],
          selectedGenderIdentityEntity: genderIdentityEntity,
        );
}

class LoadingGenderIdentityState extends GenderIdentityState {
  const LoadingGenderIdentityState({
    GenderIdentityEntity? genderIdentityEntity,
  }) : super(
          genderIdentities: const [],
          selectedGenderIdentityEntity: genderIdentityEntity,
        );
}

class EmptyStateGenderIdentityState extends GenderIdentityState {
  const EmptyStateGenderIdentityState({
    GenderIdentityEntity? genderIdentityEntity,
  }) : super(
          genderIdentities: const [],
          selectedGenderIdentityEntity: genderIdentityEntity,
        );
}

class LoadedGenderIdentityState extends GenderIdentityState {
  const LoadedGenderIdentityState({
    required List<GenderIdentityEntity> genderIdentities,
    GenderIdentityEntity? genderIdentityEntity,
  }) : super(
          genderIdentities: genderIdentities,
          selectedGenderIdentityEntity: genderIdentityEntity,
        );
}

class LoadingSelectGenderIdentityState extends GenderIdentityState {
  const LoadingSelectGenderIdentityState({
    GenderIdentityEntity? genderIdentityEntity,
  }) : super(selectedGenderIdentityEntity: genderIdentityEntity);
}

class LoadedSelectGenderIdentityState extends GenderIdentityState {
  const LoadedSelectGenderIdentityState({
    required List<GenderIdentityEntity> genderIdentities,
    required GenderIdentityEntity genderIdentityEntity,
  }) : super(
          genderIdentities: genderIdentities,
          selectedGenderIdentityEntity: genderIdentityEntity,
        );
}

class UnselectGenderIdentityState extends GenderIdentityState {
  const UnselectGenderIdentityState({
    required List<GenderIdentityEntity> genderIdentities,
    GenderIdentityEntity? genderIdentityEntity,
  }) : super(
          genderIdentities: genderIdentities,
          selectedGenderIdentityEntity: genderIdentityEntity,
        );
}

class ErrorGenderIdentityState extends GenderIdentityState {
  final String? message;

  const ErrorGenderIdentityState({
    required this.message,
    GenderIdentityEntity? genderIdentityEntity,
  }) : super(selectedGenderIdentityEntity: genderIdentityEntity);

  @override
  List<Object?> get props {
    return [
      ...super.props,
      message,
    ];
  }
}
