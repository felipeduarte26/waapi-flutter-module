import 'package:equatable/equatable.dart';

import '../../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../../blocs/need_attachment_edit_bloc/need_attachment_edit_state.dart';
import '../../../blocs/person_bloc/person_state.dart';
import '../../../blocs/profile_bloc/profile_state.dart';
import '../../../blocs/update_personal_contact_bloc/update_personal_contact_state.dart';

abstract class EditPersonalContactScreenState extends Equatable {
  final UpdatePersonalContactState updatePersonalContactState;
  final NeedAttachmentEditState getNeedAttachmentEditState;
  final ProfileState getProfileState;
  final PersonState getPersonState;
  final AuthorizationState getAuthorizationState;

  const EditPersonalContactScreenState({
    required this.updatePersonalContactState,
    required this.getNeedAttachmentEditState,
    required this.getProfileState,
    required this.getPersonState,
    required this.getAuthorizationState,
  });

  CurrentEditPersonalContactScreenState currentState({
    UpdatePersonalContactState? updatePersonalContactState,
    ProfileState? getProfileState,
    NeedAttachmentEditState? getNeedAttachmentEditState,
    PersonState? getPersonState,
    AuthorizationState? getAuthorizationState,
  }) {
    return CurrentEditPersonalContactScreenState(
      updatePersonalContactState: updatePersonalContactState ?? this.updatePersonalContactState,
      getNeedAttachmentEditState: getNeedAttachmentEditState ?? this.getNeedAttachmentEditState,
      getProfileState: getProfileState ?? this.getProfileState,
      getPersonState: getPersonState ?? this.getPersonState,
      getAuthorizationState: getAuthorizationState ?? this.getAuthorizationState,
    );
  }

  @override
  List<Object?> get props {
    return [
      updatePersonalContactState,
      getNeedAttachmentEditState,
      getProfileState,
      getPersonState,
      getAuthorizationState,
    ];
  }
}

class CurrentEditPersonalContactScreenState extends EditPersonalContactScreenState {
  const CurrentEditPersonalContactScreenState({
    required UpdatePersonalContactState updatePersonalContactState,
    required NeedAttachmentEditState getNeedAttachmentEditState,
    required ProfileState getProfileState,
    required PersonState getPersonState,
    required AuthorizationState getAuthorizationState,
  }) : super(
          updatePersonalContactState: updatePersonalContactState,
          getNeedAttachmentEditState: getNeedAttachmentEditState,
          getProfileState: getProfileState,
          getPersonState: getPersonState,
          getAuthorizationState: getAuthorizationState,
        );
}
