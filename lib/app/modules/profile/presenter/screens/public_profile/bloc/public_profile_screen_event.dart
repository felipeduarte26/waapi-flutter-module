import 'package:equatable/equatable.dart';

import '../../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../../blocs/public_feedbacks_bloc/public_feedbacks_state.dart';
import '../../../blocs/public_profile_bloc/public_profile_state.dart';

abstract class PublicProfileScreenEvent extends Equatable {}

class ChangePublicProfileScreenEvent extends PublicProfileScreenEvent {
  final PublicProfileState publicProfileState;

  ChangePublicProfileScreenEvent({
    required this.publicProfileState,
  });

  @override
  List<Object?> get props {
    return [
      publicProfileState,
    ];
  }
}

class ChangeAuthorizationStateEvent extends PublicProfileScreenEvent {
  final AuthorizationState authorizationState;

  ChangeAuthorizationStateEvent({
    required this.authorizationState,
  });

  @override
  List<Object?> get props {
    return [
      authorizationState,
    ];
  }
}

class ChangePublicFeedbacksStateEvent extends PublicProfileScreenEvent {
  final PublicFeedbacksState publicFeedbacksState;

  ChangePublicFeedbacksStateEvent({
    required this.publicFeedbacksState,
  });

  @override
  List<Object?> get props {
    return [
      publicFeedbacksState,
    ];
  }
}
