import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/address_by_postal_code_bloc/address_by_postal_code_bloc.dart';
import '../../../blocs/administrative_region_bloc/administrative_region_bloc.dart';
import '../../../blocs/need_attachment_edit_bloc/need_attachment_edit_bloc.dart';
import '../../../blocs/person_bloc/person_bloc.dart';
import '../../../blocs/profile_bloc/profile_bloc.dart';
import '../../../blocs/search_naturality/search_naturality_bloc.dart';
import '../../../blocs/update_personal_address_bloc/update_personal_address_bloc.dart';
import 'edit_personal_address_screen_event.dart';
import 'edit_personal_address_screen_state.dart';

class EditPersonalAddressScreenBloc extends Bloc<EditPersonalAddressScreenEvent, EditPersonalAddressScreenState> {
  final SearchNaturalityBloc searchCityBloc;
  final AdministrativeRegionBloc getAdministrativeRegionBloc;
  final ProfileBloc getProfileBloc;
  final NeedAttachmentEditBloc getNeedAttachmentEditBloc;
  final PersonBloc getPersonBloc;
  final AddressByPostalCodeBloc getAddressByPostalCodeBloc;
  final UpdatePersonalAddressBloc updatePersonalAddressBloc;

  late StreamSubscription searchCitySubscription;
  late StreamSubscription getAdministrativeRegionSubscription;
  late StreamSubscription getProfileSubscription;
  late StreamSubscription getNeedAttachmentSubscription;
  late StreamSubscription getPersonSubscription;
  late StreamSubscription getAddressByPostalCodeSubscription;
  late StreamSubscription updatePersonalAddressSubscription;

  EditPersonalAddressScreenBloc({
    required this.searchCityBloc,
    required this.getAdministrativeRegionBloc,
    required this.getProfileBloc,
    required this.getNeedAttachmentEditBloc,
    required this.getPersonBloc,
    required this.getAddressByPostalCodeBloc,
    required this.updatePersonalAddressBloc,
  }) : super(
          CurrentEditPersonalAddressScreenState(
            getAdministrativeRegionState: getAdministrativeRegionBloc.state,
            searchCityState: searchCityBloc.state,
            getProfileState: getProfileBloc.state,
            getNeedAttachmentEditState: getNeedAttachmentEditBloc.state,
            getPersonState: getPersonBloc.state,
            getAddressByPostalCodeState: getAddressByPostalCodeBloc.state,
            updatePersonalAddressState: updatePersonalAddressBloc.state,
          ),
        ) {
    on<ChangeSearchCityStateEvent>(_changeSearchCityStateEvent);
    on<ChangeGetProfileStateEvent>(_changeGetProfileStateEvent);
    on<ChangeGetNeedAttachmentEditStateEvent>(_changeGetNeedAttachmentEditStateEvent);
    on<ChangeGetPersonStateEvent>(_changeGetPersonStateEvent);
    on<ChangeGetAdministrativeRegionStateEvent>(_changeGetAdministrativeRegionStateEvent);
    on<ChangeGetAddressByPostalCodeStateEvent>(_changeGetAddressByPostalCodeStateEvent);
    on<ChangeUpdatePersonalAddressStateEvent>(_changeUpdatePersonalAddressStateEvent);

    searchCitySubscription = searchCityBloc.stream.listen(
      (searchCityState) {
        add(
          ChangeSearchCityStateEvent(
            searchCityState: searchCityState,
          ),
        );
      },
    );

    getAdministrativeRegionSubscription = getAdministrativeRegionBloc.stream.listen(
      (getAdministrativeRegionState) {
        add(
          ChangeGetAdministrativeRegionStateEvent(
            getAdministrativeRegionState: getAdministrativeRegionState,
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

    getAddressByPostalCodeSubscription = getAddressByPostalCodeBloc.stream.listen(
      (getAddressByPostalCode) {
        add(
          ChangeGetAddressByPostalCodeStateEvent(
            getAddressByPostalCodeState: getAddressByPostalCode,
          ),
        );
      },
    );

    updatePersonalAddressSubscription = updatePersonalAddressBloc.stream.listen(
      (updatePersonalAddressState) {
        add(
          ChangeUpdatePersonalAddressStateEvent(
            updatePersonalAddressState: updatePersonalAddressState,
          ),
        );
      },
    );
  }

  Future<void> _changeGetAdministrativeRegionStateEvent(
    ChangeGetAdministrativeRegionStateEvent event,
    Emitter<EditPersonalAddressScreenState> emit,
  ) async {
    emit(
      state.currentState(
        getAdministrativeRegionState: event.getAdministrativeRegionState,
      ),
    );
  }

  Future<void> _changeSearchCityStateEvent(
    ChangeSearchCityStateEvent event,
    Emitter<EditPersonalAddressScreenState> emit,
  ) async {
    emit(
      state.currentState(
        searchCityState: event.searchCityState,
      ),
    );
  }

  Future<void> _changeGetProfileStateEvent(
    ChangeGetProfileStateEvent event,
    Emitter<EditPersonalAddressScreenState> emit,
  ) async {
    emit(
      state.currentState(
        getProfileState: event.getProfileState,
      ),
    );
  }

  Future<void> _changeGetNeedAttachmentEditStateEvent(
    ChangeGetNeedAttachmentEditStateEvent event,
    Emitter<EditPersonalAddressScreenState> emit,
  ) async {
    emit(
      state.currentState(
        getNeedAttachmentEditState: event.getNeedAttachmentEditState,
      ),
    );
  }

  Future<void> _changeGetPersonStateEvent(
    ChangeGetPersonStateEvent event,
    Emitter<EditPersonalAddressScreenState> emit,
  ) async {
    emit(
      state.currentState(
        getPersonState: event.getPersonState,
      ),
    );
  }

  Future<void> _changeGetAddressByPostalCodeStateEvent(
    ChangeGetAddressByPostalCodeStateEvent event,
    Emitter<EditPersonalAddressScreenState> emit,
  ) async {
    emit(
      state.currentState(
        getAddressByPostalCodeState: event.getAddressByPostalCodeState,
      ),
    );
  }

  Future<void> _changeUpdatePersonalAddressStateEvent(
    ChangeUpdatePersonalAddressStateEvent event,
    Emitter<EditPersonalAddressScreenState> emit,
  ) async {
    emit(
      state.currentState(
        updatePersonalAddressState: event.updatePersonalAddressState,
      ),
    );
  }

  @override
  Future<void> close() async {
    await getAdministrativeRegionSubscription.cancel();
    await getProfileSubscription.cancel();
    await getNeedAttachmentSubscription.cancel();
    await getPersonSubscription.cancel();
    await searchCitySubscription.cancel();
    await getAddressByPostalCodeSubscription.cancel();
    await updatePersonalAddressSubscription.cancel();
    return super.close();
  }
}
