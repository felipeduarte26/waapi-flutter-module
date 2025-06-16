import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../../../core/enums/brazilian_state_enum.dart';
import '../../../../../core/helper/date_time_helper.dart';
import '../../../../../core/helper/enum_helper.dart';
import '../../../../../core/helper/locale_helper.dart';
import '../../../../attachment/domain/entities/attachment_entity.dart';
import '../../../domain/entities/city_entity.dart';
import '../../../domain/entities/dependent_entity.dart';
import '../../../domain/entities/education_degree_entity.dart';
import '../../../domain/input_models/attachments_input_model.dart';
import '../../../domain/input_models/city_input_model.dart';
import '../../../domain/input_models/civil_certificate_input_model.dart';
import '../../../domain/input_models/country_input_model.dart';
import '../../../domain/input_models/dependent_dto_input_model.dart';
import '../../../domain/input_models/edit_dependents_input_model.dart';
import '../../../domain/input_models/education_degree_input_model.dart';
import '../../../domain/input_models/rg_input_model.dart';
import '../../../domain/input_models/state_input_model.dart';
import '../../../enums/civil_certificate_type_enum.dart';
import '../../../enums/gender_type_enum.dart';
import '../../../enums/marital_status_enum.dart';
import '../../../enums/personal_relationship_enum.dart';
import '../../../enums/request_type_enum.dart';
import '../../../helper/cpf_validator_help.dart';

class EditDependentsController {
  // edit_mandatory_data_screen.dart
  late TextEditingController fullNameController;
  late TextEditingController genderController;
  late TextEditingController birthDateController;
  late TextEditingController maritalStatusController;
  late TextEditingController degreeOfKinshipController;
  late TextEditingController educationDegreeController;
  late TextEditingController naturalityController;
  late TextEditingController cpfNumberController;
  late TextEditingController mothersNameController;
  late TextEditingController liveBirthDeclarationController;
  late TextEditingController notesController;
  late TextEditingController cityController;
  late TextEditingController cityIdController;
  late GenderTypeEnum? selectedGenderController;
  late PersonalRelationshipEnum? selectedRelationshipController;
  late MaritalStatusEnum? onSelectedMaritalStatus;

  //edit_dependents_birth_certificate_widget
  late TextEditingController birthEnrollmentController;
  late TextEditingController birthTermNumberController;
  late TextEditingController birthBookNumberController;
  late TextEditingController birthSheetNumberController;
  late TextEditingController birthIssuanceDateController;
  late TextEditingController birthNotaryOfficeNameController;
  late TextEditingController birthNotaryOfficeCityController;
  late TextEditingController birthNotaryOfficeCityIdController;

  //edit_dependents_death_certificate_widget
  late TextEditingController deathEnrollmentController;
  late TextEditingController deathTermNumberController;
  late TextEditingController deathBookNumberController;
  late TextEditingController deathSheetNumberController;
  late TextEditingController deathIssuanceDateController;
  late TextEditingController deathNotaryOfficeNameController;
  late TextEditingController deathNotaryOfficeCityController;
  late TextEditingController deathNotaryOfficeCityIdController;

  //edit_dependents_rg_widget
  late TextEditingController rgNumberController;
  late TextEditingController rgIssuanceDateController;
  late TextEditingController rgIssuerController;
  late TextEditingController rgIssuingStateController;

  //edit_dependents_attachment_widget
  late List<AttachmentEntity>? attachmentsController;

  late RequestTypeEnum requestTypeController;
  late String requestUpdateIdController;

  bool isIncomeTaxDependent = false;
  bool isEligibleToAlimony = false;
  bool isEligibleToFamilyAllowance = false;
  bool needAttachment = false;
  bool trueInformation = false;
  bool idEditFormFamily = true;
  bool enableDependentIncomeTax = false;
  bool isEditingDeathOfficeCity = false;
  int currentStep = 1;
  String dependentId = '';
  String locale = '';
  EducationDegreeEntity? educationDegree = const EducationDegreeEntity();
  CityEntity? deathNotaryOfficeCity = const CityEntity();
  CityEntity? birthNotaryOfficeCity = const CityEntity();

  late PageController pageController;

  EditDependentsController({
    required DependentEntity? dependentEntity,
    required AppLocalizations appLocalizations,
  }) {
    locale = appLocalizations.localeName;

    fullNameController = TextEditingController(
      text: dependentEntity?.fullName ?? '',
    );
    genderController = TextEditingController(
      text: dependentEntity?.gender?.nameTranslate(appLocalizations) ?? '',
    );
    birthDateController = TextEditingController(
      text: dependentEntity?.birthDate != null
          ? DateTimeHelper.formatWithDefaultDatePattern(
              dateTime: dependentEntity?.birthDate ?? DateTime.now(),
              locale: appLocalizations.localeName,
            )
          : '',
    );
    maritalStatusController = TextEditingController(
      text:
          dependentEntity?.maritalStatus != null ? dependentEntity?.maritalStatus?.nameTranslate(appLocalizations) : '',
    );
    onSelectedMaritalStatus = dependentEntity?.maritalStatus;
    degreeOfKinshipController = TextEditingController(
      text: dependentEntity?.relationshipType?.name(appLocalizations) ?? '',
    );
    educationDegreeController = TextEditingController(
      text: dependentEntity?.educationDegree?.id ?? '',
    );
    naturalityController = TextEditingController(
      text: dependentEntity?.placeOfBirth?.name ?? '',
    );
    cpfNumberController = TextEditingController(
      text: dependentEntity?.cpf ?? '',
    );
    mothersNameController = TextEditingController(
      text: dependentEntity?.mothersName ?? '',
    );
    liveBirthDeclarationController = TextEditingController(
      text: dependentEntity?.liveBirthDeclaration ?? '',
    );
    cityController = TextEditingController(
      text: dependentEntity?.placeOfBirth?.name ?? '',
    );
    cityIdController = TextEditingController(
      text: dependentEntity?.placeOfBirth?.id ?? '',
    );

    isIncomeTaxDependent = dependentEntity?.isAccountedForIRRF ?? false;
    isEligibleToAlimony = dependentEntity?.isEligibleToAlimony ?? false;
    isEligibleToFamilyAllowance = dependentEntity?.isEligibleToFamilyAllowance ?? false;

    //edit_dependets_birth_certificate_widget
    birthEnrollmentController = TextEditingController(
      text: dependentEntity?.birthCertificate?.enrollment ?? '',
    );
    birthTermNumberController = TextEditingController(
      text: dependentEntity?.birthCertificate?.termNumber ?? '',
    );
    birthBookNumberController = TextEditingController(
      text: dependentEntity?.birthCertificate?.bookNumber ?? '',
    );
    birthSheetNumberController = TextEditingController(
      text: dependentEntity?.birthCertificate?.paperNumber ?? '',
    );
    birthIssuanceDateController = TextEditingController(
      text: dependentEntity?.birthCertificate?.issuedDate != null
          ? DateTimeHelper.formatWithDefaultDatePattern(
              dateTime: dependentEntity?.birthCertificate?.issuedDate ?? DateTime.now(),
              locale: appLocalizations.localeName,
            )
          : '',
    );
    birthNotaryOfficeNameController = TextEditingController(
      text: dependentEntity?.birthCertificate?.registryName ?? '',
    );
    birthNotaryOfficeCityController = TextEditingController(
      text: dependentEntity?.birthCertificate?.city?.name ?? '',
    );

    birthNotaryOfficeCityIdController = TextEditingController(
      text: dependentEntity?.birthCertificate?.city?.id ?? '',
    );

    //edit_dependents_death_certificate_widget
    deathEnrollmentController = TextEditingController(
      text: dependentEntity?.deathCertificate?.enrollment ?? '',
    );
    deathTermNumberController = TextEditingController(
      text: dependentEntity?.deathCertificate?.termNumber ?? '',
    );
    deathBookNumberController = TextEditingController(
      text: dependentEntity?.deathCertificate?.bookNumber ?? '',
    );
    deathSheetNumberController = TextEditingController(
      text: dependentEntity?.deathCertificate?.paperNumber ?? '',
    );
    deathIssuanceDateController = TextEditingController(
      text: dependentEntity?.deathCertificate?.issuedDate != null
          ? DateTimeHelper.formatWithDefaultDatePattern(
              dateTime: dependentEntity?.deathCertificate?.issuedDate ?? DateTime.now(),
              locale: appLocalizations.localeName,
            )
          : '',
    );
    deathNotaryOfficeNameController = TextEditingController(
      text: dependentEntity?.deathCertificate?.registryName ?? '',
    );
    deathNotaryOfficeCityController = TextEditingController(
      text: dependentEntity?.deathCertificate?.city?.name ?? '',
    );

    deathNotaryOfficeCityIdController = TextEditingController(
      text: dependentEntity?.deathCertificate?.city?.id ?? '',
    );

    //edit_dependents_rg_widget
    rgNumberController = TextEditingController(
      text: dependentEntity?.rg?.number ?? '',
    );

    rgIssuanceDateController = TextEditingController(
      text: dependentEntity?.rg?.issuedDate != null
          ? DateTimeHelper.formatWithDefaultDatePattern(
              dateTime: dependentEntity?.rg?.issuedDate ?? DateTime.now(),
              locale: appLocalizations.localeName,
            )
          : '',
    );
    rgIssuerController = TextEditingController(
      text: dependentEntity?.rg?.issuer ?? '',
    );
    rgIssuingStateController = TextEditingController(
      text: dependentEntity?.rg?.issuingState?.name ?? '',
    );

    // InputNotesWidget
    notesController = TextEditingController(text: dependentEntity?.commentary ?? '');

    // edit_dependents_screen.dart
    pageController = PageController(initialPage: 0);

    selectedGenderController = dependentEntity?.gender;
    selectedRelationshipController = dependentEntity?.relationshipType;

    dependentId = dependentEntity?.id ?? '';

    //edit_dependents_attachment_widget
    attachmentsController = dependentEntity?.attachments;

    requestTypeController = dependentEntity?.requestType ?? (dependentId != '' ? RequestTypeEnum.update : RequestTypeEnum.insert);
    requestUpdateIdController = dependentEntity?.requestUpdateId ?? '';
  }

  bool mandatoryTextIsValid() {
    return fullNameController.text.isNotEmpty &&
        genderController.text.isNotEmpty &&
        (birthDateController.text.isNotEmpty && validateDateOfBirth()) &&
        degreeOfKinshipController.text.isNotEmpty &&
        (CpfValidatorHelp.isValid(cpfNumberController.text) && cpfNumberController.text.isNotEmpty);
  }

  bool validateDateOfBirth() {
    return birthDateController.text.isNotEmpty &&
        (birthDateController.text.replaceAll('/', '').trim().length == 8 ||
            birthDateController.text.replaceAll('/', '').trim().length == 6) &&
        DateTimeHelper.validateDate(
          date: birthDateController.text,
          locale: locale,
        ) &&
        DateTimeHelper.validateDate(
          date: birthDateController.text,
          locale: locale,
          validateCurrentMajorYear: true,
        );
  }

  DependentDtoInputModel sendDependent({
    required List<AttachmentsInputModel> attachmentsInputModel,
    String? employeeId,
  }) {
    return DependentDtoInputModel(
      commentary: notesController.text,
      editDependentsInputModel: EditDependentsInputModel(
        id: dependentId,
        employeeId: employeeId,
        fullName: fullNameController.text,
        birthDate: birthDateController.text.isNotEmpty
            ? DateTimeHelper.formatToIso8601Date(
                dateTime: DateFormat.yMd(LocaleHelper.languageAndCountryCode(locale: Locale(locale))).parse(
                  birthDateController.text,
                ),
              )
            : null,
        gender: selectedGenderController!,
        relationshipType: selectedRelationshipController!,
        isAccountedForIRRF: enableDependentIncomeTax ? isIncomeTaxDependent : false,
        isEligibleToAlimony: isEligibleToAlimony,
        isEligibleToFamilyAllowance: isEligibleToFamilyAllowance,
        cpf: cpfNumberController.text,
        maritalStatus: onSelectedMaritalStatus,
        mothersName: mothersNameController.text,
        deathDate: deathIssuanceDateController.text.isNotEmpty
            ? DateTimeHelper.formatToIso8601Date(
                dateTime: DateFormat.yMd(LocaleHelper.languageAndCountryCode(locale: Locale(locale))).parse(
                  deathIssuanceDateController.text,
                ),
              )
            : null,
        placeOfBirth: CityInputModel(
          id: cityIdController.text,
          name: cityController.text,
        ),
        liveBirthDeclaration: liveBirthDeclarationController.text,
        educationDegree: EducationDegreeInputModel(
          id: educationDegree?.id,
          code: educationDegree?.code,
          name: educationDegree?.name,
          type: educationDegree?.type,
        ),
        deathCertificate: CivilCertificateInputModel(
          certificateType: CivilCertificateTypeEnum.death,
          enrollment: deathEnrollmentController.text,
          termNumber: deathTermNumberController.text,
          issuedDate: deathIssuanceDateController.text.isNotEmpty
              ? DateTimeHelper.formatToIso8601Date(
                  dateTime: DateFormat.yMd(LocaleHelper.languageAndCountryCode(locale: Locale(locale))).parse(
                    deathIssuanceDateController.text,
                  ),
                )
              : null,
          bookNumber: deathBookNumberController.text,
          paperNumber: deathSheetNumberController.text,
          registryName: deathNotaryOfficeNameController.text,
          city: CityInputModel(
            id: deathNotaryOfficeCity?.id,
            state: StateInputModel(
              id: deathNotaryOfficeCity?.state?.id,
              name: deathNotaryOfficeCity?.state?.name,
              abbreviation: deathNotaryOfficeCity?.state?.abbreviation,
              country: CountryInputModel(
                id: deathNotaryOfficeCity?.state?.country?.id,
                name: deathNotaryOfficeCity?.state?.country!.name,
                abbreviation: deathNotaryOfficeCity?.state?.country?.abbreviation,
              ),
            ),
            name: deathNotaryOfficeCity?.name,
          ),
        ),
        birthCertificate: CivilCertificateInputModel(
          certificateType: CivilCertificateTypeEnum.birth,
          enrollment: birthEnrollmentController.text,
          termNumber: birthTermNumberController.text,
          issuedDate: birthIssuanceDateController.text.isNotEmpty
              ? DateTimeHelper.formatToIso8601Date(
                  dateTime: DateFormat.yMd(LocaleHelper.languageAndCountryCode(locale: Locale(locale))).parse(
                    birthIssuanceDateController.text,
                  ),
                )
              : null,
          bookNumber: birthBookNumberController.text,
          paperNumber: birthSheetNumberController.text,
          registryName: birthNotaryOfficeNameController.text,
          city: CityInputModel(
            id: birthNotaryOfficeCity?.id,
            state: StateInputModel(
              id: birthNotaryOfficeCity?.state?.id,
              name: birthNotaryOfficeCity?.state?.name,
              abbreviation: birthNotaryOfficeCity?.state?.abbreviation,
              country: CountryInputModel(
                id: birthNotaryOfficeCity?.state?.country?.id,
                name: birthNotaryOfficeCity?.state?.country?.name,
                abbreviation: birthNotaryOfficeCity?.state?.country?.abbreviation,
              ),
            ),
            name: birthNotaryOfficeCity?.name,
          ),
        ),
        rg: RgInputModel(
          number: rgNumberController.text,
          issuer: rgIssuerController.text,
          issuedDate: rgIssuanceDateController.text.isNotEmpty
              ? DateTimeHelper.formatToIso8601Date(
                  dateTime: DateFormat.yMd(LocaleHelper.languageAndCountryCode(locale: Locale(locale))).parse(
                    rgIssuanceDateController.text,
                  ),
                )
              : null,
          issuingState: EnumHelper<BrazilianStateEnum>().stringToEnum(
            stringToParse: rgIssuingStateController.text,
            values: BrazilianStateEnum.values,
          ),
        ),
        requestUpdateId: requestUpdateIdController,
      ),
      dependentId: requestUpdateIdController.isNotEmpty || requestTypeController == RequestTypeEnum.update ? dependentId : '',
      attachmentsInputModel: attachmentsInputModel,
      requestType: EnumHelper<RequestTypeEnum>().enumToString(
        enumToParse: requestTypeController,
      ),
    );
  }
}
