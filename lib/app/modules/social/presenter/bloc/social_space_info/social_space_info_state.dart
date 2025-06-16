import 'package:equatable/equatable.dart';

import '../../../domain/entities/social_space_entity.dart';

abstract class SocialSpaceInfoState extends Equatable {
  final SocialSpaceEntity socialSpaceEntity;

  const SocialSpaceInfoState({
    this.socialSpaceEntity = const SocialSpaceEntity(
      spaceId: '',
      name: '',
      permaname: '',
    ),
  });

  @override
  List<Object?> get props {
    return [
      socialSpaceEntity,
    ];
  }
}

class InitialSocialSpaceInfoState extends SocialSpaceInfoState {}

class LoadingSocialSpaceInfoState extends SocialSpaceInfoState {}

class LoadedSocialSpaceInfoState extends SocialSpaceInfoState {
  const LoadedSocialSpaceInfoState({
    required SocialSpaceEntity socialSpaceEntity,
  }) : super(socialSpaceEntity: socialSpaceEntity);
}

class ErrorSocialSpaceInfoState extends SocialSpaceInfoState {}

class EmptySocialSpaceInfoState extends SocialSpaceInfoState {}
