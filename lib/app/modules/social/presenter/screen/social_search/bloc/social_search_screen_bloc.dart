import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/social_search/social_search_bloc.dart';
import '../../../bloc/social_space_info/social_space_info_bloc.dart';
import 'social_search_screen_event.dart';
import 'social_search_screen_state.dart';

class SocialSearchScreenBloc extends Bloc<SocialSearchScreenEvent, SocialSearchScreenState> {
  late final SocialSearchBloc socialSearchBloc;
  late final SocialSpaceInfoBloc socialSpaceInfoBloc;

  late StreamSubscription socialSearchSubscription;
  late final StreamSubscription socialSpaceInfoSubscription;

  SocialSearchScreenBloc({
    required this.socialSearchBloc,
    required this.socialSpaceInfoBloc,
  }) : super(
          CurrentSocialSearchScreenState(
            socialSearchState: socialSearchBloc.state,
            socialSpaceInfoState: socialSpaceInfoBloc.state,
          ),
        ) {
    on<ChangeSocialSearchEvent>(_changeSocialSearchEvent);
    on<ChangeSocialSpaceInfoEvent>(_changeSocialSpaceInfoEvent);

    socialSearchSubscription = socialSearchBloc.stream.listen(
      (socialSearchState) {
        add(
          ChangeSocialSearchEvent(socialSearchState: socialSearchState),
        );
      },
    );

    socialSpaceInfoSubscription = socialSpaceInfoBloc.stream.listen(
      (socialSpaceInfoState) {
        add(
          ChangeSocialSpaceInfoEvent(socialSpaceInfoState: socialSpaceInfoState),
        );
      },
    );
  }

  Future<void> _changeSocialSearchEvent(
    ChangeSocialSearchEvent event,
    Emitter<SocialSearchScreenState> emit,
  ) async {
    emit(
      state.currentState(
        socialSearchState: event.socialSearchState,
      ),
    );
  }

  Future<void> _changeSocialSpaceInfoEvent(
    ChangeSocialSpaceInfoEvent event,
    Emitter<SocialSearchScreenState> emit,
  ) async {
    emit(
      state.currentState(
        socialSpaceInfoState: event.socialSpaceInfoState,
      ),
    );
  }
}
