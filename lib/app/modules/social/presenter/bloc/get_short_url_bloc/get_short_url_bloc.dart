import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_short_url_usecase.dart';
import '../../../domain/usecases/save_dont_show_shorten_link_usercase.dart';
import '../../../domain/usecases/show_message_shorten_link_usecase.dart';
import 'get_short_url_event.dart';
import 'get_short_url_state.dart';

class GetShortUrlBloc extends Bloc<GetShortUrlEvent, GetShortUrlState> {
  final GetShortUrlUsecase _getShortUrlUsecase;
  final ShowMessageShortenLinkUsecase _showMessageShortenLinkUsecase;
  final SaveDontShowShortenLinkUsercase _saveDontShowMessageShortenLinkUsecase;

  GetShortUrlBloc({
    required GetShortUrlUsecase getShortUrlUsecase,
    required ShowMessageShortenLinkUsecase showMessageShortenLinkUsecase,
    required SaveDontShowShortenLinkUsercase saveDontShowMessageShortenLinkUsecase,
  })  : _getShortUrlUsecase = getShortUrlUsecase,
        _showMessageShortenLinkUsecase = showMessageShortenLinkUsecase,
        _saveDontShowMessageShortenLinkUsecase = saveDontShowMessageShortenLinkUsecase,
        super(InitialGetShortUrlState()) {
    on<GetShortUrl>(_getShortUrlEvent);
    on<SaveDontShowMessageShortenLinkEvent>(_saveDontShowMessageShortenLinkEvent);
    on<ShowMessageShortenLinksEvent>(_showMessageShortenLinksEvent);
  }

  Future<void> _showMessageShortenLinksEvent(
    ShowMessageShortenLinksEvent event,
    Emitter<GetShortUrlState> emit,
  ) async {
    emit(LoadingGetShortUrlState());

    final showMessage = await _showMessageShortenLinkUsecase.call(
      showMessageShortenLinkKey: event.socialViewKeyEnum,
      showMessageShortenLink: event.showMessageShortenLink,
    );

    showMessage.fold(
      (left) {
        emit(
          ErrorGetShortUrlState(),
        );
      },
      (right) {
        emit(
          ShowMessageShortenLinksState(
            showMessageShortenLinks: right,
          ),
        );
      },
    );
  }

  Future<void> _saveDontShowMessageShortenLinkEvent(
    SaveDontShowMessageShortenLinkEvent event,
    Emitter<GetShortUrlState> emit,
  ) async {
    emit(LoadingGetShortUrlState());

    final saved = await _saveDontShowMessageShortenLinkUsecase.call(
      messageShortenLinkKey: event.socialViewKeyEnum,
      showMessageShortenLink: event.showMessageShortenLink,
    );

    saved.fold(
      (left) {
        emit(
          ErrorGetShortUrlState(),
        );
      },
      (right) {
        emit(
          SaveDontShowMessageShortenLinkState(),
        );
      },
    );
  }

  Future<void> _getShortUrlEvent(
    GetShortUrl event,
    Emitter<GetShortUrlState> emit,
  ) async {
    emit(LoadingGetShortUrlState());

    final url = await _getShortUrlUsecase.call(
      listUrl: event.listUrl,
    );

    url.fold(
      (left) {
        emit(
          ErrorGetShortUrlState(),
        );
      },
      (right) {
        emit(
          SuccessGetShortUrlState(
            mapUrlShorterner: right,
          ),
        );
      },
    );
  }
}
