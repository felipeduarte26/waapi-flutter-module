import '../../domain/input_models/edit_personal_data_personal_dto_input_model.dart';
import 'disabilities_model_mapper.dart';

class EditPersonalDataPersonalDTOInputModelMapper {
  Map<String, dynamic> toMap({
    required EditPersonalDataPersonalDtoInputModel editPersonalDataInputModel,
  }) {
    return {
      'name': editPersonalDataInputModel.name,
      'nationality': {
        'id': editPersonalDataInputModel.nationality.id,
        'name': editPersonalDataInputModel.nationality.name,
        'code': editPersonalDataInputModel.nationality.code,
      },
      'placeOfBirth': {
        'id': editPersonalDataInputModel.placeOfBirth.id,
        'name': editPersonalDataInputModel.placeOfBirth.name,
        'state': {
          'id': editPersonalDataInputModel.placeOfBirth.state?.id,
          'name': editPersonalDataInputModel.placeOfBirth.state?.name,
          'abbreviation': editPersonalDataInputModel.placeOfBirth.state?.abbreviation,
          'country': {
            'id': editPersonalDataInputModel.placeOfBirth.state?.country?.id,
            'name': editPersonalDataInputModel.placeOfBirth.state?.country?.name,
            'abbreviation': editPersonalDataInputModel.placeOfBirth.state?.country?.abbreviation,
          },
        },
      },
      'maritalStatus': editPersonalDataInputModel.maritalStatus,
      'gender': editPersonalDataInputModel.gender,
      if (editPersonalDataInputModel.ethnicity != null)
        'ethnicity': {
          'id': editPersonalDataInputModel.ethnicity!.id,
          'code': editPersonalDataInputModel.ethnicity!.code,
          'name': editPersonalDataInputModel.ethnicity!.name,
        },
      if (editPersonalDataInputModel.educationDegree != null)
        'educationDegree': {
          'id': editPersonalDataInputModel.educationDegree!.id,
          'name': editPersonalDataInputModel.educationDegree!.name,
          'educationDegreeType': editPersonalDataInputModel.educationDegree!.type,
        },
      'rehabilitation': editPersonalDataInputModel.rehabilitation,
      'disabilities': editPersonalDataInputModel.disabilities?.map((editPersonalDataDisabilitiesInputModel) {
        return DisabilitiesModelMapper().toMap(
          disabilitiesModel: editPersonalDataDisabilitiesInputModel,
        );
      }).toList(),
      'isRealData': editPersonalDataInputModel.isRealData,
      'commentary': editPersonalDataInputModel.commentary,
      'birthDay': editPersonalDataInputModel.birthday,
    };
  }
}
