import 'package:equatable/equatable.dart';

import 'education_degree_model.dart';
import 'ethnicity_model.dart';

class ProfilePersonModel extends Equatable {
  final EthnicityModel? ethnicity;
  final DateTime? birthDate;
  final EducationDegreeModel? educationDegree;

  const ProfilePersonModel({
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
