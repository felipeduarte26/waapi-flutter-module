import 'package:equatable/equatable.dart';

import '../../../domain/entities/education_degree_entity.dart';

abstract class EducationDegreeState extends Equatable {
  final List<EducationDegreeEntity> educationDegreeList;
  final EducationDegreeEntity? selectedEducationDegreeEntity;

  const EducationDegreeState({
    this.educationDegreeList = const [],
    this.selectedEducationDegreeEntity,
  });

  EducationDegreeState initialEducationDegreeState() {
    return InitialEducationDegreeState(
      educationDegreeEntity: selectedEducationDegreeEntity,
    );
  }

  EducationDegreeState loadingEducationDegreeState() {
    return LoadingEducationDegreeState(
      educationDegreeEntity: selectedEducationDegreeEntity,
    );
  }

  EducationDegreeState emptyStateEducationDegreeState() {
    return EmptyStateEducationDegreeState(
      educationDegreeEntity: selectedEducationDegreeEntity,
    );
  }

  EducationDegreeState loadedEducationDegreeState({
    required List<EducationDegreeEntity> educationDegreeList,
  }) {
    return LoadedEducationDegreeState(
      educationDegreeList: educationDegreeList,
      educationDegreeEntity: selectedEducationDegreeEntity,
    );
  }

  EducationDegreeState errorEducationDegreeState({
    String? message,
  }) {
    return ErrorEducationDegreeState(
      message: message,
      educationDegreeEntity: selectedEducationDegreeEntity,
    );
  }

  EducationDegreeState loadedSelectEducationDegreeState({
    required EducationDegreeEntity educationDegreeEntity,
  }) {
    return LoadedSelectEducationDegreeState(
      educationDegreeEntity: educationDegreeEntity,
      educationDegreeList: educationDegreeList,
    );
  }

  @override
  List<Object?> get props {
    return [
      educationDegreeList,
      selectedEducationDegreeEntity,
    ];
  }
}

class InitialEducationDegreeState extends EducationDegreeState {
  const InitialEducationDegreeState({
    EducationDegreeEntity? educationDegreeEntity,
  }) : super(
          educationDegreeList: const [],
          selectedEducationDegreeEntity: educationDegreeEntity,
        );
}

class LoadingEducationDegreeState extends EducationDegreeState {
  const LoadingEducationDegreeState({
    EducationDegreeEntity? educationDegreeEntity,
  }) : super(
          educationDegreeList: const [],
          selectedEducationDegreeEntity: educationDegreeEntity,
        );
}

class EmptyStateEducationDegreeState extends EducationDegreeState {
  const EmptyStateEducationDegreeState({
    EducationDegreeEntity? educationDegreeEntity,
  }) : super(
          educationDegreeList: const [],
          selectedEducationDegreeEntity: educationDegreeEntity,
        );
}

class LoadedEducationDegreeState extends EducationDegreeState {
  const LoadedEducationDegreeState({
    required List<EducationDegreeEntity> educationDegreeList,
    EducationDegreeEntity? educationDegreeEntity,
  }) : super(
          educationDegreeList: educationDegreeList,
          selectedEducationDegreeEntity: educationDegreeEntity,
        );
}

class LoadingSelectEducationDegreeState extends EducationDegreeState {
  const LoadingSelectEducationDegreeState({
    EducationDegreeEntity? educationDegreeEntity,
  }) : super(selectedEducationDegreeEntity: educationDegreeEntity);
}

class LoadedSelectEducationDegreeState extends EducationDegreeState {
  const LoadedSelectEducationDegreeState({
    required List<EducationDegreeEntity> educationDegreeList,
    required EducationDegreeEntity educationDegreeEntity,
  }) : super(
          selectedEducationDegreeEntity: educationDegreeEntity,
          educationDegreeList: educationDegreeList,
        );
}

class ErrorEducationDegreeState extends EducationDegreeState {
  final String? message;

  const ErrorEducationDegreeState({
    required this.message,
    EducationDegreeEntity? educationDegreeEntity,
  }) : super(selectedEducationDegreeEntity: educationDegreeEntity);

  @override
  List<Object?> get props {
    return [
      ...super.props,
      message,
    ];
  }
}
