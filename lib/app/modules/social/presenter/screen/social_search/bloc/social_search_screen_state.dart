import 'package:equatable/equatable.dart';

import '../../../bloc/social_search/social_search_state.dart';
import '../../../bloc/social_space_info/social_space_info_state.dart';

class SocialSearchScreenState extends Equatable {
  final SocialSearchState socialSearchState;
  final SocialSpaceInfoState socialSpaceInfoState;

  const SocialSearchScreenState({
    required this.socialSearchState,
    required this.socialSpaceInfoState,
  });

  CurrentSocialSearchScreenState currentState({
    SocialSearchState? socialSearchState,
    SocialSpaceInfoState? socialSpaceInfoState,
  }) {
    return CurrentSocialSearchScreenState(
      socialSearchState: socialSearchState ?? this.socialSearchState,
      socialSpaceInfoState: socialSpaceInfoState ?? this.socialSpaceInfoState,
    );
  }

  @override
  List<Object?> get props => [
        socialSearchState,
        socialSpaceInfoState,
      ];
}

class CurrentSocialSearchScreenState extends SocialSearchScreenState {
  const CurrentSocialSearchScreenState({
    required SocialSearchState socialSearchState,
    required SocialSpaceInfoState socialSpaceInfoState,
  }) : super(
          socialSearchState: socialSearchState,
          socialSpaceInfoState: socialSpaceInfoState,
        );
}
