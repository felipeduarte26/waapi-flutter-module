import 'package:equatable/equatable.dart';
import '../../../domain/entities/social_search_entity.dart';

abstract class SocialSearchState extends Equatable {
  final SocialSearchEntity? socialSearchResult;
  final bool getSpaceError;
  final bool getContentError;

  const SocialSearchState({
    this.getSpaceError = false,
    this.getContentError = false,
    this.socialSearchResult = const SocialSearchEntity(
      posts: [],
      tags: [],
      profiles: [],
      spaces: [],
    ),
  });

  InitialSocialSearchState initialSocialSearchState() {
    return InitialSocialSearchState();
  }

  LoadingSocialSearchState loadingSocialSearchState() {
    return LoadingSocialSearchState();
  }

  EmptySocialSearchState emptySocialSearchState() {
    return EmptySocialSearchState();
  }

  LoadingMoreSocialSearchState loadingMoreSocialSearchState() {
    return LoadingMoreSocialSearchState();
  }

  ErrorSocialSearchContentState errorSocialSearchContentState() {
    return ErrorSocialSearchContentState();
  }

  LoadedSocialSearchState loadedSocialSearchState({
    required SocialSearchEntity socialSearchResult,
    required bool getSpaceError,
    required bool getContentError,
  }) {
    return LoadedSocialSearchState(
      socialSearchResult: socialSearchResult,
      getSpaceError: getSpaceError,
      getContentError: getContentError,
    );
  }

  LoadedMoreSocialSearchState loadedMoreSocialSearchState({
    required SocialSearchEntity socialSearchResult,
    required bool getSpaceError,
    required bool getContentError,
  }) {
    return LoadedMoreSocialSearchState(
      socialSearchResult: socialSearchResult,
      getSpaceError: getSpaceError,
      getContentError: getContentError,
    );
  }

  CleanSocialSearchState cleanSearchPersonState() {
    return const CleanSocialSearchState();
  }

  @override
  List<Object?> get props {
    return [
      socialSearchResult,
    ];
  }
}

class InitialSocialSearchState extends SocialSearchState {}

class LoadingSocialSearchState extends SocialSearchState {}

class EmptySocialSearchState extends SocialSearchState {}

class LoadingMoreSocialSearchState extends SocialSearchState {}

class ErrorSocialSearchContentState extends SocialSearchState {}

class LoadedSocialSearchState extends SocialSearchState {
  const LoadedSocialSearchState({
    required SocialSearchEntity socialSearchResult,
    required bool getSpaceError,
    required bool getContentError,
  }) : super(
          socialSearchResult: socialSearchResult,
          getSpaceError: getSpaceError,
          getContentError: getContentError,
        );
}

class LoadedMoreSocialSearchState extends SocialSearchState {
  const LoadedMoreSocialSearchState({
    required SocialSearchEntity socialSearchResult,
    required bool getSpaceError,
    required bool getContentError,
  }) : super(
          socialSearchResult: socialSearchResult,
          getSpaceError: getSpaceError,
          getContentError: getContentError,
        );
}

class CleanSocialSearchState extends SocialSearchState {
  const CleanSocialSearchState() : super();
}
