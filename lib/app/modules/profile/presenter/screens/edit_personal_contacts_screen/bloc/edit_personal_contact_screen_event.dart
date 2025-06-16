import 'package:equatable/equatable.dart';

import '../../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../../blocs/need_attachment_edit_bloc/need_attachment_edit_state.dart';
import '../../../blocs/person_bloc/person_state.dart';
import '../../../blocs/profile_bloc/profile_state.dart';
import '../../../blocs/update_personal_contact_bloc/update_personal_contact_state.dart';

abstract class EditPersonalContactScreenEvent extends Equatable {}

class ChangeUpdatePersonalContactStateEvent extends EditPersonalContactScreenEvent {
  final UpdatePersonalContactState updatePersonalContactState;

  ChangeUpdatePersonalContactStateEvent({
    required this.updatePersonalContactState,
  });

  @override
  List<Object?> get props {
    return [
      updatePersonalContactState,
    ];
  }
}

class ChangeGetNeedAttachmentEditStateEvent extends EditPersonalContactScreenEvent {
  final NeedAttachmentEditState getNeedAttachmentEditState;

  ChangeGetNeedAttachmentEditStateEvent({required this.getNeedAttachmentEditState});

  @override
  List<Object?> get props {
    return [
      getNeedAttachmentEditState,
    ];
  }
}

class ChangeGetProfileStateEvent extends EditPersonalContactScreenEvent {
  final ProfileState getProfileState;

  ChangeGetProfileStateEvent({required this.getProfileState});

  @override
  List<Object?> get props {
    return [
      getProfileState,
    ];
  }
}

class ChangeGetPersonStateEvent extends EditPersonalContactScreenEvent {
  final PersonState getPersonState;

  ChangeGetPersonStateEvent({required this.getPersonState});

  @override
  List<Object?> get props {
    return [
      getPersonState,
    ];
  }
}

class ChangeGetAuthorizationStateEvent extends EditPersonalContactScreenEvent {
  final AuthorizationState getAuthorizationState;

  ChangeGetAuthorizationStateEvent({required this.getAuthorizationState});

  @override
  List<Object?> get props {
    return [
      getAuthorizationState,
    ];
  }
}
