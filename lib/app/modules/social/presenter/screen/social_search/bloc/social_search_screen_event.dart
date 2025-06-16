import 'package:equatable/equatable.dart';

import '../../../bloc/social_search/social_search_state.dart';
import '../../../bloc/social_space_info/social_space_info_state.dart';

abstract class SocialSearchScreenEvent extends Equatable {}

class ChangeSocialSearchEvent extends SocialSearchScreenEvent {
  final SocialSearchState socialSearchState;

  ChangeSocialSearchEvent({
    required this.socialSearchState,
  });

  @override
  List<Object?> get props => [
        socialSearchState,
      ];
}

class ChangeSocialSpaceInfoEvent extends SocialSearchScreenEvent {
  final SocialSpaceInfoState socialSpaceInfoState;

  ChangeSocialSpaceInfoEvent({
    required this.socialSpaceInfoState,
  });

  @override
  List<Object?> get props => [
        socialSpaceInfoState,
      ];
}
