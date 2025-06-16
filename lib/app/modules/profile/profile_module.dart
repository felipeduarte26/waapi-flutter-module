import 'package:flutter_modular/flutter_modular.dart';

import '../../routes/routes.dart';
import 'binds/profile_domain_binds.dart';
import 'binds/profile_external_binds.dart';
import 'binds/profile_infra_binds.dart';
import 'binds/profile_presenter_binds.dart';
import 'presenter/screens/bank_account_screen/bank_account_screen.dart';
import 'presenter/screens/edit_dependents_screen/edit_dependents_screen.dart';
import 'presenter/screens/edit_personal_address_screen/edit_personal_address_screen.dart';
import 'presenter/screens/edit_personal_contacts_screen/edit_personal_contacts_screen.dart';
import 'presenter/screens/edit_personal_data/edit_personal_data_screen.dart';
import 'presenter/screens/edit_personal_diversity_screen/edit_personal_diversity_screen.dart';
import 'presenter/screens/edit_personal_documents_screen/edit_personal_documents_screen.dart';
import 'presenter/screens/emergencial_contacts_screen/emergencial_contact_details_screen/emergencial_contact_details_screen.dart';
import 'presenter/screens/emergencial_contacts_screen/emergencial_contacts_screen.dart';
import 'presenter/screens/employer_information/employer_information_screen.dart';
import 'presenter/screens/employment_contract/employment_contract_screen.dart';
import 'presenter/screens/personal_address_screen/personal_address_screen.dart';
import 'presenter/screens/personal_contact_screen/personal_contact_screen.dart';
import 'presenter/screens/personal_data_screen/personal_data_screen.dart';
import 'presenter/screens/personal_dependents_screen/personal_dependents_screen.dart';
import 'presenter/screens/personal_documents_screen/personal_documents_screen.dart';
import 'presenter/screens/profile_menu_screen/profile_menu_screen.dart';
import 'presenter/screens/public_profile/public_profile_screen.dart';
import 'presenter/screens/public_profile/public_profile_selected_feedback_screen.dart';
import 'presenter/screens/salary_screen/salary_screen.dart';

class ProfileModule extends Module {
  @override
  List<Bind<Object>> get binds {
    return [
      ...ProfileDomainBinds.binds,
      ...ProfileInfraBinds.binds,
      ...ProfileExternalBinds.binds,
      ...ProfilePresenterBinds.binds,
    ];
  }

  @override
  List<ModularRoute> get routes {
    return [
      ChildRoute(
        ProfileRoutes.profileScreenRoute,
        child: (_, args) {
          return ProfileMenuScreen(
            isWaapiLiteProfile: args.data['isWaapiLiteProfile'],
            isOffline: args.data['isOffline'],
            counterUnreadNotifications: args.data['counterUnreadNotifications'],
            employeeId: args.data['employeeId'],
            showSearchPerson: args.data['showSearchPerson'],
          );
        },
      ),
      ChildRoute(
        ProfileRoutes.personalDataScreenRoute,
        child: (_, __) {
          return const PersonalDataScreen();
        },
      ),
      ChildRoute(
        ProfileRoutes.personalContactScreen,
        child: (_, __) {
          return const PersonalContactScreen();
        },
      ),
      ChildRoute(
        ProfileRoutes.personalContactScreen,
        child: (_, __) {
          return const PersonalContactScreen();
        },
      ),
      ChildRoute(
        ProfileRoutes.personalAddressScreenRoute,
        child: (_, __) {
          return const PersonalAddressScreen();
        },
      ),
      ChildRoute(
        ProfileRoutes.editPersonalAddressScreenRoute,
        child: (_, __) {
          return const EditPersonalAddressScreen();
        },
      ),
      ChildRoute<bool>(
        ProfileRoutes.emergencialContactsScreenRoute,
        child: (_, args) {
          return const EmergencialContactsScreen();
        },
      ),
      ChildRoute(
        ProfileRoutes.bankAccountScreenRoute,
        child: (_, __) {
          return const BankAccountScreen();
        },
      ),
      ChildRoute(
        ProfileRoutes.employerInformationScreenRoute,
        child: (_, __) {
          return const EmployerInformationScreen();
        },
      ),
      ChildRoute(
        ProfileRoutes.salaryInformationScreenRoute,
        child: (_, __) {
          return const SalaryScreen();
        },
      ),
      ChildRoute(
        ProfileRoutes.employmentContractScreenRoute,
        child: (_, __) {
          return const EmploymentContractScreen();
        },
      ),
      ChildRoute(
        ProfileRoutes.personalDocumentsScreenRoute,
        child: (_, __) {
          return const PersonalDocumentsScreen();
        },
      ),
      ChildRoute(
        ProfileRoutes.emergencialContactsDetailsScreenRoute,
        child: (_, args) {
          return EmergencialContactDetailsScreen(
            emergencialContactEntity: args.data['emergencialContactEntity'],
          );
        },
      ),
      ChildRoute(
        ProfileRoutes.publicProfileScreenRoute,
        child: (_, args) {
          return PublicProfileScreen(
            username: args.data,
          );
        },
      ),
      ChildRoute(
        ProfileRoutes.publicProfileFeedbackScreenRoute,
        child: (_, args) {
          return PublicProfileSelectedFeedbackScreen(
            feedback: args.data,
          );
        },
      ),
      ChildRoute(
        ProfileRoutes.editPersonalDataScreenRoute,
        child: (_, args) {
          return const EditPersonalDataScreen();
        },
      ),
      ChildRoute(
        ProfileRoutes.editPersonalContactScreenRoute,
        child: (_, args) {
          return const EditPersonalContactsScreen();
        },
      ),
      ChildRoute(
        ProfileRoutes.editPersonalDocumentsScreenRoute,
        child: (_, args) {
          return EditPersonalDocumentsScreen(
            documents: args.data,
          );
        },
      ),
      ChildRoute(
        ProfileRoutes.personalDependentsScreenRoute,
        child: (_, __) {
          return const PersonalDependentsScreen();
        },
      ),
      ChildRoute(
        ProfileRoutes.editPersonalDependentsScreenRoute,
        child: (_, args) {
          return EditDependentsScreen(
            dependentEntity: args.data['dependentEntity'],
            cpfHolder: args.data['cpfHolder'],
            nameHolder: args.data['nameHolder'],
          );
        },
      ),
      ChildRoute(
        ProfileRoutes.editPersonalDiversityScreenRoute,
        child: (_, args) {
          return EditPersonalDiversityScreen(
            personId: args.data['personId'],
          );
        },
      ),
    ];
  }
}
