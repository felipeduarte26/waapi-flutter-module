import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_url_post_usecase.dart';
import 'get_url_post_event.dart';
import 'get_url_post_state.dart';

class GetURLPostBloc extends Bloc<GetURLPostEvent, GetURLPostState> {
  final GetURLPostUsecase _getURLPostUsecase;

  GetURLPostBloc({
    required GetURLPostUsecase getURLPostUsecase,
  })  : _getURLPostUsecase = getURLPostUsecase,
        super(InitialGetURLPostState()) {
    on<GetURLPostEvent>(_getURLPostEvent);
  }

  Future<void> _getURLPostEvent(
    GetURLPostEvent event,
    Emitter<GetURLPostState> emit,
  ) async {
    emit(LoadingGetURLPostState());

    final url = await _getURLPostUsecase.call(
      postId: event.postId,
    );

    url.fold(
      (left) {
        emit(
          ErrorGetURLPostState(),
        );
      },
      (right) {
        emit(
          LoadedGetURLPostState(
            url: right,
            postId: event.postId,
          ),
        );
      },
    );
  }
}
