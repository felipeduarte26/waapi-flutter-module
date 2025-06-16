import 'package:equatable/equatable.dart';

import '../../../domain/entities/social_profile_entity.dart';

abstract class SocialListMembersState extends Equatable {
  final List<SocialProfileEntity> socialProfiles;
  final String searchTerm;

  const SocialListMembersState({
    this.socialProfiles = const <SocialProfileEntity>[],
    this.searchTerm = '',
  });

  LoadingSocialListMembersState loadingSocialListMembersState({
    required String searchTerm,
  }) {
    return LoadingSocialListMembersState(
      searchTerm: searchTerm,
    );
  }

  LoadedSocialListMembersState loadedSocialListMembersState({
    required List<SocialProfileEntity> socialProfiles,
    required String searchTerm,
  }) {
    return LoadedSocialListMembersState(
      socialProfiles: socialProfiles,
      searchTerm: searchTerm,
    );
  }

  LastPageSocialListMembersState lastPageSocialListMembersState({
    required List<SocialProfileEntity> socialProfiles,
    required String searchTerm,
  }) {
    return LastPageSocialListMembersState(
      socialProfiles: socialProfiles,
      searchTerm: searchTerm,
    );
  }

  EmptySocialListMembersState emptySocialListMembersState({
    required String searchTerm,
  }) {
    return EmptySocialListMembersState(
      searchTerm: searchTerm,
    );
  }

  ErrorSocialListMembersState errorSocialListMembersState({
    required String searchTerm,
  }) {
    return ErrorSocialListMembersState(
      searchTerm: searchTerm,
    );
  }

  LoadingMoreSocialListMembersState loadingMoreSocialListMembersState({
    required List<SocialProfileEntity> socialProfiles,
    required String searchTerm,
  }) {
    return LoadingMoreSocialListMembersState(
      socialProfiles: socialProfiles,
      searchTerm: searchTerm,
    );
  }

  ErrorMoreSocialListMembersState errorMoreSocialListMembersState({
    required List<SocialProfileEntity> socialProfiles,
    required String searchTerm,
  }) {
    return ErrorMoreSocialListMembersState(
      socialProfiles: socialProfiles,
      searchTerm: searchTerm,
    );
  }

  CleanSocialListMembersState cleanSocialListMembersState() {
    return const CleanSocialListMembersState();
  }

  @override
  List<Object?> get props {
    return [];
  }
}

class InitialSocialListMembersState extends SocialListMembersState {
  const InitialSocialListMembersState() : super();
}

class LoadingSocialListMembersState extends SocialListMembersState {
  const LoadingSocialListMembersState({
    required String searchTerm,
  }) : super(searchTerm: searchTerm);
}

class LoadingMoreSocialListMembersState extends SocialListMembersState {
  const LoadingMoreSocialListMembersState({
    required List<SocialProfileEntity> socialProfiles,
    required String searchTerm,
  }) : super(
          socialProfiles: socialProfiles,
          searchTerm: searchTerm,
        );
}

class LoadedSocialListMembersState extends SocialListMembersState {
  const LoadedSocialListMembersState({
    required List<SocialProfileEntity> socialProfiles,
    required String searchTerm,
  }) : super(
          socialProfiles: socialProfiles,
          searchTerm: searchTerm,
        );
}

class LastPageSocialListMembersState extends SocialListMembersState {
  const LastPageSocialListMembersState({
    required List<SocialProfileEntity> socialProfiles,
    required String searchTerm,
  }) : super(
          socialProfiles: socialProfiles,
          searchTerm: searchTerm,
        );
}

class EmptySocialListMembersState extends SocialListMembersState {
  const EmptySocialListMembersState({
    required String searchTerm,
  }) : super(searchTerm: searchTerm);
}

class ErrorSocialListMembersState extends SocialListMembersState {
  const ErrorSocialListMembersState({
    required String searchTerm,
  }) : super(searchTerm: searchTerm);
}

class ErrorMoreSocialListMembersState extends SocialListMembersState {
  const ErrorMoreSocialListMembersState({
    required List<SocialProfileEntity> socialProfiles,
    required String searchTerm,
  }) : super(
          socialProfiles: socialProfiles,
          searchTerm: searchTerm,
        );
}

class CleanSocialListMembersState extends SocialListMembersState {
  const CleanSocialListMembersState() : super();
}
