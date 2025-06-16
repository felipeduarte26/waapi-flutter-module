import 'package:flutter_modular/flutter_modular.dart';

import '../../attachment/infra/adapters/attachment_entity_adapter.dart';
import '../../feedback/infra/adapters/feedback_entity_adapter.dart';
import '../../feedback/infra/adapters/proficiency_feedback_entity_adapter.dart';
import '../../feedback/infra/adapters/skill_feedback_entity_adapter.dart';
import '../domain/repositories/get_address_by_postal_code_repository.dart';
import '../domain/repositories/get_administrative_region_repository.dart';
import '../domain/repositories/get_contract_employee_repository.dart';
import '../domain/repositories/get_dependents_repository.dart';
import '../domain/repositories/get_disability_repository.dart';
import '../domain/repositories/get_diversity_repository.dart';
import '../domain/repositories/get_education_degree_repository.dart';
import '../domain/repositories/get_employee_company_name_repository.dart';
import '../domain/repositories/get_gender_identity_repository.dart';
import '../domain/repositories/get_need_attachment_edit_repository.dart';
import '../domain/repositories/get_person_id_repository.dart';
import '../domain/repositories/get_profile_repository.dart';
import '../domain/repositories/get_public_feedbacks_repository.dart';
import '../domain/repositories/get_public_profile_repository.dart';
import '../domain/repositories/get_sexual_orientation_repository.dart';
import '../domain/repositories/get_user_role_id_repository.dart';
import '../domain/repositories/search_country_repository.dart';
import '../domain/repositories/search_ethnicity_repository.dart';
import '../domain/repositories/search_nationality_repository.dart';
import '../domain/repositories/search_naturality_repository.dart';
import '../domain/repositories/send_deletion_emergencial_contact_repository.dart';
import '../domain/repositories/send_emergencial_contact_repository.dart';
import '../domain/repositories/send_update_emergencial_contact_repository.dart';
import '../domain/repositories/update_dependents_repository.dart';
import '../domain/repositories/update_personal_address_repository.dart';
import '../domain/repositories/update_personal_contact_repository.dart';
import '../domain/repositories/update_personal_data_repository.dart';
import '../domain/repositories/update_personal_diversity_repository.dart';
import '../domain/repositories/update_personal_documents_repository.dart';
import '../domain/repositories/update_photo_profile_repository.dart';
import '../infra/adapters/address_entity_adapter.dart';
import '../infra/adapters/administrative_region_entity_adapter.dart';
import '../infra/adapters/city_entity_adapter.dart';
import '../infra/adapters/contract_employee_entity_adapter.dart';
import '../infra/adapters/country_entity_adapter.dart';
import '../infra/adapters/dependent_entity_adapter.dart';
import '../infra/adapters/disability_entity_adapter.dart';
import '../infra/adapters/diversity_entity_adapter.dart';
import '../infra/adapters/education_degree_entity_adapter.dart';
import '../infra/adapters/email_entity_adapter.dart';
import '../infra/adapters/emergencial_contact_entity_adapter.dart';
import '../infra/adapters/ethnicity_entity_adapter.dart';
import '../infra/adapters/gender_identity_adapter.dart';
import '../infra/adapters/nationality_entity_adapter.dart';
import '../infra/adapters/profile_entity_adapter.dart';
import '../infra/adapters/public_profile_entity_adapter.dart';
import '../infra/adapters/sexual_orientation_adapter.dart';
import '../infra/repositories/get_address_by_postal_code_repository_impl.dart';
import '../infra/repositories/get_administrative_region_repository_impl.dart';
import '../infra/repositories/get_contract_employee_repository_impl.dart';
import '../infra/repositories/get_dependents_repository_impl.dart';
import '../infra/repositories/get_disability_repository_impl.dart';
import '../infra/repositories/get_diversity_repository_impl.dart';
import '../infra/repositories/get_education_degree_repository_impl.dart';
import '../infra/repositories/get_employee_company_name_repository_impl.dart';
import '../infra/repositories/get_gender_identity_repository_impl.dart';
import '../infra/repositories/get_need_attachment_edit_repository_impl.dart';
import '../infra/repositories/get_person_id_repository_impl.dart';
import '../infra/repositories/get_profile_repository_impl.dart';
import '../infra/repositories/get_public_feedbacks_repository_impl.dart';
import '../infra/repositories/get_public_profile_repository_impl.dart';
import '../infra/repositories/get_sexual_orientation_repository_impl.dart';
import '../infra/repositories/get_user_role_id_repository_impl.dart';
import '../infra/repositories/search_country_repository_impl.dart';
import '../infra/repositories/search_ethnicity_repository_impl.dart';
import '../infra/repositories/search_nationality_repository_impl.dart';
import '../infra/repositories/search_naturality_repository_impl.dart';
import '../infra/repositories/send_deletion_emergencial_contact_repository_impl.dart';
import '../infra/repositories/send_emergencial_contact_repository_impl.dart';
import '../infra/repositories/send_update_emergencial_contact_repository_impl.dart';
import '../infra/repositories/update_dependents_repository_impl.dart';
import '../infra/repositories/update_personal_address_repository_impl.dart';
import '../infra/repositories/update_personal_contact_repository_impl.dart';
import '../infra/repositories/update_personal_data_repository_impl.dart';
import '../infra/repositories/update_personal_diversity_repository_impl.dart';
import '../infra/repositories/update_personal_documents_repository_impl.dart';
import '../infra/repositories/update_photo_profile_repository_impl.dart';

class ProfileInfraBinds {
  static List<Bind<Object>> binds = [
    // Repositories
    Bind.singleton<GetProfileRepository>(
      (i) {
        return GetProfileRepositoryImpl(
          getPersonDatasource: i.get(),
          getProfileDatasource: i.get(),
          profileEntityAdapter: ProfileEntityAdapter(),
        );
      },
      export: true,
    ),

    Bind.singleton<GetPersonIdRepository>(
      (i) {
        return GetPersonIdRepositoryImpl(
          getPersonIdDatasource: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton<GetContractEmployeeRepository>(
      (i) {
        return GetContractEmployeeRepositoryImpl(
          getContractEmployeeDatasource: i.get(),
          contractEmployeeEntityAdapter: ContractEmployeeEntityAdapter(),
        );
      },
      export: true,
    ),

    Bind.singleton<UpdatePhotoProfileRepository>(
      (i) {
        return UpdatePhotoProfileRepositoryImpl(
          updatePhotoProfileDatasource: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton<GetUserRoleIdRepository>(
      (i) {
        return GetUserRoleIdRepositoryImpl(
          getUserRoleIdDatasource: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton<GetNeedAttachmentEditRepository>(
      (i) {
        return GetNeedAttachmentEditRepositoryImpl(
          getNeedAttachmentEditDatasource: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<GetPublicProfileRepository>((i) {
      return GetPublicProfileRepositoryImpl(
        getPublicProfileDatasource: i.get(),
        publicProfileEntityAdapter: i.get(),
      );
    }),

    Bind.factory<SearchNationalityRepository>(
      (i) {
        return SearchNationalityRepositoryImpl(
          nationalityEntityAdapter: i.get(),
          searchNationalityDatasource: i.get(),
        );
      },
      export: true,
    ),

    Bind.factory<SearchEthnicityRepository>(
      (i) {
        return SearchEthnicityRepositoryImpl(
          ethnicityEntityAdapter: i.get(),
          searchEthnicityDatasource: i.get(),
        );
      },
      export: true,
    ),

    Bind.factory<SearchCountryRepository>((i) {
      return SearchCountryRepositoryImpl(
        countryEntityAdapter: i.get(),
        searchCountryDatasource: i.get(),
      );
    }),

    Bind.factory<SearchNaturalityRepository>(
      (i) {
        return SearchNaturalityRepositoryImpl(
          naturalityEntityAdapter: i.get(),
          searchNaturalityDatasource: i.get(),
        );
      },
      export: true,
    ),

    Bind.factory<GetEducationDegreeRepository>(
      (i) {
        return GetEducationDegreeRepositoryImpl(
          educationDegreeEntityAdapter: i.get(),
          getEducationDegreeDatasource: i.get(),
        );
      },
      export: true,
    ),

    Bind.factory<GetDependentsRepository>(
      (i) {
        return GetDependentsRepositoryImpl(
          dependentEntityAdapter: i.get(),
          getDependentsDatasource: i.get(),
        );
      },
    ),

    Bind.singleton<UpdatePersonalDataRepository>(
      (i) {
        return UpdatePersonalDataRepositoryImpl(
          updatePersonalDataDatasource: i.get(),
        );
      },
      export: true,
    ),

    Bind.factory<UpdatePersonalDocumentsRepository>(
      (i) {
        return UpdatePersonalDocumentsRepositoryImpl(
          updatePersonalDocumentsDatasource: i.get(),
        );
      },
      export: true,
    ),

    Bind.factory<UpdatePersonalAddressRepository>(
      (i) {
        return UpdatePersonalAddressRepositoryImpl(
          updatePersonalAddressDatasource: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton<UpdatePersonalContactRepository>(
      (i) {
        return UpdatePersonalContactRepositoryImpl(
          updatePersonalContactDatasource: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton<GetDisabilityRepository>(
      (i) {
        return GetDisabilityRepositoryImpl(
          getDisabilityDatasource: i.get(),
          disabilityEntityAdapter: i.get(),
        );
      },
      export: true,
    ),

    Bind.factory<SendEmergencialContactRepository>((i) {
      return SendEmergencialContactRepositoryImpl(
        sendEmergencialContactDatasource: i.get(),
      );
    }),

    Bind.factory<SendUpdateEmergencialContactRepository>((i) {
      return SendUpdateEmergencialContactRepositoryImpl(
        sendUpdateEmergencialContactDatasource: i.get(),
      );
    }),

    Bind.factory<SendDeletionEmergencialContactRepository>((i) {
      return SendDeletionEmergencialContactRepositoryImpl(
        sendDeletionEmergencialContactDatasource: i.get(),
      );
    }),

    Bind.factory<GetAdministrativeRegionRepository>(
      (i) {
        return GetAdministrativeRegionRepositoryImpl(
          administrativeRegionEntityAdapter: i.get(),
          getAdministrativeRegionDatasource: i.get(),
        );
      },
      export: true,
    ),

    Bind.factory<GetAddressByPostalCodeRepository>(
      (i) {
        return GetAddressByPostalCodeRepositoryImpl(
          addressByPostalCodeEntityAdapter: i.get(),
          getAddressByPostalCodeDatasource: i.get(),
        );
      },
      export: true,
    ),

    Bind.factory<UpdateDependentsRepository>(
      (i) {
        return UpdateDependentsRepositoryImpl(
          updateDependentsDatasource: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton<GetEmployeeCompanyNameRepository>(
      (i) {
        return GetEmployeeCompanyNameRepositoryImpl(
          getEmployeeCompanyNameDatasource: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<GetGenderIdentityRepository>((i) {
      return GetGenderIdentityRepositoryImpl(
        getGenderIdentityDatasource: i.get(),
        genderIdentityEntityAdapter: i.get(),
      );
    }),

    Bind.lazySingleton<GetSexualOrientationRepository>((i) {
      return GetSexualOrientationRepositoryImpl(
        getSexualOrientationDatasource: i.get(),
        genderIdentityEntityAdapter: i.get(),
      );
    }),

    Bind.lazySingleton<GetDiversityRepository>((i) {
      return GetDiversityRepositoryImpl(
        getDiversityDatasource: i.get(),
        diversityEntityAdapter: i.get(),
      );
    }),

    Bind.singleton<UpdatePersonalDiversityRepository>(
      (i) {
        return UpdatePersonalDiversityRepositoryImpl(
          updatePersonalDiversityDatasource: i.get(),
        );
      },
    ),

    Bind.factory<GetPublicFeedbacksRepository>(
      (i) {
        return GetPublicFeedbacksRepositoryImpl(
          feedbackEntityAdapter: i.get(),
          getPublicFeedbacksDatasource: i.get(),
        );
      },
    ),

    // Adapters
    Bind.lazySingleton((i) {
      return PublicProfileEntityAdapter(
        emailEntityAdapter: i.get(),
        feedbackEntityAdapter: i.get(),
        emergencialContactEntityAdapter: i.get(),
      );
    }),

    Bind.factory((i) {
      return EmergencialContactEntityAdapter();
    }),

    Bind.factory(
      (i) {
        return NationalityEntityAdapter();
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return EthnicityEntityAdapter();
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return EducationDegreeEntityAdapter();
      },
      export: true,
    ),

    Bind.singleton(
      (i) {
        return DisabilityEntityAdapter();
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return CityEntityAdapter();
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return CountryEntityAdapter();
      },
      export: true,
    ),

    Bind.singleton(
      (i) {
        return AdministrativeRegionEntityAdapter();
      },
      export: true,
    ),

    Bind.lazySingleton((i) {
      return EmailEntityAdapter();
    }),

    Bind.factory((i) {
      return ProficiencyFeedbackEntityAdapter();
    }),

    Bind.factory((i) {
      return AttachmentEntityAdapter();
    }),

    Bind.factory((i) {
      return SkillFeedbackEntityAdapter();
    }),

    Bind.factory((i) {
      return FeedbackEntityAdapter(
        proficiencyFeedbackEntityAdapter: i.get(),
        attachmentEntityAdapter: i.get(),
        skillFeedbackEntityAdapter: i.get(),
      );
    }),

    Bind.factory(
      (i) {
        return AddressEntityAdapter();
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return DependentEntityAdapter();
      },
    ),

    Bind.lazySingleton((i) {
      return GenderIdentityEntityAdapter();
    }),

    Bind.lazySingleton((i) {
      return SexualOrientationEntityAdapter();
    }),

    Bind.lazySingleton((i) {
      return DiversityEntityAdapter();
    }),
  ];
}
