import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/helper/enum_helper.dart';
import '../../attachment/external/mappers/attachment_model_mapper.dart';
import '../../feedback/external/mappers/feedback_model_list_mapper.dart';
import '../../feedback/external/mappers/feedback_model_mapper.dart';
import '../../feedback/external/mappers/proficiency_feedback_model_mapper.dart';
import '../../feedback/external/mappers/skill_feedback_model_mapper.dart';
import '../domain/input_models/phone_contact_input_model.dart';
import '../enums/gender_type_enum.dart';
import '../external/datasources/get_address_by_postal_code_datasource_impl.dart';
import '../external/datasources/get_administrative_region_datasource_impl.dart';
import '../external/datasources/get_contract_employee_datasource_impl.dart';
import '../external/datasources/get_dependents_datasource_impl.dart';
import '../external/datasources/get_disability_datasource_impl.dart';
import '../external/datasources/get_diversity_datasource_impl.dart';
import '../external/datasources/get_education_degree_datasource_impl.dart';
import '../external/datasources/get_employee_company_name_datasource_impl.dart';
import '../external/datasources/get_gender_identity_datasource_impl.dart';
import '../external/datasources/get_need_attachment_edit_datasource_impl.dart';
import '../external/datasources/get_person_datasource_impl.dart';
import '../external/datasources/get_person_id_datasource_impl.dart';
import '../external/datasources/get_profile_datasource_impl.dart';
import '../external/datasources/get_public_feedbacks_datasource_impl.dart';
import '../external/datasources/get_public_profile_datasource_impl.dart';
import '../external/datasources/get_sexual_orientation_datasource_impl.dart';
import '../external/datasources/get_update_dependents_datasource_impl.dart';
import '../external/datasources/get_user_role_id_datasource_impl.dart';
import '../external/datasources/search_country_datasource_impl.dart';
import '../external/datasources/search_ethnicity_datasource_impl.dart';
import '../external/datasources/search_nationality_datasource_impl.dart';
import '../external/datasources/search_naturality_datasource_impl.dart';
import '../external/datasources/send_deletion_emergencial_contact_datasource_impl.dart';
import '../external/datasources/send_emergencial_contact_datasource_impl.dart';
import '../external/datasources/send_update_emergencial_contact_datasource_impl.dart';
import '../external/datasources/update_dependents_datasource_impl.dart';
import '../external/datasources/update_personal_address_datasource_impl.dart';
import '../external/datasources/update_personal_contact_datasource_impl.dart';
import '../external/datasources/update_personal_data_datasource_impl.dart';
import '../external/datasources/update_personal_diversity_datasource_impl.dart';
import '../external/datasources/update_personal_documents_datasource_impl.dart';
import '../external/datasources/update_photo_profile_datasource_impl.dart';
import '../external/mappers/address_model_mapper.dart';
import '../external/mappers/administrative_region_model_mapper.dart';
import '../external/mappers/bank_account_model_mapper.dart';
import '../external/mappers/city_model_mapper.dart';
import '../external/mappers/civil_certificate_model_mapper.dart';
import '../external/mappers/contract_employee_model_mapper.dart';
import '../external/mappers/contract_model_mapper.dart';
import '../external/mappers/country_model_mapper.dart';
import '../external/mappers/ctps_model_mapper.dart';
import '../external/mappers/dependent_dto_input_model_mapper.dart';
import '../external/mappers/dependent_model_mapper.dart';
import '../external/mappers/disabilities_model_mapper.dart';
import '../external/mappers/disability_model_mapper.dart';
import '../external/mappers/diversity_model_mapper.dart';
import '../external/mappers/edit_personal_address_input_model_mapper.dart';
import '../external/mappers/edit_personal_contact_input_model_mapper.dart';
import '../external/mappers/edit_personal_data_input_model_mapper.dart';
import '../external/mappers/edit_personal_diversity_input_model_mapper.dart';
import '../external/mappers/edit_personal_documents_input_model_mapper.dart';
import '../external/mappers/education_degree_model_mapper.dart';
import '../external/mappers/email_model_mapper.dart';
import '../external/mappers/emergencial_contact_input_model_mapper.dart';
import '../external/mappers/emergencial_contact_model_mapper.dart';
import '../external/mappers/employer_model_mapper.dart';
import '../external/mappers/ethnicity_model_mapper.dart';
import '../external/mappers/gender_identity_mapper.dart';
import '../external/mappers/nationality_model_mapper.dart';
import '../external/mappers/nationality_search_model_mapper.dart';
import '../external/mappers/naturality_search_model_mapper.dart';
import '../external/mappers/nis_model_mapper.dart';
import '../external/mappers/passport_model_mapper.dart';
import '../external/mappers/personal_request_update_mapper.dart';
import '../external/mappers/phone_contact_model_mapper.dart';
import '../external/mappers/profile_model_mapper.dart';
import '../external/mappers/profile_person_model_mapper.dart';
import '../external/mappers/public_profile_model_mapper.dart';
import '../external/mappers/reservist_certificate_model_mapper.dart';
import '../external/mappers/rg_model_mapper.dart';
import '../external/mappers/ric_model_mapper.dart';
import '../external/mappers/rne_model_mapper.dart';
import '../external/mappers/salary_model_mapper.dart';
import '../external/mappers/sexual_orientation_mapper.dart';
import '../external/mappers/social_network_model_mapper.dart';
import '../external/mappers/state_model_mapper.dart';
import '../external/mappers/visa_model_mapper.dart';
import '../external/mappers/voter_registration_model_mapper.dart';
import '../infra/datasources/get_address_by_postal_code_datasource.dart';
import '../infra/datasources/get_administrative_region_datasource.dart';
import '../infra/datasources/get_contract_employee_datasource.dart';
import '../infra/datasources/get_dependents_datasource.dart';
import '../infra/datasources/get_disability_datasource.dart';
import '../infra/datasources/get_diversity_datasource.dart';
import '../infra/datasources/get_education_degree_datasource.dart';
import '../infra/datasources/get_employee_company_name_datasource.dart';
import '../infra/datasources/get_gender_identity_datasource.dart';
import '../infra/datasources/get_need_attachment_edit_datasource.dart';
import '../infra/datasources/get_person_datasource.dart';
import '../infra/datasources/get_person_id_datasource.dart';
import '../infra/datasources/get_profile_datasource.dart';
import '../infra/datasources/get_public_feedbacks_datasource.dart';
import '../infra/datasources/get_public_profile_datasource.dart';
import '../infra/datasources/get_sexual_orientation_datasource.dart';
import '../infra/datasources/get_update_dependents_datasources.dart';
import '../infra/datasources/get_user_role_id_datasource.dart';
import '../infra/datasources/search_country_datasource.dart';
import '../infra/datasources/search_ethnicity_datasource.dart';
import '../infra/datasources/search_nationality_datasource.dart';
import '../infra/datasources/search_naturality_datasource.dart';
import '../infra/datasources/send_deletion_emergencial_contact_datasource.dart';
import '../infra/datasources/send_emergencial_contact_datasource.dart';
import '../infra/datasources/send_update_emergencial_contact_datasource.dart';
import '../infra/datasources/update_dependents_datasource.dart';
import '../infra/datasources/update_personal_address_datasource.dart';
import '../infra/datasources/update_personal_contact_datasource.dart';
import '../infra/datasources/update_personal_data_datasource.dart';
import '../infra/datasources/update_personal_diversity_datasource.dart';
import '../infra/datasources/update_personal_documents_datasource.dart';
import '../infra/datasources/update_photo_profile_datasource.dart';

class ProfileExternalBinds {
  static List<Bind<Object>> binds = [
    // Datasources
    Bind.singleton<GetProfileDatasource>(
      (i) {
        return GetProfileDatasourceImpl(
          profileModelMapper: i.get(),
          restService: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton<GetPersonDatasource>(
      (i) {
        return GetPersonDatasourceImpl(
          restService: i.get(),
          personModelMapper: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton<GetPersonIdDatasource>(
      (i) {
        return GetPersonIdDatasourceImpl(
          restService: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton<GetUserRoleIdDatasource>(
      (i) {
        return GetUserRoleIdDatasourceImpl(
          restService: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton<GetNeedAttachmentEditDatasource>(
      (i) {
        return GetNeedAttachmentEditDatasourceImpl(
          restService: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton<GetContractEmployeeDatasource>(
      (i) {
        return GetContractEmployeeDatasourceImpl(
          contractEmployeeModelMapper: i.get(),
          restService: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<GetPublicProfileDatasource>((i) {
      return GetPublicProfileDatasourceImpl(
        restService: i.get(),
        publicProfileModelMapper: i.get(),
      );
    }),

    Bind.singleton<UpdatePhotoProfileDatasource>(
      (i) {
        return UpdatePhotoProfileDatasourceImpl(
          restService: i.get(),
        );
      },
      export: true,
    ),

    Bind.factory<SearchNationalityDatasource>(
      (i) {
        return SearchNationalityDatasourceImpl(
          nationalitySearchModelMapper: i.get(),
          restService: i.get(),
        );
      },
      export: true,
    ),

    Bind.factory<SearchEthnicityDatasource>(
      (i) {
        return SearchEthnicityDatasourceImpl(
          ethnicityModelMapper: i.get(),
          restService: i.get(),
        );
      },
      export: true,
    ),

    Bind.factory<SearchCountryDatasource>((i) {
      return SearchCountryDatasourceImpl(
        countrySearchModelMapper: i.get(),
        restService: i.get(),
      );
    }),

    Bind.factory<SearchNaturalityDatasource>(
      (i) {
        return SearchNaturalityDatasourceImpl(
          naturalitySearchModelMapper: i.get(),
          restService: i.get(),
        );
      },
      export: true,
    ),

    Bind.factory<GetEducationDegreeDatasource>(
      (i) {
        return GetEducationDegreeDatasourceImpl(
          educationDegreeModelMapper: i.get(),
          restService: i.get(),
        );
      },
      export: true,
    ),

    Bind.factory<GetDisabilityDatasource>(
      (i) {
        return GetDisabilityDatasourceImpl(
          disabilityModelMapper: i.get(),
          restService: i.get(),
        );
      },
      export: true,
    ),

    Bind.factory<GetAdministrativeRegionDatasource>(
      (i) {
        return GetAdministrativeRegionDatasourceImpl(
          administrativeRegionModelMapper: i.get(),
          restService: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton<UpdatePersonalDataDatasource>(
      (i) {
        return UpdatePersonalDataDatasourceImpl(
          restService: i.get(),
          editPersonalDataInputModelMapper: i.get(),
        );
      },
      export: true,
    ),

    Bind.factory<UpdatePersonalAddressDatasource>(
      (i) {
        return UpdatePersonalAddressDatasourceImpl(
          restService: i.get(),
          editPersonalAddressInputModelMapper: i.get(),
        );
      },
      export: true,
    ),

    Bind.factory<UpdatePersonalDocumentsDatasource>(
      (i) {
        return UpdatePersonalDocumentsDatasourceImpl(
          restService: i.get(),
          editPersonalDocumentsInputModelMapper: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton<SendEmergencialContactDatasource>((i) {
      return SendEmergencialContactDatasourceImpl(
        restService: i.get(),
        emergencialContactInputModelMapper: i.get(),
      );
    }),

    Bind.singleton<SendUpdateEmergencialContactDatasource>((i) {
      return SendUpdateEmergencialContactDatasourceImpl(
        restService: i.get(),
        emergencialContactInputModelMapper: i.get(),
      );
    }),

    Bind.singleton<SendDeletionEmergencialContactDatasource>((i) {
      return SendDeletionEmergencialContactDatasourceImpl(
        restService: i.get(),
      );
    }),

    Bind.factory<GetAddressByPostalCodeDatasource>(
      (i) {
        return GetAddressByPostalCodeDatasourceImpl(
          addressByPostalCodeModelMapper: i.get(),
          restService: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton<UpdatePersonalContactDatasource>(
      (i) {
        return UpdatePersonalContactDatasourceImpl(
          restService: i.get(),
          editPersonalContactInputModelMapper: i.get(),
        );
      },
      export: true,
    ),

    Bind.factory<GetDependentsDatasource>(
      (i) {
        return GetDependentsDatasourceImpl(
          dependentModelMapper: i.get(),
          restService: i.get(),
          getUpdateDependentsDatasourceImpl: i.get(),
        );
      },
      export: true,
    ),

    Bind.factory<GetUpdateDependentsDatasource>(
      (i) {
        return GetUpdateDependentsDatasourceImpl(
          dependentModelMapper: i.get(),
          restService: i.get(),
        );
      },
      export: true,
    ),

    Bind.factory<UpdateDependentsDatasource>(
      (i) {
        return UpdateDependentsDatasourceImpl(
          restService: i.get(),
          dependentDtoInputModelMapper: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton<GetEmployeeCompanyNameDatasource>(
      (i) {
        return GetEmployeeCompanyNameDatasourceImpl(
          restService: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton<GetGenderIdentityDatasource>(
      (i) {
        return GetGenderIdentityDatasourceImpl(
          restService: i.get(),
          genderIdentityModelMapper: i.get(),
        );
      },
    ),

    Bind.singleton<GetSexualOrientationDatasource>(
      (i) {
        return GetSexualOrientationDatasourceImpl(
          restService: i.get(),
          sexualOrientationModelMapper: i.get(),
        );
      },
    ),

    Bind.singleton<GetDiversityDatasource>(
      (i) {
        return GetDiversityDatasourceImpl(
          restService: i.get(),
          diversityModelMapper: i.get(),
        );
      },
    ),

    Bind.singleton<UpdatePersonalDiversityDatasource>(
      (i) {
        return UpdatePersonalDiversityDatasourceImpl(
          restService: i.get(),
          editPersonalDiversityInputModelMapper: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton<GetPublicFeedbacksDatasource>(
      (i) {
        return GetPublicFeedbacksDatasourceImpl(
          feedbackModelListMapper: i.get(),
          restService: i.get(),
        );
      },
    ),

    // Mappers
    Bind.lazySingleton((i) {
      return PublicProfileModelMapper(
        emailModelMapper: i.get(),
        enumHelper: i.get(),
        feedbackModelMapper: i.get(),
        emergencialContactModelMapper: i.get(),
      );
    }),

    Bind.factory(
      (i) {
        return ContractEmployeeModelMapper(
          addressModelMapper: i.get(),
          employerModelMapper: i.get(),
          salaryModelMapper: i.get(),
        );
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return EmployerModelMapper(
          addressModelMapper: i.get(),
        );
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return ProficiencyFeedbackModelMapper();
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return AttachmentModelMapper();
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return SkillFeedbackModelMapper();
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return FeedbackModelMapper(
          proficiencyFeedbackModelMapper: i.get(),
          attachmentModelMapper: i.get(),
          skillFeedbackModelMapper: i.get(),
        );
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return FeedbackModelListMapper(
          feedbackModelMapper: i.get(),
        );
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return SalaryModelMapper();
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return NationalitySearchModelMapper();
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return EthnicityModelMapper();
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return AdministrativeRegionModelMapper(
          cityModelMapper: i.get(),
        );
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return NaturalitySearchModelMapper();
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return EducationDegreeModelMapper();
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return EditPersonalDataInputModelMapper();
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return EditPersonalAddressInputModelMapper();
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return EditPersonalDocumentsInputModelMapper();
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return EditPersonalContactInputModelMapper();
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return ProfileModelMapper(
          addressModelMapper: i.get(),
          bankAccountModelMapper: i.get(),
          cityModelMapper: i.get(),
          civilCertificateModelMapper: i.get(),
          contractModelMapper: i.get(),
          ctpsModelMapper: i.get(),
          emailModelMapper: i.get(),
          emergencialContactModelMapper: i.get(),
          nationalityModelMapper: i.get(),
          nisModelMapper: i.get(),
          passportModelMapper: i.get(),
          phoneContactModelMapper: i.get(),
          reservistCertificateModelMapper: i.get(),
          rgModelMapper: i.get(),
          ricModelMapper: i.get(),
          rneModelMapper: i.get(),
          socialNetworkModelMapper: i.get(),
          visaModelMapper: i.get(),
          voterRegistrationModelMapper: i.get(),
          disabilitiesModelMapper: i.get(),
          personalRequestUpdateMapper: i.get(),
          addressRequestUpdateMapper: i.get(),
          contactRequestUpdateMapper: i.get(),
          documentRequestUpdateMapper: i.get(),
        );
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return VoterRegistrationModelMapper();
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return ReservistCertificateModelMapper();
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return RicModelMapper();
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return NationalityModelMapper();
      },
      export: true,
    ),
    Bind.factory(
      (i) {
        return ContractModelMapper(
          phoneContactModelMapper: i.get(),
          emailModelMapper: i.get(),
        );
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return CountryModelMapper();
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return StateModelMapper(
          countryModelMapper: i.get(),
        );
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return CityModelMapper(
          stateModelMapper: i.get(),
        );
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return AddressModelMapper(
          cityModelMapper: i.get(),
          administrativeRegionModelMapper: i.get(),
        );
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return ProfilePersonModelMapper();
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return BankAccountModelMapper();
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return EmailModelMapper();
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return PhoneContactModelMapper();
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return CivilCertificateModelMapper(
          cityModelMapper: i.get(),
        );
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return NisModelMapper();
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return RneModelMapper();
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return RgModelMapper();
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return PassportModelMapper();
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return SocialNetworkModelMapper();
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return VisaModelMapper();
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return CtpsModelMapper();
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return CivilCertificateModelMapper(
          cityModelMapper: i.get(),
        );
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return PhoneContactModelMapper();
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return DisabilitiesModelMapper();
      },
      export: true,
    ),

    Bind.singleton(
      (i) {
        return DisabilityModelMapper();
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return PersonalRequestUpdateMapper();
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return const PhoneContactInputModel();
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return EmergencialContactModelMapper();
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return EmergencialContactInputModelMapper();
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return DependentModelMapper(
          cityModelMapper: i.get(),
          educationDegreeModelMapper: i.get(),
          civilCertificateModelMapper: i.get(),
          rgModelMapper: i.get(),
        );
      },
    ),
    Bind.factory(
      (i) {
        return DependentDtoInputModelMapper();
      },
      export: true,
    ),

    Bind.lazySingleton(
      (i) {
        return GenderIdentityModelMapper();
      },
    ),

    Bind.lazySingleton(
      (i) {
        return SexualOrientationModelMapper();
      },
    ),

    Bind.lazySingleton(
      (i) {
        return DiversityModelMapper();
      },
    ),

    Bind.factory(
      (i) {
        return EditPersonalDiversityInputModelMapper();
      },
      export: true,
    ),

    // Enums
    Bind.factory(
      (i) {
        return EnumHelper<GenderTypeEnum>();
      },
    ),
  ];
}
