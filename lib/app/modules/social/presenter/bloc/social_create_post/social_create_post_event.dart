import 'package:equatable/equatable.dart';

import '../../../domain/intput_models/social_create_post_input_model.dart';

abstract class SocialCreatePostEvent extends Equatable {}

class CreateSocialPostEvent extends SocialCreatePostEvent {
  final SocialCreatePostInputModel socialCreatePostInputModel;

  CreateSocialPostEvent({
    required this.socialCreatePostInputModel,
  });

  @override
  List<Object> get props => [socialCreatePostInputModel];
}
