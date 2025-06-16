import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/civil_certificate_bloc/civil_certificate_bloc.dart';
import '../../../blocs/need_attachment_edit_bloc/need_attachment_edit_bloc.dart';
import '../../../blocs/person_bloc/person_bloc.dart';
import '../../../blocs/profile_bloc/profile_bloc.dart';
import '../../../blocs/search_country_bloc/search_country_bloc.dart';
import '../../../blocs/search_naturality/search_naturality_bloc.dart';
import '../../../blocs/update_personal_documents_bloc/update_personal_documents_bloc.dart';
import 'edit_personal_documents_screen_event.dart';
import 'edit_personal_documents_screen_state.dart';

class EditPersonalDocumentsScreenBloc extends Bloc<EditPersonalDocumentsScreenEvent, EditPersonalDocumentsScreenState> {
  final UpdatePersonalDocumentsBloc updatePersonalDocumentsBloc;
  final SearchCountryBloc searchCountryBloc;
  final SearchNaturalityBloc searchRicCityBloc;
  final ProfileBloc getProfileBloc;
  final NeedAttachmentEditBloc getNeedAttachmentEditBloc;
  final PersonBloc getPersonBloc;
  final CivilCertificateBloc getCivilCertificateBloc;
  final SearchNaturalityBloc searchCivilCityBloc;

  late StreamSubscription searchCountrySubscription;
  late StreamSubscription searchRicCitySubscription;
  late StreamSubscription searchCivilCitySubscription;
  late StreamSubscription getProfileSubscription;
  late StreamSubscription getNeedAttachmentSubscription;
  late StreamSubscription getPersonSubscription;
  late StreamSubscription getCivilCertificateSubscription;
  late StreamSubscription updatePersonalDocumentsSubscription;

  EditPersonalDocumentsScreenBloc({
    required this.searchCountryBloc,
    required this.searchRicCityBloc,
    required this.getProfileBloc,
    required this.getNeedAttachmentEditBloc,
    required this.getPersonBloc,
    required this.getCivilCertificateBloc,
    required this.searchCivilCityBloc,
    required this.updatePersonalDocumentsBloc,
  }) : super(
          CurrentEditPersonalDocumentsScreenState(
            searchCountryState: searchCountryBloc.state,
            searchRicCityState: searchRicCityBloc.state,
            getProfileState: getProfileBloc.state,
            getNeedAttachmentEditState: getNeedAttachmentEditBloc.state,
            getPersonState: getPersonBloc.state,
            getCivilCertificateState: getCivilCertificateBloc.state,
            searchCivilCityState: searchCivilCityBloc.state,
            updatePersonalDocumentsState: updatePersonalDocumentsBloc.state,
          ),
        ) {
    on<ChangeSearchRicCityDocumentsStateEvent>(_changeSearchRicCityDocumentsStateEvent);
    on<ChangeSearchCivilCityDocumentsStateEvent>(_changeSearchCivilCityDocumentsStateEvent);
    on<ChangeSearchCountryDocumentsStateEvent>(_changeSearchCountryDocumentsStateEvent);
    on<ChangeGetProfileDocumentsStateEvent>(_changeGetProfileDocumentsStateEvent);
    on<ChangeGetNeedAttachmentEditDocumentsStateEvent>(_changeGetNeedAttachmentEditDocumentsStateEvent);
    on<ChangeGetPersonDocumentsStateEvent>(_changeGetPersonDocumentsStateEvent);
    on<ChangeUpdatePersonalDocumentsStateEvent>(_changeEditPersonalDocumentsStateEvent);

    searchCountrySubscription = searchCountryBloc.stream.listen(
      (searchCountryState) {
        add(
          ChangeSearchCountryDocumentsStateEvent(
            searchCountryState: searchCountryState,
          ),
        );
      },
    );

    searchRicCitySubscription = searchRicCityBloc.stream.listen(
      (searchNaturalityState) {
        add(
          ChangeSearchRicCityDocumentsStateEvent(
            searchRicCityState: searchNaturalityState,
          ),
        );
      },
    );

    getProfileSubscription = getProfileBloc.stream.listen(
      (getProfileState) {
        add(
          ChangeGetProfileDocumentsStateEvent(
            getProfileState: getProfileState,
          ),
        );
      },
    );

    getNeedAttachmentSubscription = getNeedAttachmentEditBloc.stream.listen(
      (getNeedAttachmentState) {
        add(
          ChangeGetNeedAttachmentEditDocumentsStateEvent(
            getNeedAttachmentEditState: getNeedAttachmentState,
          ),
        );
      },
    );

    getPersonSubscription = getPersonBloc.stream.listen(
      (getPersonState) {
        add(
          ChangeGetPersonDocumentsStateEvent(
            getPersonState: getPersonState,
          ),
        );
      },
    );

    searchCivilCitySubscription = searchCivilCityBloc.stream.listen(
      (searchNaturalityState) {
        add(
          ChangeSearchCivilCityDocumentsStateEvent(
            searchCivilCityState: searchNaturalityState,
          ),
        );
      },
    );

    updatePersonalDocumentsSubscription = updatePersonalDocumentsBloc.stream.listen(
      (updatePersonalDocumentsState) {
        add(
          ChangeUpdatePersonalDocumentsStateEvent(
            updatePersonalDocumentsState: updatePersonalDocumentsState,
          ),
        );
      },
    );
  }

  Future<void> _changeSearchRicCityDocumentsStateEvent(
    ChangeSearchRicCityDocumentsStateEvent event,
    Emitter<EditPersonalDocumentsScreenState> emit,
  ) async {
    emit(
      state.currentState(
        searchRicCityState: event.searchRicCityState,
      ),
    );
  }

  Future<void> _changeSearchCivilCityDocumentsStateEvent(
    ChangeSearchCivilCityDocumentsStateEvent event,
    Emitter<EditPersonalDocumentsScreenState> emit,
  ) async {
    emit(
      state.currentState(
        searchCivilCityState: event.searchCivilCityState,
      ),
    );
  }

  Future<void> _changeSearchCountryDocumentsStateEvent(
    ChangeSearchCountryDocumentsStateEvent event,
    Emitter<EditPersonalDocumentsScreenState> emit,
  ) async {
    emit(
      state.currentState(
        searchCountryState: event.searchCountryState,
      ),
    );
  }

  Future<void> _changeGetProfileDocumentsStateEvent(
    ChangeGetProfileDocumentsStateEvent event,
    Emitter<EditPersonalDocumentsScreenState> emit,
  ) async {
    emit(
      state.currentState(
        getProfileState: event.getProfileState,
      ),
    );
  }

  Future<void> _changeGetNeedAttachmentEditDocumentsStateEvent(
    ChangeGetNeedAttachmentEditDocumentsStateEvent event,
    Emitter<EditPersonalDocumentsScreenState> emit,
  ) async {
    emit(
      state.currentState(
        getNeedAttachmentEditState: event.getNeedAttachmentEditState,
      ),
    );
  }

  Future<void> _changeGetPersonDocumentsStateEvent(
    ChangeGetPersonDocumentsStateEvent event,
    Emitter<EditPersonalDocumentsScreenState> emit,
  ) async {
    emit(
      state.currentState(
        getPersonState: event.getPersonState,
      ),
    );
  }

  Future<void> _changeEditPersonalDocumentsStateEvent(
    ChangeUpdatePersonalDocumentsStateEvent event,
    Emitter<EditPersonalDocumentsScreenState> emit,
  ) async {
    emit(
      state.currentState(
        updatePersonalDocumentsState: event.updatePersonalDocumentsState,
      ),
    );
  }

  @override
  Future<void> close() async {
    await getProfileSubscription.cancel();
    await getNeedAttachmentSubscription.cancel();
    await getPersonSubscription.cancel();
    await searchCountrySubscription.cancel();
    await searchRicCitySubscription.cancel();
    await searchCivilCitySubscription.cancel();
    await updatePersonalDocumentsSubscription.cancel();
    return super.close();
  }
}
