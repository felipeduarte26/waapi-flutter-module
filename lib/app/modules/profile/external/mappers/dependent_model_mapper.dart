// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../../../core/helper/date_time_helper.dart';
import '../../../../core/helper/enum_helper.dart';
import '../../../attachment/infra/models/attachment_model.dart';
import '../../enums/gender_type_enum.dart';
import '../../enums/marital_status_enum.dart';
import '../../enums/personal_relationship_enum.dart';
import '../../enums/personal_request_update_status_enum.dart';
import '../../enums/request_type_enum.dart';
import '../../infra/models/city_model.dart';
import '../../infra/models/civil_certificate_model.dart';
import '../../infra/models/dependent_model.dart';
import '../../infra/models/education_degree_model.dart';
import '../../infra/models/rg_model.dart';
import 'city_model_mapper.dart';
import 'civil_certificate_model_mapper.dart';
import 'education_degree_model_mapper.dart';
import 'rg_model_mapper.dart';

class DependentModelMapper {
  final CityModelMapper? _cityModelMapper;
  final EducationDegreeModelMapper? _educationDegreeModelMapper;
  final CivilCertificateModelMapper? _civilCertificateModelMapper;
  final RgModelMapper? _rgModelMapper;

  DependentModelMapper({
    CityModelMapper? cityModelMapper,
    EducationDegreeModelMapper? educationDegreeModelMapper,
    CivilCertificateModelMapper? civilCertificateModelMapper,
    RgModelMapper? rgModelMapper,
  })  : _cityModelMapper = cityModelMapper,
        _civilCertificateModelMapper = civilCertificateModelMapper,
        _educationDegreeModelMapper = educationDegreeModelMapper,
        _rgModelMapper = rgModelMapper;

  DependentModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return DependentModel(
      id: map['id'],
      fullName: map['fullName'],
      relationshipType: EnumHelper<PersonalRelationshipEnum>().stringToEnum(
            stringToParse: map['type'],
            values: PersonalRelationshipEnum.values,
          ) ??
          PersonalRelationshipEnum.other,
      birthDate: DateTimeHelper.convertStringAaaaMmDdToDateTime(
        stringToConvert: map['birthdate'],
      ),
      bookNumber: map['bookNumber'],
      cpf: map['cpf'],
      deathDate: (map['deathDate'] != null && map['deathDate'] != '')
          ? DateTimeHelper.convertStringAaaaMmDdToDateTime(
              stringToConvert: map['deathDate'],
            )
          : null,
      educationDegree: educationDegreeModel(
        map: map['educationDegree'],
      ),
      gender: EnumHelper<GenderTypeEnum>().stringToEnum(
        stringToParse: map['gender'],
        values: GenderTypeEnum.values,
      ),
      isAccountedForIRRF: map['isAccountedForIRRF'] is bool ? map['isAccountedForIRRF'] : false,
      isEligibleToAlimony: map['isEligibleToAlimony'] is bool ? map['isEligibleToAlimony'] : false,
      isEligibleToFamilyAllowence:
          map['isEligibleToFamilyAllowence'] is bool ? map['isEligibleToFamilyAllowence'] : false,
      liveBirthDeclaration: map['liveBirthDeclaration'],
      maritalStatus: EnumHelper<MaritalStatusEnum>().stringToEnum(
        stringToParse: map['maritalStatus'],
        values: MaritalStatusEnum.values,
      ),
      mothersName: map['mothersName'],
      nameNotary: map['nameNotary'],
      placeOfBirth: cityModel(
        map: map['placeOfBirth'],
      ),
      registerNumber: map['registerNumber'],
      sheetNumber: map['sheetNumber'],
      birthCertificate: civilCertificateModel(
        map: map['birthCertificate'],
      ),
      deathCertificate: civilCertificateModel(
        map: map['deathCertificate'],
      ),
      rg: rgModel(
        map: map['rg'],
      ),
      requestType: EnumHelper<RequestTypeEnum>().stringToEnum(
        stringToParse: map['requestType'],
        values: RequestTypeEnum.values,
      ),
      requestUpdateDate: (map['date'] != null && map['date'] != '')
          ? DateTimeHelper.convertStringIso8601toDateTime(
              stringIso8601: map['date'],
            )
          : null,
      requestUpdateId: map['requestUpdateId'],
      statusUpdate: EnumHelper<PersonalRequestUpdateStatusEnum>().stringToEnum(
        stringToParse: map['statusUpdate'],
        values: PersonalRequestUpdateStatusEnum.values,
      ),
      attachments: attachmentModel(attachments: map['attachments']),
      commentary: map['commentary'],
    );
  }

  DependentModel updateDependentFromMap({
    required Map<String, dynamic> map,
  }) {
    return DependentModel(
      id: map['dependentId'],
      fullName: map['dependent']['fullName'],
      relationshipType: EnumHelper<PersonalRelationshipEnum>().stringToEnum(
            stringToParse: map['dependent']['type'],
            values: PersonalRelationshipEnum.values,
          ) ??
          PersonalRelationshipEnum.other,
      birthDate: DateTimeHelper.convertStringAaaaMmDdToDateTime(
        stringToConvert: map['dependent']['birthdate'],
      ),
      bookNumber: map['dependent']['bookNumber'],
      cpf: map['dependent']['cpf'],
      deathDate: (map['dependent']['deathDate'] != null && map['dependent']['deathDate'] != '')
          ? DateTimeHelper.convertStringAaaaMmDdToDateTime(
              stringToConvert: map['dependent']['deathDate'],
            )
          : null,
      educationDegree: educationDegreeModel(
        map: map['dependent']['educationDegree'],
      ),
      gender: EnumHelper<GenderTypeEnum>().stringToEnum(
        stringToParse: map['dependent']['gender'],
        values: GenderTypeEnum.values,
      ),
      isAccountedForIRRF: map['dependent']['isAccountedForIRRF'] is bool ? map['dependent']['isAccountedForIRRF'] : false,
      isEligibleToAlimony: map['dependent']['isEligibleToAlimony'] is bool ? map['dependent']['isEligibleToAlimony'] : false,
      isEligibleToFamilyAllowence:
          map['dependent']['isEligibleToFamilyAllowence'] is bool ? map['dependent']['isEligibleToFamilyAllowence'] : false,
      liveBirthDeclaration: map['dependent']['liveBirthDeclaration'],
      maritalStatus: EnumHelper<MaritalStatusEnum>().stringToEnum(
        stringToParse: map['dependent']['maritalStatus'],
        values: MaritalStatusEnum.values,
      ),
      mothersName: map['dependent']['mothersName'],
      nameNotary: map['dependent']['nameNotary'],
      placeOfBirth: cityModel(
        map: map['dependent']['placeOfBirth'],
      ),
      registerNumber: map['registerNumber'],
      sheetNumber: map['sheetNumber'],
      birthCertificate: civilCertificateModel(
        map: map['dependent']['birthCertificate'],
      ),
      deathCertificate: civilCertificateModel(
        map: map['dependent']['deathCertificate'],
      ),
      rg: rgModel(
        map: map['dependent']['rg'],
      ),
      requestType: EnumHelper<RequestTypeEnum>().stringToEnum(
        stringToParse: map['requestType'],
        values: RequestTypeEnum.values,
      ),
      requestUpdateDate: (map['date'] != null && map['date'] != '')
          ? DateTimeHelper.convertStringIso8601toDateTime(
              stringIso8601: map['date'],
            )
          : null,
      requestUpdateId: map['id'],
      statusUpdate: EnumHelper<PersonalRequestUpdateStatusEnum>().stringToEnum(
        stringToParse: map['status'],
        values: PersonalRequestUpdateStatusEnum.values,
      ),
      attachments: attachmentModel(attachments: map['attachments']),
      commentary: map['commentary'],
    );
  }

  DependentModel insertFromMap({
    required Map<String, dynamic> map,
  }) {
    return DependentModel(
      id: map['id'],
      fullName: map['dependent']['fullName'],
      relationshipType: EnumHelper<PersonalRelationshipEnum>().stringToEnum(
            stringToParse: map['dependent']['type'],
            values: PersonalRelationshipEnum.values,
          ) ??
          PersonalRelationshipEnum.other,
      birthDate: DateTimeHelper.convertStringAaaaMmDdToDateTime(
        stringToConvert: map['dependent']['birthdate'],
      ),
      bookNumber: map['dependent']['bookNumber'],
      cpf: map['dependent']['cpf'],
      deathDate: (map['dependent']['deathDate'] != null && map['dependent']['deathDate'] != '')
          ? DateTimeHelper.convertStringIso8601toDateTime(
              stringIso8601: map['dependent']['deathDate'],
            )
          : null,
      educationDegree: educationDegreeModel(
        map: map['dependent']['educationDegree'],
      ),
      gender: EnumHelper<GenderTypeEnum>().stringToEnum(
        stringToParse: map['dependent']['gender'],
        values: GenderTypeEnum.values,
      ),
      isAccountedForIRRF:
          map['dependent']['isAccountedForIRRF'] is bool ? map['dependent']['isAccountedForIRRF'] : false,
      isEligibleToAlimony:
          map['dependent']['isEligibleToAlimony'] is bool ? map['dependent']['isEligibleToAlimony'] : false,
      isEligibleToFamilyAllowence: map['dependent']['isEligibleToFamilyAllowence'] is bool
          ? map['dependent']['isEligibleToFamilyAllowence']
          : false,
      liveBirthDeclaration: map['dependent']['liveBirthDeclaration'],
      maritalStatus: EnumHelper<MaritalStatusEnum>().stringToEnum(
        stringToParse: map['dependent']['maritalStatus'],
        values: MaritalStatusEnum.values,
      ),
      mothersName: map['dependent']['mothersName'],
      nameNotary: map['dependent']['nameNotary'],
      placeOfBirth: cityModel(
        map: map['dependent']['placeOfBirth'],
      ),
      registerNumber: map['dependent']['registerNumber'],
      sheetNumber: map['dependent']['sheetNumber'],
      birthCertificate: civilCertificateModel(
        map: map['dependent']['birthCertificate'],
      ),
      deathCertificate: civilCertificateModel(
        map: map['dependent']['deathCertificate'],
      ),
      rg: rgModel(
        map: map['dependent']['rg'],
      ),
      requestType: EnumHelper<RequestTypeEnum>().stringToEnum(
        stringToParse: map['requestType'],
        values: RequestTypeEnum.values,
      ),
      requestUpdateDate: (map['date'] != null && map['date'] != '')
          ? DateTimeHelper.convertStringIso8601toDateTime(
              stringIso8601: map['date'],
            )
          : null,
      requestUpdateId: map['requestUpdateId'],
      statusUpdate: EnumHelper<PersonalRequestUpdateStatusEnum>().stringToEnum(
        stringToParse: map['status'],
        values: PersonalRequestUpdateStatusEnum.values,
      ),
      attachments: attachmentModel(attachments: map['attachments']),
      commentary: map['commentary'],
    );
  }

  bool hasRequestUpdateId({
    required Map<String, dynamic> map,
  }) {
    return map['requestUpdateId'] != null && map['requestUpdateId'] != '';
  }

  List<AttachmentModel>? attachmentModel({
    required List<dynamic>? attachments,
  }) {
    return attachments?.map((attachment) {
            return AttachmentModel(
              id: attachment['id'],
              name: attachment['name'],
              link: attachment['link'],
              personId: attachment['personId'],
            );
          }).toList();
  }

  EducationDegreeModel? educationDegreeModel({
    required Map<String, dynamic>? map,
  }) {
    return map != null
        ? _educationDegreeModelMapper!.fromMap(
            map: map,
          )
        : null;
  }

  CityModel? cityModel({
    required Map<String, dynamic>? map,
  }) {
    return map != null
        ? _cityModelMapper!.fromMap(
            map: map,
          )
        : null;
  }

  CivilCertificateModel? civilCertificateModel({
    required Map<String, dynamic>? map,
  }) {
    return map != null
        ? _civilCertificateModelMapper!.fromMap(
            map: map,
          )
        : null;
  }

  RgModel? rgModel({
    required Map<String, dynamic>? map,
  }) {
    return map != null
        ? _rgModelMapper!.fromMap(
            map: map,
          )
        : null;
  }

  Future<List<DependentModel>> fromListDecoded({
    required List<dynamic> dependents,
    required List<dynamic> requestUpdate,
  }) async {
    if (dependents.isEmpty && requestUpdate.isEmpty) {
      return [];
    }

    List<DependentModel> dependentsModel = [];

    for (var dependent in dependents) {
      dependentsModel.add(
        fromMap(
          map: dependent,
        ),
      );
    }

    for (var request in requestUpdate) {
      dependentsModel.add(
        insertFromMap(
          map: request,
        ),
      );
    }

    return dependentsModel;
  }

  List<dynamic> decodeJsonFromKey({
    required String dependentJson,
    required String key,
  }) {
    final dependentsDecoded = jsonDecode(dependentJson);
    return dependentsDecoded[key] ?? [];
  }
}
