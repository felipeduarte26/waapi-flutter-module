import '../../../../core/enums/brazilian_state_enum.dart';
import '../../../../core/helper/enum_helper.dart';
import '../../domain/input_models/edit_dependents_input_model.dart';
import '../../enums/civil_certificate_type_enum.dart';
import '../../enums/gender_type_enum.dart';
import '../../enums/marital_status_enum.dart';
import '../../enums/personal_relationship_enum.dart';

class EditDependentsInputModelMapper {
  Map<String, dynamic> toMap({
    required EditDependentsInputModel editDependentsInputModel,
  }) {
    return {
      'id': editDependentsInputModel.id,
      'employeeId': editDependentsInputModel.employeeId,
      'fullName': editDependentsInputModel.fullName,
      'birthdate': editDependentsInputModel.birthDate,
      'gender': EnumHelper<GenderTypeEnum>().enumToString(
        enumToParse: editDependentsInputModel.gender,
      ),
      'type': EnumHelper<PersonalRelationshipEnum>().enumToString(
        enumToParse: editDependentsInputModel.relationshipType,
      ),
      'isAccountedForIRRF': editDependentsInputModel.isAccountedForIRRF,
      'isEligibleToFamilyAllowence': editDependentsInputModel.isEligibleToFamilyAllowance,
      'isEligibleToAlimony': editDependentsInputModel.isEligibleToAlimony,
      'placeOfBirthId': editDependentsInputModel.placeOfBirth?.id,
      'cpf': editDependentsInputModel.cpf,
      'birthCertificate': {
        'id': editDependentsInputModel.birthCertificate?.id,
        'certificateType': editDependentsInputModel.birthCertificate?.certificateType != null
            ? EnumHelper<CivilCertificateTypeEnum?>()
                .enumToString(enumToParse: editDependentsInputModel.birthCertificate?.certificateType)
            : null,
        'issuedDate': editDependentsInputModel.birthCertificate?.issuedDate,
        'enrollment': editDependentsInputModel.birthCertificate?.enrollment,
        'termNumber': editDependentsInputModel.birthCertificate?.termNumber,
        'bookNumber': editDependentsInputModel.birthCertificate?.bookNumber,
        'paperNumber': editDependentsInputModel.birthCertificate?.paperNumber,
        'registryName': editDependentsInputModel.birthCertificate?.registryName,
        'city': {
          'id': editDependentsInputModel.birthCertificate?.city?.id,
          'state': {
            'id': editDependentsInputModel.birthCertificate?.city?.state?.id,
            'name': editDependentsInputModel.birthCertificate?.city?.state?.name,
            'abbreviation': editDependentsInputModel.birthCertificate?.city?.state?.abbreviation,
            'country': {
              'id': editDependentsInputModel.birthCertificate?.city?.state?.country?.id,
              'name': editDependentsInputModel.birthCertificate?.city?.state?.country?.name,
              'abbreviation': editDependentsInputModel.birthCertificate?.city?.state?.country?.abbreviation,
            },
          },
          'name': editDependentsInputModel.birthCertificate?.city?.name,
        },
      },
      'rg': {
        'id': editDependentsInputModel.rg?.id,
        'number': editDependentsInputModel.rg?.number,
        'issuer': editDependentsInputModel.rg?.issuer,
        'issuingState': editDependentsInputModel.rg?.issuingState != null
            ? EnumHelper<BrazilianStateEnum?>().enumToString(
                enumToParse: editDependentsInputModel.rg?.issuingState,
              )
            : null,
        'issuedDate': editDependentsInputModel.rg?.issuedDate,
      },
      'deathCertificate': {
        'id': editDependentsInputModel.deathCertificate?.id,
        'certificateType': editDependentsInputModel.deathCertificate?.certificateType != null
            ? EnumHelper<CivilCertificateTypeEnum?>()
                .enumToString(enumToParse: editDependentsInputModel.deathCertificate?.certificateType)
            : null,
        'issuedDate': editDependentsInputModel.deathCertificate?.issuedDate,
        'enrollment': editDependentsInputModel.deathCertificate?.enrollment,
        'termNumber': editDependentsInputModel.deathCertificate?.termNumber,
        'bookNumber': editDependentsInputModel.deathCertificate?.bookNumber,
        'paperNumber': editDependentsInputModel.deathCertificate?.paperNumber,
        'registryName': editDependentsInputModel.deathCertificate?.registryName,
        'city': {
          'id': editDependentsInputModel.deathCertificate?.city?.id,
          'state': {
            'id': editDependentsInputModel.deathCertificate?.city?.state?.id,
            'name': editDependentsInputModel.deathCertificate?.city?.state?.name,
            'abbreviation': editDependentsInputModel.deathCertificate?.city?.state?.abbreviation,
            'country': {
              'id': editDependentsInputModel.deathCertificate?.city?.state?.country?.id,
              'name': editDependentsInputModel.deathCertificate?.city?.state?.country?.name,
              'abbreviation': editDependentsInputModel.deathCertificate?.city?.state?.country?.abbreviation,
            },
          },
          'name': editDependentsInputModel.deathCertificate?.city?.name,
        },
      },
      'deathDate': editDependentsInputModel.deathDate,
      'educationDegreeId': editDependentsInputModel.educationDegree?.id,
      'maritalStatus': editDependentsInputModel.maritalStatus != null
          ? EnumHelper<MaritalStatusEnum?>().enumToString(enumToParse: editDependentsInputModel.maritalStatus)
          : null,
      'mothersName': editDependentsInputModel.mothersName,
      'liveBirthDeclaration': editDependentsInputModel.liveBirthDeclaration,
      'nameNotary': editDependentsInputModel.nameNotary,
      'bookNumber': editDependentsInputModel.bookNumber,
      'sheetNumber': editDependentsInputModel.sheetNumber,
      'registerNumber': editDependentsInputModel.registerNumber,
    };
  }
}
