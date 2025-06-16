import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_mentions_usecase.dart';
import 'social_mentions_bloc_event_transformer.dart';
import 'social_mentions_event.dart';
import 'social_mentions_state.dart';

class SocialMentionsBloc extends Bloc<SocialMentionsEvent, SocialMentionsState> {
  final GetMentionsUsecase _getMentionsUsecase;

  SocialMentionsBloc({
    required GetMentionsUsecase getMentionsUsecase,
  })  : _getMentionsUsecase = getMentionsUsecase,
        super(const InitialSocialMentionsState()) {
    on<GetSocialMentionsEvent>(
      _getSocialMentionsEvent,
      transformer: debounce(
        const Duration(
          milliseconds: 300,
        ),
      ),
    );
    on<ClearSocialMentionsEvent>(_clearSocialMentionsEvent);
  }

  Future<void> _getSocialMentionsEvent(
    GetSocialMentionsEvent event,
    Emitter<SocialMentionsState> emit,
  ) async {
    final query = event.query.trim();
    emit(
      state.loadingSocialMentionsState(
        searchTerm: query,
      ),
    );

    final mentions = await _getMentionsUsecase.call(
      query: query,
    );

    mentions.fold(
      (left) {
        emit(
          state.errorSocialMentionsState(
            searchTerm: query,
          ),
        );
      },
      (right) {
        if (right.isEmpty) {
          emit(
            state.emptySocialMentionsState(
              searchTerm: query,
            ),
          );
        } else {
          emit(
            state.loadedSocialMentionsState(
              mentions: right,
              searchTerm: state.searchTerm.trim(),
            ),
          );
        }
      },
    );
  }

  Future<void> _clearSocialMentionsEvent(
    ClearSocialMentionsEvent event,
    Emitter<SocialMentionsState> emit,
  ) async {
    emit(const InitialSocialMentionsState());
  }
}
