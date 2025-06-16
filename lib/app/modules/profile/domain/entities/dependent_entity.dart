import 'package:equatable/equatable.dart';

import '../../../attachment/domain/entities/attachment_entity.dart';
import '../../enums/gender_type_enum.dart';
import '../../enums/marital_status_enum.dart';
import '../../enums/personal_relationship_enum.dart';
import '../../enums/personal_request_update_status_enum.dart';
import '../../enums/request_type_enum.dart';
import 'city_entity.dart';
import 'civil_certificate_entity.dart';
import 'education_degree_entity.dart';
import 'rg_entity.dart';

class DependentEntity extends Equatable {
  final String id;
  final String fullName;
  final DateTime? birthDate;
  final GenderTypeEnum? gender;
  final EducationDegreeEntity? educationDegree;
  final PersonalRelationshipEnum? relationshipType;
  final bool? isAccountedForIRRF;
  final bool? isEligibleToFamilyAllowance;
  final bool? isEligibleToAlimony;
  final String? cpf;
  final DateTime? deathDate;
  final MaritalStatusEnum? maritalStatus;
  final String? mothersName;
  final CityEntity? placeOfBirth;
  final String? liveBirthDeclaration;
  final String? nameNotary;
  final String? bookNumber;
  final String? sheetNumber;
  final String? registerNumber;
  final String? requestUpdateId;
  final DateTime? requestUpdateDate;
  final PersonalRequestUpdateStatusEnum? statusUpdate;
  final RequestTypeEnum? requestType;
  final CivilCertificateEntity? birthCertificate;
  final CivilCertificateEntity? deathCertificate;
  final RgEntity? rg;
  final List<AttachmentEntity>? attachments;
  final String? commentary;

  const DependentEntity({
    required this.id,
    required this.fullName,
    this.birthDate,
    this.gender,
    this.educationDegree,
    this.relationshipType,
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
    this.attachments,
    this.commentary,
  });

  @override
  List<Object?> get props {
    return [
      id,
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
      attachments,
      commentary,
    ];
  }
}
