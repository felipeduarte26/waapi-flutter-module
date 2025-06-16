import 'package:equatable/equatable.dart';

import '../../../blocs/civil_certificate_bloc/civil_certificate_state.dart';
import '../../../blocs/need_attachment_edit_bloc/need_attachment_edit_state.dart';
import '../../../blocs/person_bloc/person_state.dart';
import '../../../blocs/profile_bloc/profile_state.dart';
import '../../../blocs/search_country_bloc/search_country_state.dart';
import '../../../blocs/search_naturality/search_naturality_state.dart';
import '../../../blocs/update_personal_documents_bloc/update_personal_documents_state.dart';

abstract class EditPersonalDocumentsScreenState extends Equatable {
  final SearchCountryState searchCountryState;
  final SearchNaturalityState searchRicCityState;
  final ProfileState getProfileState;
  final NeedAttachmentEditState getNeedAttachmentEditState;
  final PersonState getPersonState;
  final CivilCertificateState getCivilCertificateState;
  final SearchNaturalityState searchCivilCityState;
  final UpdatePersonalDocumentsState updatePersonalDocumentsState;

  const EditPersonalDocumentsScreenState({
    required this.searchCountryState,
    required this.searchRicCityState,
    required this.getProfileState,
    required this.getNeedAttachmentEditState,
    required this.getPersonState,
    required this.getCivilCertificateState,
    required this.searchCivilCityState,
    required this.updatePersonalDocumentsState,
  });

  CurrentEditPersonalDocumentsScreenState currentState({
    SearchCountryState? searchCountryState,
    SearchNaturalityState? searchRicCityState,
    ProfileState? getProfileState,
    NeedAttachmentEditState? getNeedAttachmentEditState,
    PersonState? getPersonState,
    CivilCertificateState? getCivilCertificateState,
    SearchNaturalityState? searchCivilCityState,
    UpdatePersonalDocumentsState? updatePersonalDocumentsState,
  }) {
    return CurrentEditPersonalDocumentsScreenState(
      searchCountryState: searchCountryState ?? this.searchCountryState,
      searchRicCityState: searchRicCityState ?? this.searchRicCityState,
      getProfileState: getProfileState ?? this.getProfileState,
      getNeedAttachmentEditState: getNeedAttachmentEditState ?? this.getNeedAttachmentEditState,
      getPersonState: getPersonState ?? this.getPersonState,
      getCivilCertificateState: getCivilCertificateState ?? this.getCivilCertificateState,
      searchCivilCityState: searchCivilCityState ?? this.searchCivilCityState,
      updatePersonalDocumentsState: updatePersonalDocumentsState ?? this.updatePersonalDocumentsState,
    );
  }

  @override
  List<Object?> get props {
    return [
      searchCountryState,
      searchRicCityState,
      getProfileState,
      getNeedAttachmentEditState,
      getPersonState,
      getCivilCertificateState,
      searchCivilCityState,
      updatePersonalDocumentsState,
    ];
  }
}

class CurrentEditPersonalDocumentsScreenState extends EditPersonalDocumentsScreenState {
  const CurrentEditPersonalDocumentsScreenState({
    required SearchCountryState searchCountryState,
    required SearchNaturalityState searchRicCityState,
    required ProfileState getProfileState,
    required NeedAttachmentEditState getNeedAttachmentEditState,
    required PersonState getPersonState,
    required CivilCertificateState getCivilCertificateState,
    required SearchNaturalityState searchCivilCityState,
    required UpdatePersonalDocumentsState updatePersonalDocumentsState,
  }) : super(
          searchCountryState: searchCountryState,
          searchRicCityState: searchRicCityState,
          getProfileState: getProfileState,
          getNeedAttachmentEditState: getNeedAttachmentEditState,
          getPersonState: getPersonState,
          getCivilCertificateState: getCivilCertificateState,
          searchCivilCityState: searchCivilCityState,
          updatePersonalDocumentsState: updatePersonalDocumentsState,
        );
}
