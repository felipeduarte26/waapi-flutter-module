import 'package:equatable/equatable.dart';

import '../../../domain/entities/social_post_entity.dart';

abstract class SocialCreatePostState extends Equatable {
  const SocialCreatePostState();

  @override
  List<Object> get props => [];
}

class InitialSocialCreatePostState extends SocialCreatePostState {}

class LoadingSocialCreatePostState extends SocialCreatePostState {}

class CreatedSocialCreatePostState extends SocialCreatePostState {
  final SocialPostEntity socialPostEntity;

  const CreatedSocialCreatePostState({
    required this.socialPostEntity,
  });

  @override
  List<Object> get props => [socialPostEntity];
}

class ErrorSocialCreatePostState extends SocialCreatePostState {}
