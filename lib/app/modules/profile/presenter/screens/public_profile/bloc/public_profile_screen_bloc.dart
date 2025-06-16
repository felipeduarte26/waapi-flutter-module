import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../authorization/presenter/blocs/authorization_bloc/authorization_bloc.dart';
import '../../../blocs/public_feedbacks_bloc/public_feedbacks_bloc.dart';
import '../../../blocs/public_profile_bloc/public_profile_bloc.dart';
import 'public_profile_screen_event.dart';
import 'public_profile_screen_state.dart';

class PublicProfileScreenBloc extends Bloc<PublicProfileScreenEvent, PublicProfileScreenState> {
  final PublicProfileBloc publicProfileBloc;
  final AuthorizationBloc authorizationBloc;
  final PublicFeedbacksBloc publicFeedbacksBloc;

  late StreamSubscription publicProfileSubscription;
  late StreamSubscription authorizationSubscription;
  late StreamSubscription publicFeedbacksSubscription;

  PublicProfileScreenBloc({
    required this.publicProfileBloc,
    required this.authorizationBloc,
    required this.publicFeedbacksBloc,
  }) : super(
          CurrentPublicProfileScreenState(
            publicProfileState: publicProfileBloc.state,
            authorizationState: authorizationBloc.state,
            publicFeedbacksState: publicFeedbacksBloc.state,
          ),
        ) {
    on<ChangePublicProfileScreenEvent>(_changePublicProfileScreenEvent);
    on<ChangeAuthorizationStateEvent>(_changeAuthorizationStateEvent);
    on<ChangePublicFeedbacksStateEvent>(_changePublicFeedbacksStateEvent);

    publicProfileSubscription = publicProfileBloc.stream.listen(
      (receivedFeedbacksBlocState) {
        add(
          ChangePublicProfileScreenEvent(
            publicProfileState: receivedFeedbacksBlocState,
          ),
        );
      },
    );

    authorizationSubscription = authorizationBloc.stream.listen(
      (authorizationBlocState) {
        add(
          ChangeAuthorizationStateEvent(
            authorizationState: authorizationBlocState,
          ),
        );
      },
    );

    publicFeedbacksSubscription = publicFeedbacksBloc.stream.listen(
      (publicFeedbacksState) {
        add(
          ChangePublicFeedbacksStateEvent(
            publicFeedbacksState: publicFeedbacksState,
          ),
        );
      },
    );
  }

  Future<void> _changePublicProfileScreenEvent(
    ChangePublicProfileScreenEvent event,
    Emitter<PublicProfileScreenState> emit,
  ) async {
    emit(
      state.currentState(
        publicProfileState: event.publicProfileState,
      ),
    );
  }

  Future<void> _changeAuthorizationStateEvent(
    ChangeAuthorizationStateEvent event,
    Emitter<PublicProfileScreenState> emit,
  ) async {
    emit(
      state.currentState(
        authorizationState: event.authorizationState,
      ),
    );
  }

  Future<void> _changePublicFeedbacksStateEvent(
    ChangePublicFeedbacksStateEvent event,
    Emitter<PublicProfileScreenState> emit,
  ) async {
    emit(
      state.currentState(
        publicFeedbacksState: event.publicFeedbacksState,
      ),
    );
  }

  @override
  Future<void> close() async {
    await publicProfileSubscription.cancel();
    await authorizationSubscription.cancel();
    await publicFeedbacksSubscription.cancel();
    return super.close();
  }
}
