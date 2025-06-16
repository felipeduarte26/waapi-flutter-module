import 'dart:convert';

import '../../../../core/helper/date_time_helper.dart';
import '../../infra/models/profile_person_model.dart';
import 'education_degree_model_mapper.dart';
import 'ethnicity_model_mapper.dart';

class ProfilePersonModelMapper {
  ProfilePersonModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return ProfilePersonModel(
      ethnicity: map['ethnicity'] != null ? EthnicityModelMapper().fromMap(map: map['ethnicity']) : null,
      birthDate: DateTimeHelper.convertStringAaaaMmDdToDateTime(
        stringToConvert: map['birthDate'] ?? '',
      ),
      educationDegree: map['educationDegree'] != null
          ? EducationDegreeModelMapper().fromMap(
              map: map['educationDegree'],
            )
          : null,
    );
  }

  ProfilePersonModel fromJson({required String personJson}) {
    return fromMap(
      map: json.decode(personJson),
    );
  }
}
