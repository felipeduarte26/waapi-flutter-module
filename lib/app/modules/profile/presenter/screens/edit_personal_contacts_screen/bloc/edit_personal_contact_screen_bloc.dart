import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../authorization/presenter/blocs/authorization_bloc/authorization_bloc.dart';
import '../../../blocs/need_attachment_edit_bloc/need_attachment_edit_bloc.dart';
import '../../../blocs/person_bloc/person_bloc.dart';
import '../../../blocs/profile_bloc/profile_bloc.dart';
import '../../../blocs/update_personal_contact_bloc/update_personal_contact_bloc.dart';
import 'edit_personal_contact_screen_event.dart';
import 'edit_personal_contact_screen_state.dart';

class EditPersonalContactScreenBloc extends Bloc<EditPersonalContactScreenEvent, EditPersonalContactScreenState> {
  final UpdatePersonalContactBloc updatePersonalContactBloc;
  final NeedAttachmentEditBloc getNeedAttachmentEditBloc;
  final ProfileBloc getProfileBloc;
  final PersonBloc getPersonBloc;
  final AuthorizationBloc getAuthorizationBloc;

  late StreamSubscription updatePersonalContactSubscription;
  late StreamSubscription getNeedAttachmentSubscription;
  late StreamSubscription getProfileSubscription;
  late StreamSubscription getPersonSubscription;
  late StreamSubscription getPhoneContactSubscription;
  late StreamSubscription getAuthorizationSubscription;

  EditPersonalContactScreenBloc({
    required this.updatePersonalContactBloc,
    required this.getNeedAttachmentEditBloc,
    required this.getProfileBloc,
    required this.getPersonBloc,
    required this.getAuthorizationBloc,
  }) : super(
          CurrentEditPersonalContactScreenState(
            updatePersonalContactState: updatePersonalContactBloc.state,
            getNeedAttachmentEditState: getNeedAttachmentEditBloc.state,
            getProfileState: getProfileBloc.state,
            getPersonState: getPersonBloc.state,
            getAuthorizationState: getAuthorizationBloc.state,
          ),
        ) {
    on<ChangeUpdatePersonalContactStateEvent>(_changeEditPersonalContactStateEvent);
    on<ChangeGetNeedAttachmentEditStateEvent>(_changeGetNeedAttachmentEditStateEvent);
    on<ChangeGetProfileStateEvent>(_changeGetProfileStateEvent);
    on<ChangeGetPersonStateEvent>(_changeGetPersonStateEvent);
    on<ChangeGetAuthorizationStateEvent>(_changeGetAuthorizationStateEvent);

    updatePersonalContactSubscription = updatePersonalContactBloc.stream.listen(
      (updatePersonalContactState) {
        add(
          ChangeUpdatePersonalContactStateEvent(
            updatePersonalContactState: updatePersonalContactState,
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

    getProfileSubscription = getProfileBloc.stream.listen(
      (getProfileState) {
        add(
          ChangeGetProfileStateEvent(
            getProfileState: getProfileState,
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

    getAuthorizationSubscription = getAuthorizationBloc.stream.listen(
      (getAuthorizationState) {
        add(
          ChangeGetAuthorizationStateEvent(
            getAuthorizationState: getAuthorizationState,
          ),
        );
      },
    );
  }

  Future<void> _changeEditPersonalContactStateEvent(
    ChangeUpdatePersonalContactStateEvent event,
    Emitter<EditPersonalContactScreenState> emit,
  ) async {
    emit(
      state.currentState(
        updatePersonalContactState: event.updatePersonalContactState,
      ),
    );
  }

  Future<void> _changeGetNeedAttachmentEditStateEvent(
    ChangeGetNeedAttachmentEditStateEvent event,
    Emitter<EditPersonalContactScreenState> emit,
  ) async {
    emit(
      state.currentState(
        getNeedAttachmentEditState: event.getNeedAttachmentEditState,
      ),
    );
  }

  Future<void> _changeGetProfileStateEvent(
    ChangeGetProfileStateEvent event,
    Emitter<EditPersonalContactScreenState> emit,
  ) async {
    emit(
      state.currentState(
        getProfileState: event.getProfileState,
      ),
    );
  }

  Future<void> _changeGetPersonStateEvent(
    ChangeGetPersonStateEvent event,
    Emitter<EditPersonalContactScreenState> emit,
  ) async {
    emit(
      state.currentState(
        getPersonState: event.getPersonState,
      ),
    );
  }

  Future<void> _changeGetAuthorizationStateEvent(
    ChangeGetAuthorizationStateEvent event,
    Emitter<EditPersonalContactScreenState> emit,
  ) async {
    emit(
      state.currentState(
        getAuthorizationState: event.getAuthorizationState,
      ),
    );
  }

  @override
  Future<void> close() async {
    await updatePersonalContactSubscription.cancel();
    await getNeedAttachmentSubscription.cancel();
    await getProfileSubscription.cancel();
    await getPersonSubscription.cancel();
    await getAuthorizationSubscription.cancel();
    return super.close();
  }
}
