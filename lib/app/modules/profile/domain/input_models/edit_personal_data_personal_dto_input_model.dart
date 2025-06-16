import 'package:equatable/equatable.dart';

import '../../infra/models/city_model.dart';
import '../../infra/models/disabilities_model.dart';
import '../../infra/models/education_degree_model.dart';
import '../../infra/models/ethnicity_model.dart';
import '../../infra/models/nationality_model.dart';

class EditPersonalDataPersonalDtoInputModel extends Equatable {
  final String name;
  final NationalityModel nationality;
  final CityModel placeOfBirth;
  final String maritalStatus;
  final String gender;
  final EthnicityModel? ethnicity;
  final EducationDegreeModel? educationDegree;
  final bool rehabilitation;
  final List<DisabilitiesModel>? disabilities;
  final bool isRealData;
  final String commentary;
  final String birthday;

  const EditPersonalDataPersonalDtoInputModel({
    required this.name,
    required this.nationality,
    required this.placeOfBirth,
    required this.maritalStatus,
    required this.gender,
    required this.ethnicity,
    required this.educationDegree,
    required this.rehabilitation,
    this.disabilities,
    required this.isRealData,
    required this.commentary,
    required this.birthday,
  });

  @override
  List<Object?> get props {
    return [
      name,
      nationality,
      placeOfBirth,
      maritalStatus,
      gender,
      ethnicity,
      educationDegree,
      rehabilitation,
      disabilities,
      isRealData,
      commentary,
      birthday,
    ];
  }
}
