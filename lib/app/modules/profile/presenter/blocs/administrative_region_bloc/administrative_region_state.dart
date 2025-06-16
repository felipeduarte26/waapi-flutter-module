import 'package:equatable/equatable.dart';

import '../../../domain/entities/administrative_region_entity.dart';

abstract class AdministrativeRegionState extends Equatable {
  final List<AdministrativeRegionEntity> administrativeRegionList;
  final AdministrativeRegionEntity? selectedAdministrativeRegionEntity;

  const AdministrativeRegionState({
    this.administrativeRegionList = const [],
    this.selectedAdministrativeRegionEntity,
  });

  AdministrativeRegionState initialAdministrativeRegionState() {
    return InitialAdministrativeRegionState(
      administrativeRegionEntity: selectedAdministrativeRegionEntity,
    );
  }

  AdministrativeRegionState loadingAdministrativeRegionState() {
    return LoadingAdministrativeRegionState(
      administrativeRegionEntity: selectedAdministrativeRegionEntity,
    );
  }

  AdministrativeRegionState emptyStateAdministrativeRegionState() {
    return EmptyStateAdministrativeRegionState(
      administrativeRegionEntity: selectedAdministrativeRegionEntity,
    );
  }

  AdministrativeRegionState loadedAdministrativeRegionState({
    required List<AdministrativeRegionEntity> administrativeRegionList,
  }) {
    return LoadedAdministrativeRegionState(
      administrativeRegionList: administrativeRegionList,
      administrativeRegionEntity: selectedAdministrativeRegionEntity,
    );
  }

  AdministrativeRegionState errorAdministrativeRegionState({
    String? message,
  }) {
    return ErrorAdministrativeRegionState(
      message: message,
      administrativeRegionEntity: selectedAdministrativeRegionEntity,
    );
  }

  AdministrativeRegionState loadedSelectAdministrativeRegionState({
    required AdministrativeRegionEntity administrativeRegionEntity,
  }) {
    return LoadedSelectAdministrativeRegionState(
      administrativeRegionList: administrativeRegionList,
      administrativeRegionEntity: administrativeRegionEntity,
    );
  }

  AdministrativeRegionState unselectAdministrativeRegionState({
    required AdministrativeRegionEntity? administrativeRegionEntity,
  }) {
    return UnselectAdministrativeRegionState(
      administrativeRegionList: administrativeRegionList,
      administrativeRegionEntity: administrativeRegionEntity,
    );
  }

  @override
  List<Object?> get props {
    return [
      administrativeRegionList,
      selectedAdministrativeRegionEntity,
    ];
  }
}

class InitialAdministrativeRegionState extends AdministrativeRegionState {
  const InitialAdministrativeRegionState({
    AdministrativeRegionEntity? administrativeRegionEntity,
  }) : super(
          administrativeRegionList: const [],
          selectedAdministrativeRegionEntity: administrativeRegionEntity,
        );
}

class LoadingAdministrativeRegionState extends AdministrativeRegionState {
  const LoadingAdministrativeRegionState({
    AdministrativeRegionEntity? administrativeRegionEntity,
  }) : super(
          administrativeRegionList: const [],
          selectedAdministrativeRegionEntity: administrativeRegionEntity,
        );
}

class EmptyStateAdministrativeRegionState extends AdministrativeRegionState {
  const EmptyStateAdministrativeRegionState({
    AdministrativeRegionEntity? administrativeRegionEntity,
  }) : super(
          administrativeRegionList: const [],
          selectedAdministrativeRegionEntity: administrativeRegionEntity,
        );
}

class LoadedAdministrativeRegionState extends AdministrativeRegionState {
  const LoadedAdministrativeRegionState({
    required List<AdministrativeRegionEntity> administrativeRegionList,
    AdministrativeRegionEntity? administrativeRegionEntity,
  }) : super(
          administrativeRegionList: administrativeRegionList,
          selectedAdministrativeRegionEntity: administrativeRegionEntity,
        );
}

class LoadingSelectAdministrativeRegionState extends AdministrativeRegionState {
  const LoadingSelectAdministrativeRegionState({
    AdministrativeRegionEntity? administrativeRegionEntity,
  }) : super(selectedAdministrativeRegionEntity: administrativeRegionEntity);
}

class LoadedSelectAdministrativeRegionState extends AdministrativeRegionState {
  const LoadedSelectAdministrativeRegionState({
    required List<AdministrativeRegionEntity> administrativeRegionList,
    required AdministrativeRegionEntity administrativeRegionEntity,
  }) : super(
          administrativeRegionList: administrativeRegionList,
          selectedAdministrativeRegionEntity: administrativeRegionEntity,
        );
}

class UnselectAdministrativeRegionState extends AdministrativeRegionState {
  const UnselectAdministrativeRegionState({
    required List<AdministrativeRegionEntity> administrativeRegionList,
    AdministrativeRegionEntity? administrativeRegionEntity,
  }) : super(
          administrativeRegionList: administrativeRegionList,
          selectedAdministrativeRegionEntity: administrativeRegionEntity,
        );
}

class ErrorAdministrativeRegionState extends AdministrativeRegionState {
  final String? message;

  const ErrorAdministrativeRegionState({
    required this.message,
    AdministrativeRegionEntity? administrativeRegionEntity,
  }) : super(selectedAdministrativeRegionEntity: administrativeRegionEntity);

  @override
  List<Object?> get props {
    return [
      ...super.props,
      message,
    ];
  }
}
