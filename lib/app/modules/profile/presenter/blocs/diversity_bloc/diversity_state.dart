import 'package:equatable/equatable.dart';

import '../../../domain/entities/diversity_entity.dart';

abstract class DiversityState extends Equatable {
  final DiversityEntity? diversityEntity;

  const DiversityState({
    this.diversityEntity,
  });

  LoadingDiversityState loadingDiversityState() {
    return LoadingDiversityState(
      diversityEntity: diversityEntity,
    );
  }

  LoadedDiversityState loadedDiversityState({
    required DiversityEntity diversity,
  }) {
    return LoadedDiversityState(
      diversity: diversity,
    );
  }

  DiversityState emptyStateDiversityState() {
    return const EmptyStateDiversityState();
  }

  ErrorDiversityState errorDiversityState({
    String? message,
  }) {
    return ErrorDiversityState(
      message: message,
      diversityEntity: diversityEntity,
    );
  }

  @override
  List<Object?> get props {
    return [
      diversityEntity,
    ];
  }
}

class InitialDiversityState extends DiversityState {
  const InitialDiversityState({
    DiversityEntity? diversityEntity,
  }) : super(diversityEntity: diversityEntity);
}

class LoadingDiversityState extends DiversityState {
  const LoadingDiversityState({
    DiversityEntity? diversityEntity,
  }) : super(diversityEntity: diversityEntity);
}

class LoadedDiversityState extends DiversityState {
  const LoadedDiversityState({
    required DiversityEntity diversity,
  }) : super(diversityEntity: diversity);
}

class ErrorDiversityState extends DiversityState {
  final String? message;

  const ErrorDiversityState({
    required this.message,
    DiversityEntity? diversityEntity,
  }) : super(diversityEntity: diversityEntity);

  @override
  List<Object?> get props {
    return [
      ...super.props,
      message,
    ];
  }
}

class ErrorUpdateDiversityState extends DiversityState {
  const ErrorUpdateDiversityState({
    DiversityEntity? diversityEntity,
  }) : super(diversityEntity: diversityEntity);
}

class EmptyStateDiversityState extends DiversityState {
  const EmptyStateDiversityState({
    DiversityEntity? diversityEntity,
  }) : super(
          diversityEntity: diversityEntity,
        );
}
