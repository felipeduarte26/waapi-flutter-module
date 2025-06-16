import 'package:equatable/equatable.dart';

import '../../../domain/entities/social_space_entity.dart';

abstract class SocialSpaceListState extends Equatable {
  final List<SocialSpaceEntity> socialSpaceEntityList;

  const SocialSpaceListState({
    this.socialSpaceEntityList = const [],
  });

  @override
  List<Object?> get props {
    return [
      socialSpaceEntityList,
    ];
  }
}

class InitialSocialSpaceListState extends SocialSpaceListState {}

class LoadingSocialSpaceListState extends SocialSpaceListState {}

class LoadingMoreSocialSpaceListState extends SocialSpaceListState {
  const LoadingMoreSocialSpaceListState({required super.socialSpaceEntityList});
}

class EmptySocialSpaceListState extends SocialSpaceListState {}

class EmptyLoadedMoreSocialSpaceListState extends SocialSpaceListState {
  const EmptyLoadedMoreSocialSpaceListState({required super.socialSpaceEntityList});
}

class LoadedSocialSpaceListState extends SocialSpaceListState {
  const LoadedSocialSpaceListState({
    required List<SocialSpaceEntity> socialSpaceEntityList,
  }) : super(socialSpaceEntityList: socialSpaceEntityList);
}

class LoadedMoreSocialSpaceListState extends SocialSpaceListState {
  const LoadedMoreSocialSpaceListState({
    required List<SocialSpaceEntity> socialSpaceEntityList,
  }) : super(socialSpaceEntityList: socialSpaceEntityList);
}

class ErrorSocialSpaceListState extends SocialSpaceListState {
  const ErrorSocialSpaceListState({required super.socialSpaceEntityList});
}

class ErrorLoadedMoreSocialSpaceListState extends SocialSpaceListState {
  const ErrorLoadedMoreSocialSpaceListState({required super.socialSpaceEntityList});
}
