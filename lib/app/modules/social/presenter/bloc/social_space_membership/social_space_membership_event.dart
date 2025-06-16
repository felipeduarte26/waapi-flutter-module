import 'package:equatable/equatable.dart';

import '../../../infra/models/social_space_model.dart';

abstract class SocialSpaceMembershipEvent extends Equatable {}

class GetSocialSpaceMembershipEvent extends SocialSpaceMembershipEvent {
  final SocialSpaceModel socialSpaceModel;

  GetSocialSpaceMembershipEvent({required this.socialSpaceModel});

  @override
  List<Object?> get props => [socialSpaceModel];
}
