import 'package:equatable/equatable.dart';

import 'education_degree_entity.dart';
import 'ethnicity_entity.dart';

class ProfilePersonEntity extends Equatable {
  final EthnicityEntity? ethnicity;
  final DateTime? birthDate;
  final EducationDegreeEntity? educationDegree;

  const ProfilePersonEntity({
    this.ethnicity,
    this.birthDate,
    this.educationDegree,
  });

  @override
  List<Object?> get props {
    return [
      ethnicity,
      birthDate,
      educationDegree,
    ];
  }
}
