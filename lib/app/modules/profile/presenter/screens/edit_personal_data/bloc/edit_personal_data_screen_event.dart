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

abstract class EditPersonalDataScreenEvent extends Equatable {}

class ChangeUpdatePersonalDataStateEvent extends EditPersonalDataScreenEvent {
  final UpdatePersonalDataState updatePersonalDataState;

  ChangeUpdatePersonalDataStateEvent({
    required this.updatePersonalDataState,
  });

  @override
  List<Object?> get props {
    return [
      updatePersonalDataState,
    ];
  }
}

class ChangeEducationDegreeStateEvent extends EditPersonalDataScreenEvent {
  final EducationDegreeState getEducationDegreeState;

  ChangeEducationDegreeStateEvent({
    required this.getEducationDegreeState,
  });

  @override
  List<Object?> get props {
    return [
      getEducationDegreeState,
    ];
  }
}

class ChangeSearchNationalityStateEvent extends EditPersonalDataScreenEvent {
  final SearchNationalityState searchNationalityState;

  ChangeSearchNationalityStateEvent({
    required this.searchNationalityState,
  });

  @override
  List<Object?> get props {
    return [
      searchNationalityState,
    ];
  }
}

class ChangeSearchNaturalityStateEvent extends EditPersonalDataScreenEvent {
  final SearchNaturalityState searchNaturalityState;

  ChangeSearchNaturalityStateEvent({
    required this.searchNaturalityState,
  });

  @override
  List<Object?> get props {
    return [
      searchNaturalityState,
    ];
  }
}

class ChangeDisabilityStateEvent extends EditPersonalDataScreenEvent {
  final DisabilityState getDisabilityState;

  ChangeDisabilityStateEvent({
    required this.getDisabilityState,
  });

  @override
  List<Object?> get props {
    return [
      getDisabilityState,
    ];
  }
}

class ChangeGetProfileStateEvent extends EditPersonalDataScreenEvent {
  final ProfileState getProfileState;

  ChangeGetProfileStateEvent({required this.getProfileState});

  @override
  List<Object?> get props {
    return [
      getProfileState,
    ];
  }
}

class ChangeGetNeedAttachmentEditStateEvent extends EditPersonalDataScreenEvent {
  final NeedAttachmentEditState getNeedAttachmentEditState;

  ChangeGetNeedAttachmentEditStateEvent({required this.getNeedAttachmentEditState});

  @override
  List<Object?> get props {
    return [
      getNeedAttachmentEditState,
    ];
  }
}

class ChangeGetPersonStateEvent extends EditPersonalDataScreenEvent {
  final PersonState getPersonState;

  ChangeGetPersonStateEvent({required this.getPersonState});

  @override
  List<Object?> get props {
    return [
      getPersonState,
    ];
  }
}

class ChangeSearchEthnicityBlocEvent extends EditPersonalDataScreenEvent {
  final SearchEthnicityState searchEthnicityState;

  ChangeSearchEthnicityBlocEvent({
    required this.searchEthnicityState,
  });

  @override
  List<Object?> get props {
    return [
      searchEthnicityState,
    ];
  }
}
