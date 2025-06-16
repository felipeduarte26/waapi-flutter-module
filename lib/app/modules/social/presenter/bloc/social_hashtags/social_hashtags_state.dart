import 'package:equatable/equatable.dart';

abstract class SocialHashtagsState extends Equatable {
  final List<String> tags;
  final String searchTerm;

  const SocialHashtagsState({
    this.tags = const <String>[],
    this.searchTerm = '',
  });

  LoadingSocialHashtagsState loadingSocialHashtagsState({
    required String searchTerm,
  }) {
    return LoadingSocialHashtagsState(
      searchTerm: searchTerm,
    );
  }

  LoadedSocialHashtagsState loadedSocialHashtagsState({
    required List<String> tags,
    required String searchTerm,
  }) {
    return LoadedSocialHashtagsState(
      tags: tags,
      searchTerm: searchTerm,
    );
  }

  EmptySocialHashtagsState emptySocialHashtagsState({
    required String searchTerm,
  }) {
    return EmptySocialHashtagsState(
      searchTerm: searchTerm,
    );
  }

  ErrorSocialHashtagsState errorSocialHashtagsState({
    required String searchTerm,
  }) {
    return ErrorSocialHashtagsState(
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

class InitialSocialHashtagsState extends SocialHashtagsState {
  const InitialSocialHashtagsState() : super();
}

class LoadingSocialHashtagsState extends SocialHashtagsState {
  const LoadingSocialHashtagsState({
    required String searchTerm,
  }) : super(searchTerm: searchTerm);
}

class LoadedSocialHashtagsState extends SocialHashtagsState {
  const LoadedSocialHashtagsState({
    required List<String> tags,
    required String searchTerm,
  }) : super(
          tags: tags,
          searchTerm: searchTerm,
        );
}

class EmptySocialHashtagsState extends SocialHashtagsState {
  const EmptySocialHashtagsState({
    required String searchTerm,
  }) : super(searchTerm: searchTerm);
}

class ErrorSocialHashtagsState extends SocialHashtagsState {
  const ErrorSocialHashtagsState({
    required String searchTerm,
  }) : super(searchTerm: searchTerm);
}
