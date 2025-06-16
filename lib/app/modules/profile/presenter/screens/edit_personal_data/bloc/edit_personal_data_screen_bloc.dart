import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/disability_bloc/disability_bloc.dart';
import '../../../blocs/education_degree_bloc/education_degree_bloc.dart';
import '../../../blocs/need_attachment_edit_bloc/need_attachment_edit_bloc.dart';
import '../../../blocs/person_bloc/person_bloc.dart';
import '../../../blocs/profile_bloc/profile_bloc.dart';
import '../../../blocs/search_ethnicity_bloc/search_ethnicity_bloc.dart';
import '../../../blocs/search_nationality/search_nationality_bloc.dart';
import '../../../blocs/search_naturality/search_naturality_bloc.dart';
import '../../../blocs/update_personal_data_bloc/update_personal_data_bloc.dart';
import 'edit_personal_data_screen_event.dart';
import 'edit_personal_data_screen_state.dart';

class EditPersonalDataScreenBloc extends Bloc<EditPersonalDataScreenEvent, EditPersonalDataScreenState> {
  final UpdatePersonalDataBloc updatePersonalDataBloc;
  final EducationDegreeBloc getEducationDegreeBloc;
  final SearchNationalityBloc searchNationalityBloc;
  final SearchNaturalityBloc searchNaturalityBloc;
  final DisabilityBloc getDisabilityBloc;
  final ProfileBloc getProfileBloc;
  final NeedAttachmentEditBloc getNeedAttachmentEditBloc;
  final PersonBloc getPersonBloc;
  final SearchEthnicityBloc searchEthnicityBloc;

  late StreamSubscription updatePersonalDataSubscription;
  late StreamSubscription getEducationDegreeSubscription;
  late StreamSubscription searchNationalitySubscription;
  late StreamSubscription searchNaturalitySubscription;
  late StreamSubscription getDisabilitySubscription;
  late StreamSubscription getProfileSubscription;
  late StreamSubscription getNeedAttachmentSubscription;
  late StreamSubscription getPersonSubscription;
  late StreamSubscription searchEthnicitySubscription;

  EditPersonalDataScreenBloc({
    required this.updatePersonalDataBloc,
    required this.getEducationDegreeBloc,
    required this.searchNationalityBloc,
    required this.searchNaturalityBloc,
    required this.getDisabilityBloc,
    required this.getProfileBloc,
    required this.getNeedAttachmentEditBloc,
    required this.getPersonBloc,
    required this.searchEthnicityBloc,
  }) : super(
          CurrentEditPersonalDataScreenState(
            updatePersonalDataState: updatePersonalDataBloc.state,
            getDisabilityState: getDisabilityBloc.state,
            getEducationDegreeState: getEducationDegreeBloc.state,
            searchNationalityState: searchNationalityBloc.state,
            searchNaturalityState: searchNaturalityBloc.state,
            getProfileState: getProfileBloc.state,
            getNeedAttachmentEditState: getNeedAttachmentEditBloc.state,
            getPersonState: getPersonBloc.state,
            searchEthnicityState: searchEthnicityBloc.state,
          ),
        ) {
    on<ChangeUpdatePersonalDataStateEvent>(_changeEditPersonalDataStateEvent);
    on<ChangeEducationDegreeStateEvent>(_changeGetEducationDegreeStateEvent);
    on<ChangeSearchNaturalityStateEvent>(_changeSearchNaturalityStateEvent);
    on<ChangeSearchNationalityStateEvent>(_changeSearchNationalityStateEvent);
    on<ChangeDisabilityStateEvent>(_changeGetDisabilityStateEvent);
    on<ChangeGetProfileStateEvent>(_changeGetProfileStateEvent);
    on<ChangeGetNeedAttachmentEditStateEvent>(_changeGetNeedAttachmentEditStateEvent);
    on<ChangeGetPersonStateEvent>(_changeGetPersonStateEvent);
    on<ChangeSearchEthnicityBlocEvent>(_changeSearchEthnicityBlocEvent);
    updatePersonalDataSubscription = updatePersonalDataBloc.stream.listen(
      (updatePersonalDataState) {
        add(
          ChangeUpdatePersonalDataStateEvent(
            updatePersonalDataState: updatePersonalDataState,
          ),
        );
      },
    );

    getEducationDegreeSubscription = getEducationDegreeBloc.stream.listen(
      (educationDegreeState) {
        add(
          ChangeEducationDegreeStateEvent(
            getEducationDegreeState: educationDegreeState,
          ),
        );
      },
    );

    searchNationalitySubscription = searchNationalityBloc.stream.listen(
      (searchNationalityState) {
        add(
          ChangeSearchNationalityStateEvent(
            searchNationalityState: searchNationalityState,
          ),
        );
      },
    );

    searchNaturalitySubscription = searchNaturalityBloc.stream.listen(
      (searchNaturalityState) {
        add(
          ChangeSearchNaturalityStateEvent(
            searchNaturalityState: searchNaturalityState,
          ),
        );
      },
    );

    getDisabilitySubscription = getDisabilityBloc.stream.listen(
      (getDisabilityState) {
        add(
          ChangeDisabilityStateEvent(
            getDisabilityState: getDisabilityState,
          ),
        );
      },
    );

    getProfileSubscription = getProfileBloc.stream.listen(
      (getProfileState) {
        add(
          ChangeGetProfileStateEvent(
            getProfileState: getProfileState,
          ),
        );
      },
    );

    getNeedAttachmentSubscription = getNeedAttachmentEditBloc.stream.listen(
      (getNeedAttachmentState) {
        add(
          ChangeGetNeedAttachmentEditStateEvent(
            getNeedAttachmentEditState: getNeedAttachmentState,
          ),
        );
      },
    );

    getPersonSubscription = getPersonBloc.stream.listen(
      (getPersonState) {
        add(
          ChangeGetPersonStateEvent(
            getPersonState: getPersonState,
          ),
        );
      },
    );

    searchEthnicitySubscription = searchEthnicityBloc.stream.listen(
      (searchEthnicityState) {
        add(
          ChangeSearchEthnicityBlocEvent(
            searchEthnicityState: searchEthnicityState,
          ),
        );
      },
    );
  }

  Future<void> _changeEditPersonalDataStateEvent(
    ChangeUpdatePersonalDataStateEvent event,
    Emitter<EditPersonalDataScreenState> emit,
  ) async {
    emit(
      state.currentState(
        updatePersonalDataState: event.updatePersonalDataState,
      ),
    );
  }

  Future<void> _changeGetEducationDegreeStateEvent(
    ChangeEducationDegreeStateEvent event,
    Emitter<EditPersonalDataScreenState> emit,
  ) async {
    emit(
      state.currentState(
        getEducationDegreeState: event.getEducationDegreeState,
      ),
    );
  }

  Future<void> _changeGetDisabilityStateEvent(
    ChangeDisabilityStateEvent event,
    Emitter<EditPersonalDataScreenState> emit,
  ) async {
    emit(
      state.currentState(
        getDisabilityState: event.getDisabilityState,
      ),
    );
  }

  Future<void> _changeSearchNaturalityStateEvent(
    ChangeSearchNaturalityStateEvent event,
    Emitter<EditPersonalDataScreenState> emit,
  ) async {
    emit(
      state.currentState(
        searchNaturalityState: event.searchNaturalityState,
      ),
    );
  }

  Future<void> _changeSearchNationalityStateEvent(
    ChangeSearchNationalityStateEvent event,
    Emitter<EditPersonalDataScreenState> emit,
  ) async {
    emit(
      state.currentState(
        searchNationalityState: event.searchNationalityState,
      ),
    );
  }

  Future<void> _changeGetProfileStateEvent(
    ChangeGetProfileStateEvent event,
    Emitter<EditPersonalDataScreenState> emit,
  ) async {
    emit(
      state.currentState(
        getProfileState: event.getProfileState,
      ),
    );
  }

  Future<void> _changeGetNeedAttachmentEditStateEvent(
    ChangeGetNeedAttachmentEditStateEvent event,
    Emitter<EditPersonalDataScreenState> emit,
  ) async {
    emit(
      state.currentState(
        getNeedAttachmentEditState: event.getNeedAttachmentEditState,
      ),
    );
  }

  Future<void> _changeGetPersonStateEvent(
    ChangeGetPersonStateEvent event,
    Emitter<EditPersonalDataScreenState> emit,
  ) async {
    emit(
      state.currentState(
        getPersonState: event.getPersonState,
      ),
    );
  }

  Future<void> _changeSearchEthnicityBlocEvent(
    ChangeSearchEthnicityBlocEvent event,
    Emitter<EditPersonalDataScreenState> emit,
  ) async {
    emit(
      state.currentState(
        searchEthnicityState: event.searchEthnicityState,
      ),
    );
  }

  @override
  Future<void> close() async {
    await updatePersonalDataSubscription.cancel();
    await getEducationDegreeSubscription.cancel();
    await getDisabilitySubscription.cancel();
    await getProfileSubscription.cancel();
    await getNeedAttachmentSubscription.cancel();
    await getPersonSubscription.cancel();
    await searchNationalitySubscription.cancel();
    await searchNaturalitySubscription.cancel();
    await searchEthnicitySubscription.cancel();
    return super.close();
  }
}
