import 'package:equatable/equatable.dart';

import '../../../domain/entities/disability_entity.dart';

abstract class DisabilityState extends Equatable {
  final List<DisabilityEntity> disabilityList;
  final DisabilityEntity? selectedDisabilityEntity;

  const DisabilityState({
    this.disabilityList = const [],
    this.selectedDisabilityEntity,
  });

  DisabilityState initialDisabilityState() {
    return InitialDisabilityState(
      disabilityEntity: selectedDisabilityEntity,
    );
  }

  DisabilityState loadingDisabilityState() {
    return LoadingDisabilityState(
      disabilityEntity: selectedDisabilityEntity,
    );
  }

  DisabilityState emptyStateDisabilityState() {
    return EmptyStateDisabilityState(
      disabilityEntity: selectedDisabilityEntity,
    );
  }

  DisabilityState loadedDisabilityState({
    required List<DisabilityEntity> disabilityList,
  }) {
    return LoadedDisabilityState(
      disabilityList: disabilityList,
      disabilityEntity: selectedDisabilityEntity,
    );
  }

  DisabilityState errorDisabilityState({
    String? message,
  }) {
    return ErrorDisabilityState(
      message: message,
      disabilityEntity: selectedDisabilityEntity,
    );
  }

  DisabilityState loadedSelectDisabilityState({
    required DisabilityEntity disabilityEntity,
  }) {
    return LoadedSelectDisabilityState(
      disabilityList: disabilityList,
      disabilityEntity: disabilityEntity,
    );
  }

  DisabilityState unselectDisabilityState({
    required DisabilityEntity disabilityEntity,
  }) {
    return UnselectDisabilityState(
      disabilityList: disabilityList,
      disabilityEntity: disabilityEntity,
    );
  }

  @override
  List<Object?> get props {
    return [
      disabilityList,
      selectedDisabilityEntity,
    ];
  }
}

class InitialDisabilityState extends DisabilityState {
  const InitialDisabilityState({
    DisabilityEntity? disabilityEntity,
  }) : super(
          disabilityList: const [],
          selectedDisabilityEntity: disabilityEntity,
        );
}

class LoadingDisabilityState extends DisabilityState {
  const LoadingDisabilityState({
    DisabilityEntity? disabilityEntity,
  }) : super(
          disabilityList: const [],
          selectedDisabilityEntity: disabilityEntity,
        );
}

class EmptyStateDisabilityState extends DisabilityState {
  const EmptyStateDisabilityState({
    DisabilityEntity? disabilityEntity,
  }) : super(
          disabilityList: const [],
          selectedDisabilityEntity: disabilityEntity,
        );
}

class LoadedDisabilityState extends DisabilityState {
  const LoadedDisabilityState({
    required List<DisabilityEntity> disabilityList,
    DisabilityEntity? disabilityEntity,
  }) : super(
          disabilityList: disabilityList,
          selectedDisabilityEntity: disabilityEntity,
        );
}

class LoadingSelectDisabilityState extends DisabilityState {
  const LoadingSelectDisabilityState({
    DisabilityEntity? disabilityEntity,
  }) : super(selectedDisabilityEntity: disabilityEntity);
}

class LoadedSelectDisabilityState extends DisabilityState {
  const LoadedSelectDisabilityState({
    required List<DisabilityEntity> disabilityList,
    required DisabilityEntity disabilityEntity,
  }) : super(
          disabilityList: disabilityList,
          selectedDisabilityEntity: disabilityEntity,
        );
}

class UnselectDisabilityState extends DisabilityState {
  const UnselectDisabilityState({
    required List<DisabilityEntity> disabilityList,
    DisabilityEntity? disabilityEntity,
  }) : super(
          disabilityList: disabilityList,
          selectedDisabilityEntity: disabilityEntity,
        );
}

class ErrorDisabilityState extends DisabilityState {
  final String? message;

  const ErrorDisabilityState({
    required this.message,
    DisabilityEntity? disabilityEntity,
  }) : super(selectedDisabilityEntity: disabilityEntity);

  @override
  List<Object?> get props {
    return [
      ...super.props,
      message,
    ];
  }
}
