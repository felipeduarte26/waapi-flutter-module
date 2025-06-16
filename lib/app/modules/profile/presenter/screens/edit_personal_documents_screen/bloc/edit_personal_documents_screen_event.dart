import 'package:equatable/equatable.dart';

import '../../../blocs/need_attachment_edit_bloc/need_attachment_edit_state.dart';
import '../../../blocs/person_bloc/person_state.dart';
import '../../../blocs/profile_bloc/profile_state.dart';
import '../../../blocs/search_country_bloc/search_country_state.dart';
import '../../../blocs/search_naturality/search_naturality_state.dart';
import '../../../blocs/update_personal_documents_bloc/update_personal_documents_state.dart';

abstract class EditPersonalDocumentsScreenEvent extends Equatable {}

class ChangeUpdatePersonalDocumentsStateEvent extends EditPersonalDocumentsScreenEvent {
  final UpdatePersonalDocumentsState updatePersonalDocumentsState;

  ChangeUpdatePersonalDocumentsStateEvent({
    required this.updatePersonalDocumentsState,
  });

  @override
  List<Object?> get props {
    return [
      updatePersonalDocumentsState,
    ];
  }
}

class ChangeSearchCountryDocumentsStateEvent extends EditPersonalDocumentsScreenEvent {
  final SearchCountryState searchCountryState;

  ChangeSearchCountryDocumentsStateEvent({
    required this.searchCountryState,
  });

  @override
  List<Object?> get props {
    return [
      searchCountryState,
    ];
  }
}

class ChangeSearchRicCityDocumentsStateEvent extends EditPersonalDocumentsScreenEvent {
  final SearchNaturalityState searchRicCityState;

  ChangeSearchRicCityDocumentsStateEvent({
    required this.searchRicCityState,
  });

  @override
  List<Object?> get props {
    return [
      searchRicCityState,
    ];
  }
}

class ChangeSearchCivilCityDocumentsStateEvent extends EditPersonalDocumentsScreenEvent {
  final SearchNaturalityState searchCivilCityState;

  ChangeSearchCivilCityDocumentsStateEvent({
    required this.searchCivilCityState,
  });

  @override
  List<Object?> get props {
    return [
      searchCivilCityState,
    ];
  }
}

class ChangeGetProfileDocumentsStateEvent extends EditPersonalDocumentsScreenEvent {
  final ProfileState getProfileState;

  ChangeGetProfileDocumentsStateEvent({required this.getProfileState});

  @override
  List<Object?> get props {
    return [
      getProfileState,
    ];
  }
}

class ChangeGetNeedAttachmentEditDocumentsStateEvent extends EditPersonalDocumentsScreenEvent {
  final NeedAttachmentEditState getNeedAttachmentEditState;

  ChangeGetNeedAttachmentEditDocumentsStateEvent({required this.getNeedAttachmentEditState});

  @override
  List<Object?> get props {
    return [
      getNeedAttachmentEditState,
    ];
  }
}

class ChangeGetPersonDocumentsStateEvent extends EditPersonalDocumentsScreenEvent {
  final PersonState getPersonState;

  ChangeGetPersonDocumentsStateEvent({required this.getPersonState});

  @override
  List<Object?> get props {
    return [
      getPersonState,
    ];
  }
}
