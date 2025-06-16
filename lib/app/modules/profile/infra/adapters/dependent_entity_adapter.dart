import '../../../attachment/infra/adapters/attachment_entity_adapter.dart';
import '../../domain/entities/dependent_entity.dart';
import '../../domain/entities/education_degree_entity.dart';
import '../models/dependent_model.dart';
import 'city_entity_adapter.dart';
import 'civil_certificate_entity_adapter.dart';
import 'rg_entity_adapter.dart';

class DependentEntityAdapter {
  DependentEntity fromModel({
    required DependentModel dependentModel,
  }) {
    return DependentEntity(
      id: dependentModel.id,
      fullName: dependentModel.fullName,
      relationshipType: dependentModel.relationshipType,
      birthDate: dependentModel.birthDate,
      bookNumber: dependentModel.bookNumber,
      cpf: dependentModel.cpf,
      deathDate: dependentModel.deathDate,
      educationDegree: dependentModel.educationDegree != null
          ? EducationDegreeEntity(
              code: dependentModel.educationDegree!.code,
              name: dependentModel.educationDegree!.name,
              id: dependentModel.educationDegree!.id,
              type: dependentModel.educationDegree!.type,
            )
          : null,
      gender: dependentModel.gender,
      isAccountedForIRRF: dependentModel.isAccountedForIRRF,
      isEligibleToAlimony: dependentModel.isEligibleToAlimony,
      isEligibleToFamilyAllowance: dependentModel.isEligibleToFamilyAllowence,
      liveBirthDeclaration: dependentModel.liveBirthDeclaration,
      maritalStatus: dependentModel.maritalStatus,
      mothersName: dependentModel.mothersName,
      nameNotary: dependentModel.nameNotary,
      placeOfBirth: dependentModel.placeOfBirth != null
          ? CityEntityAdapter().fromModel(
              cityModel: dependentModel.placeOfBirth!,
            )
          : null,
      registerNumber: dependentModel.registerNumber,
      sheetNumber: dependentModel.sheetNumber,
      requestType: dependentModel.requestType,
      requestUpdateDate: dependentModel.requestUpdateDate,
      requestUpdateId: dependentModel.requestUpdateId,
      statusUpdate: dependentModel.statusUpdate,
      birthCertificate: dependentModel.birthCertificate != null
          ? CivilCertificateEntityAdapter().fromModel(
              civilCertificateModel: dependentModel.birthCertificate!,
            )
          : null,
      deathCertificate: dependentModel.deathCertificate != null
          ? CivilCertificateEntityAdapter().fromModel(
              civilCertificateModel: dependentModel.deathCertificate!,
            )
          : null,
      rg: dependentModel.rg != null
          ? RgEntityAdapter().fromModel(
              rgModel: dependentModel.rg!,
            )
          : null,
      attachments: dependentModel.attachments
          ?.map((attachment) => AttachmentEntityAdapter().fromModel(model: attachment))
          .toList(),
      commentary: dependentModel.commentary,
    );
  }
}
