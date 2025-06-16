import 'package:flutter_modular/flutter_modular.dart';

import '../domain/usecases/get_address_by_postal_code_usecase.dart';
import '../domain/usecases/get_administrative_region_usecase.dart';
import '../domain/usecases/get_contract_employee_usecase.dart';
import '../domain/usecases/get_dependents_usecase.dart';
import '../domain/usecases/get_disability_usecase.dart';
import '../domain/usecases/get_diversity_usecase.dart';
import '../domain/usecases/get_education_degree_usecase.dart';
import '../domain/usecases/get_employee_company_name_usecase.dart';
import '../domain/usecases/get_gender_identity_usecase.dart';
import '../domain/usecases/get_need_attachment_edit_usecase.dart';
import '../domain/usecases/get_person_id_usecase.dart';
import '../domain/usecases/get_profile_usecase.dart';
import '../domain/usecases/get_public_feedbacks_usecase.dart';
import '../domain/usecases/get_public_profile_usecase.dart';
import '../domain/usecases/get_sexual_orientation_usecase.dart';
import '../domain/usecases/get_user_role_id_usecase.dart';
import '../domain/usecases/search_country_usecase.dart';
import '../domain/usecases/search_ethnicity_usecase.dart';
import '../domain/usecases/search_nationality_usecase.dart';
import '../domain/usecases/search_naturality_usecase.dart';
import '../domain/usecases/send_deletion_emergencial_contact_usecase.dart';
import '../domain/usecases/send_emergencial_contact_usecase.dart';
import '../domain/usecases/send_update_emergencial_contact_usecase.dart';
import '../domain/usecases/update_dependents_usecase.dart';
import '../domain/usecases/update_personal_address_usecase.dart';
import '../domain/usecases/update_personal_contact_usecase.dart';
import '../domain/usecases/update_personal_data_usecase.dart';
import '../domain/usecases/update_personal_diversity_usecase.dart';
import '../domain/usecases/update_personal_documents_usecase.dart';
import '../domain/usecases/update_photo_profile_usecase.dart';

class ProfileDomainBinds {
  static List<Bind<Object>> binds = [
    // Usecases
    Bind.singleton<GetProfileUsecase>(
      (i) {
        return GetProfileUsecaseImpl(
          getProfileRepository: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton<GetPersonIdUsecase>(
      (i) {
        return GetPersonIdUsecaseImpl(
          getPersonIdRepository: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton<GetContractEmployeeUsecase>(
      (i) {
        return GetContractEmployeeUsecaseImpl(
          getContractEmployeeRepository: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton<UpdatePhotoProfileUsecase>(
      (i) {
        return UpdatePhotoProfileUsecaseImpl(
          updatePhotoProfileRepository: i.get(),
        );
      },
      export: true,
    ),

    Bind.factory<SearchNationalityUsecase>(
      (i) {
        return SearchNationalityUsecaseImpl(
          searchNationalityRepository: i.get(),
        );
      },
      export: true,
    ),

    Bind.factory<SearchEthnicityUsecase>(
      (i) {
        return SearchEthnicityUsecaseImpl(
          searchEthnicityRepository: i.get(),
        );
      },
      export: true,
    ),

    Bind.factory<SearchNaturalityUsecase>(
      (i) {
        return SearchNaturalityUsecaseImpl(
          searchNaturalityRepository: i.get(),
        );
      },
      export: true,
    ),

    Bind.factory<GetEducationDegreeUsecase>(
      (i) {
        return GetEducationDegreeUsecaseImpl(
          getEducationDegreeRepository: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton<GetUserRoleIdUsecase>(
      (i) {
        return GetUserRoleIdUsecaseImpl(
          getUserRoleIdRepository: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton<GetDisabilityUsecase>(
      (i) {
        return GetDisabilityUsecaseImpl(
          getDisabilityRepository: i.get(),
        );
      },
      export: true,
    ),

    Bind.factory<GetDependentsUsecase>(
      (i) {
        return GetDependentsUsecaseImpl(
          getDependentsRepository: i.get(),
        );
      },
    ),

    Bind.factory<SearchNationalityUsecase>(
      (i) {
        return SearchNationalityUsecaseImpl(
          searchNationalityRepository: i.get(),
        );
      },
    ),

    Bind.factory<SearchCountryUsecase>(
      (i) {
        return SearchCountryUsecaseImpl(
          searchCountryRepository: i.get(),
        );
      },
    ),

    Bind.lazySingleton<GetPublicProfileUsecase>((i) {
      return GetPublicProfileUsecaseImpl(
        getPublicProfileRepository: i.get(),
      );
    }),

    Bind.lazySingleton<UpdatePersonalDataUsecase>(
      (i) {
        return UpdatePersonalDataUsecaseImpl(
          updatePersonalDataRepository: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<UpdatePersonalAddressUsecase>(
      (i) {
        return UpdatePersonalAddressUsecaseImpl(
          updatePersonalAddressRepository: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<UpdatePersonalContactUsecase>(
      (i) {
        return UpdatePersonalContactUsecaseImpl(
          updatePersonalContactRepository: i.get(),
        );
      },
      export: true,
    ),

    Bind.factory<UpdatePersonalDocumentsUsecase>(
      (i) {
        return UpdatePersonalDocumentsUsecaseImpl(
          updatePersonalDocumentsRepository: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<GetNeedAttachmentEditUsecase>(
      (i) {
        return GetNeedAttachmentEditUsecaseImpl(
          getNeedAttachmentEditRepository: i.get(),
        );
      },
      export: true,
    ),

    Bind.factory<SendEmergencialContactUsecase>((i) {
      return SendEmergencialContactUsecaseImpl(
        sendEmergencialContactRepository: i.get(),
      );
    }),

    Bind.factory<SendUpdateEmergencialContactUsecase>((i) {
      return SendUpdateEmergencialContactUsecaseImpl(
        sendUpdateEmergencialContactRepository: i.get(),
      );
    }),

    Bind.factory<SendDeletionEmergencialContactUsecase>((i) {
      return SendDeletionEmergencialContactUsecaseImpl(
        sendDeletionEmergencialContactRepository: i.get(),
      );
    }),

    Bind.factory<GetAdministrativeRegionUsecase>(
      (i) {
        return GetAdministrativeRegionUsecaseImpl(
          getAdministrativeRegionRepository: i.get(),
        );
      },
      export: true,
    ),

    Bind.factory<GetAddressByPostalCodeUsecase>(
      (i) {
        return GetAddressByPostalCodeUsecaseImpl(
          getAddressByPostalCodeRepository: i.get(),
        );
      },
      export: true,
    ),

    Bind.factory<UpdateDependentsUsecase>(
      (i) {
        return UpdateDependentsUsecaseImpl(
          updateDependentsRepository: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton<GetEmployeeCompanyNameUsecase>(
      (i) {
        return GetEmployeeCompanyNameUsecaseImpl(
          getEmployeeCompanyNameRepository: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton<GetGenderIdentityUsecase>(
      (i) {
        return GetGenderIdentityUsecaseImpl(
          getGenderIdentityRepository: i.get(),
        );
      },
    ),

    Bind.lazySingleton<GetSexualOrientationUsecase>(
      (i) {
        return GetSexualOrientationUsecaseImpl(
          getSexualOrientationRepository: i.get(),
        );
      },
    ),

    Bind.lazySingleton<GetDiversityUsecase>(
      (i) {
        return GetDiversityUsecaseImpl(
          getDiversityRepository: i.get(),
        );
      },
    ),

    Bind.lazySingleton<UpdatePersonalDiversityUsecase>(
      (i) {
        return UpdatePersonalDiversityUsecaseImpl(
          updatePersonalDiversityRepository: i.get(),
        );
      },
    ),

    Bind.factory<GetPublicFeedbacksUsecase>(
      (i) {
        return GetPublicFeedbacksUsecaseImpl(
          getPublicFeedbacksRepository: i.get(),
        );
      },
    ),
  ];
}
