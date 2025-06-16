import 'package:flutter_modular/flutter_modular.dart';

import '../presenter/blocs/address_by_postal_code_bloc/address_by_postal_code_bloc.dart';
import '../presenter/blocs/administrative_region_bloc/administrative_region_bloc.dart';
import '../presenter/blocs/civil_certificate_bloc/civil_certificate_bloc.dart';
import '../presenter/blocs/company_name_bloc/company_name_bloc.dart';
import '../presenter/blocs/contract_employee_bloc/contract_employee_bloc.dart';
import '../presenter/blocs/dependent_bloc/dependent_bloc.dart';
import '../presenter/blocs/disability_bloc/disability_bloc.dart';
import '../presenter/blocs/diversity_bloc/diversity_bloc.dart';
import '../presenter/blocs/edit_dependents_bloc/edit_dependents_bloc.dart';
import '../presenter/blocs/education_degree_bloc/education_degree_bloc.dart';
import '../presenter/blocs/gender_identity_bloc/gender_identity_bloc.dart';
import '../presenter/blocs/need_attachment_edit_bloc/need_attachment_edit_bloc.dart';
import '../presenter/blocs/person_bloc/person_bloc.dart';
import '../presenter/blocs/profile_bloc/profile_bloc.dart';
import '../presenter/blocs/public_feedbacks_bloc/public_feedbacks_bloc.dart';
import '../presenter/blocs/public_profile_bloc/public_profile_bloc.dart';
import '../presenter/blocs/search_country_bloc/search_country_bloc.dart';
import '../presenter/blocs/search_ethnicity_bloc/search_ethnicity_bloc.dart';
import '../presenter/blocs/search_nationality/search_nationality_bloc.dart';
import '../presenter/blocs/search_naturality/search_naturality_bloc.dart';
import '../presenter/blocs/sexual_orientation_bloc/sexual_orientation_bloc.dart';
import '../presenter/blocs/update_personal_address_bloc/update_personal_address_bloc.dart';
import '../presenter/blocs/update_personal_contact_bloc/update_personal_contact_bloc.dart';
import '../presenter/blocs/update_personal_data_bloc/update_personal_data_bloc.dart';
import '../presenter/blocs/update_personal_diversity_bloc/update_personal_diversity_bloc.dart';
import '../presenter/blocs/update_personal_documents_bloc/update_personal_documents_bloc.dart';
import '../presenter/blocs/user_role/user_role_bloc.dart';
import '../presenter/screens/edit_dependents_screen/bloc/edit_dependents_screen_bloc.dart';
import '../presenter/screens/edit_personal_address_screen/bloc/edit_personal_address_screen_bloc.dart';
import '../presenter/screens/edit_personal_contacts_screen/bloc/edit_personal_contact_screen_bloc.dart';
import '../presenter/screens/edit_personal_data/bloc/edit_personal_data_screen_bloc.dart';
import '../presenter/screens/edit_personal_diversity_screen/bloc/edit_personal_diversity_screen_bloc.dart';
import '../presenter/screens/edit_personal_documents_screen/bloc/edit_personal_documents_screen_bloc.dart';
import '../presenter/screens/emergencial_contacts_screen/bloc/emergencial_contacts_bloc.dart';
import '../presenter/screens/personal_dependents_screen/bloc/personal_dependents_screen_bloc.dart';
import '../presenter/screens/profile_menu_screen/bloc/profile_menu_screen_bloc.dart';
import '../presenter/screens/public_profile/bloc/public_profile_screen_bloc.dart';

class ProfilePresenterBinds {
  static List<Bind<Object>> binds = [
    // Blocs
    Bind.singleton(
      (i) {
        return ProfileBloc(
          getProfileUsecase: i.get(),
          updatePhotoProfileUsecase: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton(
      (i) {
        return ContractEmployeeBloc(
          getContractEmployeeUsecase: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton(
      (i) {
        return PersonBloc(
          getPersonIdUsecase: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton(
      (i) {
        return UserRoleBloc(
          getUserRoleIdUsecase: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton(
      (i) {
        return CompanyNameBloc(
          getCompanyNameUsecase: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton(
      (i) {
        return ProfileMenuScreenBloc(
          profileBloc: i.get(),
          contractEmployeeBloc: i.get(),
          personBloc: i.get(),
          authorizationBloc: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton((i) {
      return PublicProfileBloc(
        getPublicProfileUsecase: i.get(),
      );
    }),

    Bind.lazySingleton((i) {
      return PublicProfileScreenBloc(
        authorizationBloc: i.get(),
        publicProfileBloc: i.get(),
        publicFeedbacksBloc: i.get(),
      );
    }),

    Bind.factory(
      (i) {
        return SearchNationalityBloc(
          searchNationalityUsecase: i.get(),
        );
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return SearchEthnicityBloc(
          searchEthnicityUsecase: i.get(),
        );
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return SearchNaturalityBloc(
          searchNaturalityUsecase: i.get(),
        );
      },
      export: true,
    ),

    Bind.factory((i) {
      return SearchCountryBloc(
        searchCountryUsecase: i.get(),
      );
    }),

    Bind.factory((i) {
      return CivilCertificateBloc();
    }),

    Bind.lazySingleton(
      (i) {
        return UpdatePersonalDataBloc(
          updatePersonalDataUsecase: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton(
      (i) {
        return UpdatePersonalAddressBloc(
          updatePersonalAddressUsecase: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton(
      (i) {
        return UpdatePersonalContactBloc(
          updatePersonalContactUsecase: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton(
      (i) {
        return UpdatePersonalDocumentsBloc(
          updatePersonalDocumentsUsecase: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton(
      (i) {
        return EducationDegreeBloc(
          getEducationDegreeUsecase: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton(
      (i) {
        return DisabilityBloc(
          getDisabilityUsecase: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton(
      (i) {
        return NeedAttachmentEditBloc(
          getNeedAttachmentEditUsecase: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton(
      (i) {
        return EmergencialContactsBloc(
          sendDeletionEmergencialContactUsecase: i.get(),
          sendEmergencialContactUsecase: i.get(),
          sendUpdateEmergencialContactUsecase: i.get(),
        );
      },
    ),

    Bind.singleton(
      (i) {
        return AdministrativeRegionBloc(
          getAdministrativeRegionUsecase: i.get(),
        );
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return AddressByPostalCodeBloc(
          getAddressByPostalCodeUsecase: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton(
      (i) {
        return EditPersonalDataScreenBloc(
          updatePersonalDataBloc: i.get(),
          getEducationDegreeBloc: i.get(),
          getDisabilityBloc: i.get(),
          searchNationalityBloc: i.get(),
          searchNaturalityBloc: i.get(),
          getProfileBloc: i.get(),
          getNeedAttachmentEditBloc: i.get(),
          getPersonBloc: i.get(),
          searchEthnicityBloc: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton(
      (i) {
        return EditPersonalAddressScreenBloc(
          searchCityBloc: i.get(),
          getAdministrativeRegionBloc: i.get(),
          getProfileBloc: i.get(),
          getNeedAttachmentEditBloc: i.get(),
          getPersonBloc: i.get(),
          getAddressByPostalCodeBloc: i.get(),
          updatePersonalAddressBloc: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton(
      (i) {
        return EditPersonalContactScreenBloc(
          updatePersonalContactBloc: i.get(),
          getNeedAttachmentEditBloc: i.get(),
          getProfileBloc: i.get(),
          getPersonBloc: i.get(),
          getAuthorizationBloc: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton(
      (i) {
        return EditPersonalDocumentsScreenBloc(
          searchRicCityBloc: i.get(),
          searchCountryBloc: i.get(),
          getProfileBloc: i.get(),
          getNeedAttachmentEditBloc: i.get(),
          getPersonBloc: i.get(),
          getCivilCertificateBloc: i.get(),
          searchCivilCityBloc: i.get(),
          updatePersonalDocumentsBloc: i.get(),
        );
      },
      export: true,
    ),

    Bind.lazySingleton(
      (i) {
        return EditPersonalDiversityScreenBloc(
          getGenderIdentityBloc: i.get(),
          getSexualOrientationBloc: i.get(),
          getDiversityBloc: i.get(),
          updatePersonalDiversityBloc: i.get(),
        );
      },
    ),

    Bind.factory(
      (i) {
        return DependentBloc(
          getDependentsUsecase: i.get(),
        );
      },
    ),

    Bind.singleton((i) {
      return PersonalDependentsScreenBloc(
        dependentBloc: i.get(),
        profileBloc: i.get(),
        authorizationBloc: i.get(),
      );
    }),

    Bind.factory((i) {
      return EditDependentsScreenBloc(
        educationDegreeBloc: i.get(),
        needAttachmentEditBloc: i.get(),
        searchNaturalityBloc: i.get(),
        waapiManagementPanelUploaderBloc: i.get(),
        editDependentsBloc: i.get(),
        activeContractBloc: i.get(),
        dependentBloc: i.get(),
        authorizationBloc: i.get(),
      );
    }),

    Bind.factory((i) {
      return EditDependentsBloc(
        updateDependentsUsecase: i.get(),
      );
    }),

    Bind.lazySingleton(
      (i) {
        return GenderIdentityBloc(
          getGenderIdentityUsecase: i.get(),
        );
      },
    ),

    Bind.lazySingleton(
      (i) {
        return SexualOrientationBloc(
          getSexualOrientationUsecase: i.get(),
        );
      },
    ),

    Bind.lazySingleton(
      (i) {
        return DiversityBloc(
          getDiversitysUsecase: i.get(),
        );
      },
    ),

    Bind.lazySingleton(
      (i) {
        return UpdatePersonalDiversityBloc(
          updatePersonalDiversityUsecase: i.get(),
        );
      },
    ),

    Bind.factory(
      (i) {
        return PublicFeedbacksBloc(
          getPublicFeedbacksUsecase: i.get(),
        );
      },
    ),
  ];
}
