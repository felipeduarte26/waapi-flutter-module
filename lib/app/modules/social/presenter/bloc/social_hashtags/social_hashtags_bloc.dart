import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_hashtags_usecase.dart';
import 'social_hashtags_bloc_event_transformer.dart';
import 'social_hashtags_event.dart';
import 'social_hashtags_state.dart';

class SocialHashtagsBloc extends Bloc<SocialHashtagsEvent, SocialHashtagsState> {
  final GetHashtagsUsecase _getHashtagsUsecase;

  SocialHashtagsBloc({
    required GetHashtagsUsecase getHashtagsUsecase,
  })  : _getHashtagsUsecase = getHashtagsUsecase,
        super(const InitialSocialHashtagsState()) {
    on<GetSocialHashtagsEvent>(
      _getSocialHashtagsEvent,
      transformer: debounce(
        const Duration(
          milliseconds: 300,
        ),
      ),
    );
    on<ClearSocialHashtagsEvent>(_clearSocialHashtagsEvent);
  }

  Future<void> _getSocialHashtagsEvent(
    GetSocialHashtagsEvent event,
    Emitter<SocialHashtagsState> emit,
  ) async {
    final query = event.query.trim();
    emit(
      state.loadingSocialHashtagsState(
        searchTerm: query,
      ),
    );

    final tags = await _getHashtagsUsecase.call(
      query: query,
    );

    tags.fold(
      (left) {
        emit(
          state.errorSocialHashtagsState(
            searchTerm: query,
          ),
        );
      },
      (right) {
        if (right.isEmpty) {
          emit(
            state.emptySocialHashtagsState(
              searchTerm: query,
            ),
          );
        } else {
          emit(
            state.loadedSocialHashtagsState(
              tags: right,
              searchTerm: state.searchTerm.trim(),
            ),
          );
        }
      },
    );
  }

  Future<void> _clearSocialHashtagsEvent(
    ClearSocialHashtagsEvent event,
    Emitter<SocialHashtagsState> emit,
  ) async {
    emit(const InitialSocialHashtagsState());
  }
}
