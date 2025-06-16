import 'package:equatable/equatable.dart';

import '../../enums/gender_type_enum.dart';
import '../../enums/marital_status_enum.dart';
import '../../enums/personal_relationship_enum.dart';
import '../../enums/personal_request_update_status_enum.dart';
import '../../enums/request_type_enum.dart';
import 'attachments_input_model.dart';
import 'city_input_model.dart';
import 'civil_certificate_input_model.dart';
import 'education_degree_input_model.dart';
import 'rg_input_model.dart';

class EditDependentsInputModel extends Equatable {
  final String id;
  final String? employeeId;
  final String fullName;
  final String? birthDate;
  final GenderTypeEnum gender;
  final EducationDegreeInputModel? educationDegree;
  final PersonalRelationshipEnum relationshipType;
  final bool? isAccountedForIRRF;
  final bool? isEligibleToFamilyAllowance;
  final bool? isEligibleToAlimony;
  final String? cpf;
  final String? deathDate;
  final MaritalStatusEnum? maritalStatus;
  final String? mothersName;
  final CityInputModel? placeOfBirth;
  final String? liveBirthDeclaration;
  final String? nameNotary;
  final String? bookNumber;
  final String? sheetNumber;
  final String? registerNumber;
  final String? requestUpdateId;
  final String? requestUpdateDate;
  final PersonalRequestUpdateStatusEnum? statusUpdate;
  final RequestTypeEnum? requestType;
  final CivilCertificateInputModel? birthCertificate;
  final CivilCertificateInputModel? deathCertificate;
  final RgInputModel? rg;
  final List<AttachmentsInputModel>? attachmentsInputModel;

  const EditDependentsInputModel({
    required this.id,
    this.employeeId,
    required this.fullName,
    this.birthDate,
    required this.gender,
    this.educationDegree,
    required this.relationshipType,
    this.isAccountedForIRRF,
    this.isEligibleToFamilyAllowance,
    this.isEligibleToAlimony,
    this.cpf,
    this.deathDate,
    this.maritalStatus,
    this.mothersName,
    this.placeOfBirth,
    this.liveBirthDeclaration,
    this.nameNotary,
    this.bookNumber,
    this.sheetNumber,
    this.registerNumber,
    this.requestUpdateId,
    this.requestUpdateDate,
    this.statusUpdate,
    this.requestType,
    this.birthCertificate,
    this.deathCertificate,
    this.rg,
    this.attachmentsInputModel,
  });

  @override
  List<Object?> get props {
    return [
      id,
      employeeId,
      fullName,
      birthDate,
      gender,
      educationDegree,
      relationshipType,
      isAccountedForIRRF,
      isEligibleToFamilyAllowance,
      isEligibleToAlimony,
      cpf,
      deathDate,
      maritalStatus,
      mothersName,
      placeOfBirth,
      liveBirthDeclaration,
      nameNotary,
      bookNumber,
      sheetNumber,
      registerNumber,
      requestUpdateId,
      requestUpdateDate,
      statusUpdate,
      requestType,
      birthCertificate,
      deathCertificate,
      rg,
      attachmentsInputModel,
    ];
  }
}
