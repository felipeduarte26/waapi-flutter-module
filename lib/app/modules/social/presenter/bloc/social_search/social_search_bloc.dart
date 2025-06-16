import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/social_search_entity.dart';
import '../../../domain/usecases/get_social_search_content_usecase.dart';
import '../../../domain/usecases/get_social_search_space_usecase.dart';
import 'social_search_bloc_event_transformer.dart';
import 'social_search_event.dart';
import 'social_search_state.dart';

class SocialSearchBloc extends Bloc<SocialSearchEvent, SocialSearchState> {
  final GetSocialSearchContentUsecase _getSocialSearchResultUsecase;
  final GetSocialSearchSpaceUsecase _getSocialSearchSpaceUsecase;
  bool erroContent = false;
  bool errorSpace = false;

  SocialSearchBloc({
    required GetSocialSearchContentUsecase getSocialSearchResultUsecase,
    required GetSocialSearchSpaceUsecase getSocialSearchSpaceUsecase,
  })  : _getSocialSearchResultUsecase = getSocialSearchResultUsecase,
        _getSocialSearchSpaceUsecase = getSocialSearchSpaceUsecase,
        super(InitialSocialSearchState()) {
    on<GetSocialSearchResultEvent>(
      _getSocialSearchResultEvent,
      transformer: debounce(
        const Duration(
          milliseconds: 600,
        ),
      ),
    );
    on<GetSocialSearchMoreResultEvent>(
      _getSocialSearchMoreResultEvent,
    );
  }

  Future<void> _getSocialSearchResultEvent(
    GetSocialSearchResultEvent event,
    Emitter<SocialSearchState> emit,
  ) async {
    final bool isInvalidTerm = event.query.trim().length < 2;
    if (isInvalidTerm) {
      emit(state.cleanSearchPersonState());
      return;
    }

    var socialSearchEntityResult = const SocialSearchEntity(
      posts: [],
      tags: [],
      profiles: [],
      spaces: [],
    );
    bool errorSpace = false;
    bool erroContent = false;

    emit(state.loadingSocialSearchState());

    final resultContent = await getSocialSearchResult(
      query: event.query,
      socialSearchEntityResult: socialSearchEntityResult,
      from: 0,
      batchSize: 5,
      maxRequests: 4,
    );
    socialSearchEntityResult = resultContent.$1;
    erroContent = resultContent.$2;

    final spaceResult = await getSocialSearchSpace(
      query: event.query,
      socialSearchEntityResult: socialSearchEntityResult,
    );

    socialSearchEntityResult = spaceResult.$1;
    errorSpace = spaceResult.$2;

    if (errorSpace && erroContent) {
      return emit(ErrorSocialSearchContentState());
    }

    if (socialSearchEntityResult.isEmpty) {
      emit(state.emptySocialSearchState());
      return;
    }

    return emit(
      state.loadedSocialSearchState(
        socialSearchResult: socialSearchEntityResult,
        getContentError: erroContent,
        getSpaceError: errorSpace,
      ),
    );
  }

  Future<void> _getSocialSearchMoreResultEvent(
    GetSocialSearchMoreResultEvent event,
    Emitter<SocialSearchState> emit,
  ) async {
    var socialSearchEntityResult = const SocialSearchEntity(
      posts: [],
      tags: [],
      profiles: [],
      spaces: [],
    );
    if (state is LoadedSocialSearchState || state is LoadedMoreSocialSearchState) {
      socialSearchEntityResult = state.socialSearchResult ?? socialSearchEntityResult;
      emit(state.loadingMoreSocialSearchState());
    } else {
      return;
    }

    if (socialSearchEntityResult.isEmpty) {
      emit(state.emptySocialSearchState());
      return;
    }

    final result = await getSocialSearchResult(
      query: event.query,
      from: event.from,
      socialSearchEntityResult: socialSearchEntityResult,
    );

    socialSearchEntityResult = result.$1;
    erroContent = result.$2;

    emit(
      state.loadedMoreSocialSearchState(
        socialSearchResult: socialSearchEntityResult,
        getContentError: erroContent,
        getSpaceError: errorSpace,
      ),
    );
  }

  Future<(SocialSearchEntity, bool)> getSocialSearchSpace({
    required String query,
    required SocialSearchEntity socialSearchEntityResult,
  }) async {
    var socialSearchEntity = socialSearchEntityResult;
    bool hasError = false;

    final socialSpace = await _getSocialSearchSpaceUsecase(query: query);

    socialSpace.fold(
      (left) => hasError = true,
      (right) {
        socialSearchEntity = socialSearchEntityResult.copyWith(
          spaces: [...socialSearchEntityResult.spaces, ...right],
        );
      },
    );

    return (socialSearchEntity, hasError);
  }

  Future<(SocialSearchEntity, bool)> getSocialSearchResult({
    required String query,
    required int from,
    required SocialSearchEntity socialSearchEntityResult,
    int maxRequests = 1,
    int batchSize = 5,
  }) async {
    var socialSearchEntity = socialSearchEntityResult;
    bool hasError = false;

    final socialSearchResult = await _getSocialSearchResultUsecase(
      query: query,
      from: from,
      batchSize: batchSize,
      maxRequests: maxRequests,
    );

    socialSearchResult.fold(
      (left) => hasError = true,
      (right) {
        socialSearchEntity = socialSearchEntityResult.copyWith(
          posts: [...socialSearchEntityResult.posts, ...right.posts],
          tags: [...socialSearchEntityResult.tags, ...right.tags],
          profiles: [...socialSearchEntityResult.profiles, ...right.profiles],
        );
      },
    );

    return (socialSearchEntity, hasError);
  }
}
