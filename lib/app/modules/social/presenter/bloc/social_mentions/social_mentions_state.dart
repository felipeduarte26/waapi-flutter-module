import 'package:equatable/equatable.dart';

import '../../../domain/entities/social_profile_entity.dart';

abstract class SocialMentionsState extends Equatable {
  final List<SocialProfileEntity> mentions;
  final String searchTerm;

  const SocialMentionsState({
    this.mentions = const <SocialProfileEntity>[],
    this.searchTerm = '',
  });

  LoadingSocialMentionsState loadingSocialMentionsState({
    required String searchTerm,
  }) {
    return LoadingSocialMentionsState(
      searchTerm: searchTerm,
    );
  }

  LoadedSocialMentionsState loadedSocialMentionsState({
    required List<SocialProfileEntity> mentions,
    required String searchTerm,
  }) {
    return LoadedSocialMentionsState(
      mentions: mentions,
      searchTerm: searchTerm,
    );
  }

  EmptySocialMentionsState emptySocialMentionsState({
    required String searchTerm,
  }) {
    return EmptySocialMentionsState(
      searchTerm: searchTerm,
    );
  }

  ErrorSocialMentionsState errorSocialMentionsState({
    required String searchTerm,
  }) {
    return ErrorSocialMentionsState(
      searchTerm: searchTerm,
    );
  }

  @override
  List<Object?> get props {
    return [
      searchTerm,
    ];
  }
}

class InitialSocialMentionsState extends SocialMentionsState {
  const InitialSocialMentionsState() : super();
}

class LoadingSocialMentionsState extends SocialMentionsState {
  const LoadingSocialMentionsState({
    required String searchTerm,
  }) : super(searchTerm: searchTerm);
}

class LoadedSocialMentionsState extends SocialMentionsState {
  const LoadedSocialMentionsState({
    required List<SocialProfileEntity> mentions,
    required String searchTerm,
  }) : super(
          mentions: mentions,
          searchTerm: searchTerm,
        );
}

class EmptySocialMentionsState extends SocialMentionsState {
  const EmptySocialMentionsState({
    required String searchTerm,
  }) : super(searchTerm: searchTerm);
}

class ErrorSocialMentionsState extends SocialMentionsState {
  const ErrorSocialMentionsState({
    required String searchTerm,
  }) : super(searchTerm: searchTerm);
}
