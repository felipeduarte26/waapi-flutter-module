import 'package:equatable/equatable.dart';

import '../../../blocs/disability_bloc/disability_state.dart';
import '../../../blocs/education_degree_bloc/education_degree_state.dart';
import '../../../blocs/need_attachment_edit_bloc/need_attachment_edit_state.dart';
import '../../../blocs/person_bloc/person_state.dart';
import '../../../blocs/profile_bloc/profile_state.dart';
import '../../../blocs/search_ethnicity_bloc/search_ethnicity_bloc.dart';
import '../../../blocs/search_nationality/search_nationality_state.dart';
import '../../../blocs/search_naturality/search_naturality_state.dart';
import '../../../blocs/update_personal_data_bloc/update_personal_data_state.dart';

abstract class EditPersonalDataScreenState extends Equatable {
  final UpdatePersonalDataState updatePersonalDataState;
  final EducationDegreeState getEducationDegreeState;
  final SearchNationalityState searchNationalityState;
  final SearchNaturalityState searchNaturalityState;
  final DisabilityState getDisabilityState;
  final ProfileState getProfileState;
  final NeedAttachmentEditState getNeedAttachmentEditState;
  final PersonState getPersonState;
  final SearchEthnicityState searchEthnicityState;

  const EditPersonalDataScreenState({
    required this.updatePersonalDataState,
    required this.getEducationDegreeState,
    required this.searchNationalityState,
    required this.searchNaturalityState,
    required this.getDisabilityState,
    required this.getProfileState,
    required this.getNeedAttachmentEditState,
    required this.getPersonState,
    required this.searchEthnicityState,
  });

  CurrentEditPersonalDataScreenState currentState({
    UpdatePersonalDataState? updatePersonalDataState,
    EducationDegreeState? getEducationDegreeState,
    SearchNationalityState? searchNationalityState,
    SearchNaturalityState? searchNaturalityState,
    DisabilityState? getDisabilityState,
    ProfileState? getProfileState,
    NeedAttachmentEditState? getNeedAttachmentEditState,
    PersonState? getPersonState,
    SearchEthnicityState? searchEthnicityState,
  }) {
    return CurrentEditPersonalDataScreenState(
      updatePersonalDataState: updatePersonalDataState ?? this.updatePersonalDataState,
      getEducationDegreeState: getEducationDegreeState ?? this.getEducationDegreeState,
      searchNationalityState: searchNationalityState ?? this.searchNationalityState,
      searchNaturalityState: searchNaturalityState ?? this.searchNaturalityState,
      getDisabilityState: getDisabilityState ?? this.getDisabilityState,
      getProfileState: getProfileState ?? this.getProfileState,
      getNeedAttachmentEditState: getNeedAttachmentEditState ?? this.getNeedAttachmentEditState,
      getPersonState: getPersonState ?? this.getPersonState,
      searchEthnicityState: searchEthnicityState ?? this.searchEthnicityState,
    );
  }

  @override
  List<Object?> get props {
    return [
      updatePersonalDataState,
      getEducationDegreeState,
      searchNationalityState,
      searchNationalityState,
      searchNaturalityState,
      getDisabilityState,
      getProfileState,
      getNeedAttachmentEditState,
      getPersonState,
      searchEthnicityState,
    ];
  }
}

class CurrentEditPersonalDataScreenState extends EditPersonalDataScreenState {
  const CurrentEditPersonalDataScreenState({
    required UpdatePersonalDataState updatePersonalDataState,
    required EducationDegreeState getEducationDegreeState,
    required SearchNationalityState searchNationalityState,
    required SearchNaturalityState searchNaturalityState,
    required DisabilityState getDisabilityState,
    required ProfileState getProfileState,
    required NeedAttachmentEditState getNeedAttachmentEditState,
    required PersonState getPersonState,
    required SearchEthnicityState searchEthnicityState,
  }) : super(
          updatePersonalDataState: updatePersonalDataState,
          getEducationDegreeState: getEducationDegreeState,
          searchNationalityState: searchNationalityState,
          searchNaturalityState: searchNaturalityState,
          getDisabilityState: getDisabilityState,
          getProfileState: getProfileState,
          getNeedAttachmentEditState: getNeedAttachmentEditState,
          getPersonState: getPersonState,
          searchEthnicityState: searchEthnicityState,
        );
}
