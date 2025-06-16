import 'package:equatable/equatable.dart';

import '../../../domain/entities/education_degree_entity.dart';

abstract class EducationDegreeEvent extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class GetEducationDegreeProfileEvent extends EducationDegreeEvent {
  GetEducationDegreeProfileEvent();

  @override
  List<Object?> get props {
    return [
      ...super.props,
    ];
  }
}

class SelectEducationDegreeFromEntityToProfileEvent extends EducationDegreeEvent {
  final EducationDegreeEntity educationDegreeEntity;

  SelectEducationDegreeFromEntityToProfileEvent({
    required this.educationDegreeEntity,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      educationDegreeEntity,
    ];
  }
}

class UnselectEducationDegreeProfileEvent extends EducationDegreeEvent {}

class ClearEducationDegreeProfileEvent extends EducationDegreeEvent {}
