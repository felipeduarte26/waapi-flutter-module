abstract class ProfileRoutes {
  // Module route name
  static const String profileModuleRoute = '/profile';

  // Profile screen routes name
  static const String profileScreenRoute = '/';
  static const String profileScreenInitialRoute = '$profileModuleRoute$profileScreenRoute';

  // Emergencial contacts screen routes name
  static const String emergencialContactsScreenRoute = '/emergencial_contacts';
  static const String emergencialContactsInitialRoute = '$profileModuleRoute$emergencialContactsScreenRoute';

  // Emergencial contact edit screen routes name
  static const String emergencialContactsDetailsScreenRoute = '/emergencial_contacts_edit';
  static const String emergencialContactsDetailsInitialRoute =
      '$profileModuleRoute$emergencialContactsDetailsScreenRoute';

  // Profile emails screen routes name
  static const String emailsScreenRoute = '/emails';
  static const String emailsScreenInitialRoute = '$profileModuleRoute$emailsScreenRoute';

  // Social network screen routes name
  static const String socialNetworkScreenRoute = '/social_network';
  static const String socialNetworkScreenInitialRoute = '$profileModuleRoute$socialNetworkScreenRoute';

  // Profile phones
  static const String personalContactScreen = '/phones';
  static const String personalContactInitialRoute = '$profileModuleRoute$personalContactScreen';

  // Profile personal documents
  static const String personalDocumentsScreenRoute = '/personal_documents';
  static const String profilePersonalDocumentsInitialRoute = '$profileModuleRoute$personalDocumentsScreenRoute';

  // Profile employment contract
  static const String employmentContractScreenRoute = '/employment_contract';
  static const String employmentContractInitialRoute = '$profileModuleRoute$employmentContractScreenRoute';

  // Profile employer information
  static const String employerInformationScreenRoute = '/employer_information';
  static const String employerInformationInitialRoute = '$profileModuleRoute$employerInformationScreenRoute';

  // Profile personal address
  static const String personalAddressScreenRoute = '/personal_address_screen';
  static const String personalAddressScreenRouteInitialRoute = '$profileModuleRoute$personalAddressScreenRoute';

  // Profile personal address
  static const String editPersonalAddressScreenRoute = '/edit_personal_address_screen';
  static const String editPersonalAddressScreenRouteInitialRoute = '$profileModuleRoute$editPersonalAddressScreenRoute';

  // Contractual bank account
  static const String bankAccountScreenRoute = '/bank_account';
  static const String bankAccountScreenRouteInitialRoute = '$profileModuleRoute$bankAccountScreenRoute';

  // Contractual salary information
  static const String salaryInformationScreenRoute = '/salary';
  static const String salaryInformationScreenRouteInitialRoute = '$profileModuleRoute$salaryInformationScreenRoute';

  // Public profile
  static const String publicProfileScreenRoute = '/public_profile';
  static const String publicProfileScreenInitialRoute = '$profileModuleRoute$publicProfileScreenRoute';

  // Public profile
  static const String publicProfileFeedbackScreenRoute = '/public_profile_feedback';
  static const String publicProfileFeedbackScreenInitialRoute = '$profileModuleRoute$publicProfileFeedbackScreenRoute';

  // Personal Data
  static const String personalDataScreenRoute = '/personal_data';
  static const String personalDataScreenInitialRoute = '$profileModuleRoute$personalDataScreenRoute';

  //Edit Personal Data
  static const String editPersonalDataScreenRoute = '/edit_personal_data';
  static const String editPersonalDataScreenInitialRoute = '$profileModuleRoute$editPersonalDataScreenRoute';

  //Edit Personal Contact
  static const String editPersonalContactScreenRoute = '/edit_personal_contacts';
  static const String editPersonalContactScreenInitialRoute = '$profileModuleRoute$editPersonalContactScreenRoute';

  //Edit Document Contact
  static const String editPersonalDocumentsScreenRoute = '/edit_personal_documents';
  static const String editPersonalDocumentsScreenInitialRoute = '$profileModuleRoute$editPersonalDocumentsScreenRoute';

  //  Personal dependents
  static const String personalDependentsScreenRoute = '/personal_dependents';
  static const String personalDependentsScreenInitialRoute = '$profileModuleRoute$personalDependentsScreenRoute';

  // Edit Personal dependents
  static const String editPersonalDependentsScreenRoute = '/edit_personal_dependents';
  static const String editPersonalDependentsScreenInitialRoute =
      '$profileModuleRoute$editPersonalDependentsScreenRoute';

// Profile personal diversity
  static const String editPersonalDiversityScreenRoute = '/edit_personal_diversity_screen';
  static const String editPersonalDiversityScreenRouteInitialRoute =
      '$profileModuleRoute$editPersonalDiversityScreenRoute';
}
