import 'package:equatable/equatable.dart';

import '../../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../../blocs/public_feedbacks_bloc/public_feedbacks_state.dart';
import '../../../blocs/public_profile_bloc/public_profile_state.dart';

abstract class PublicProfileScreenState extends Equatable {
  final PublicProfileState publicProfileState;
  final AuthorizationState authorizationState;
  final PublicFeedbacksState publicFeedbacksState;

  const PublicProfileScreenState({
    required this.publicProfileState,
    required this.authorizationState,
    required this.publicFeedbacksState,
  });

  CurrentPublicProfileScreenState currentState({
    PublicProfileState? publicProfileState,
    AuthorizationState? authorizationState,
    PublicFeedbacksState? publicFeedbacksState,
  }) {
    return CurrentPublicProfileScreenState(
      publicProfileState: publicProfileState ?? this.publicProfileState,
      authorizationState: authorizationState ?? this.authorizationState,
      publicFeedbacksState: publicFeedbacksState ?? this.publicFeedbacksState,
    );
  }

  @override
  List<Object?> get props {
    return [
      publicProfileState,
      authorizationState,
      publicFeedbacksState,
    ];
  }
}

class CurrentPublicProfileScreenState extends PublicProfileScreenState {
  const CurrentPublicProfileScreenState({
    required PublicProfileState publicProfileState,
    required AuthorizationState authorizationState,
    required PublicFeedbacksState publicFeedbacksState,
  }) : super(
          publicProfileState: publicProfileState,
          authorizationState: authorizationState,
          publicFeedbacksState: publicFeedbacksState,
        );
}
