import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/read_profile_photo_url_usecase.dart';
import 'read_profile_photo_url_event.dart';
import 'read_profile_photo_url_state.dart';

class ReadProfilePhotoURLBloc extends Bloc<ReadProfilePhotoURLEvent, ReadProfilePhotoURLState> {
  final ReadProfilePhotoURLUsecase _readProfilePhotoURLUsecase;

  ReadProfilePhotoURLBloc({
    required ReadProfilePhotoURLUsecase readProfilePhotoURLUsecase,
  })  : _readProfilePhotoURLUsecase = readProfilePhotoURLUsecase,
        super(InitialReadProfilePhotoURLState()) {
    on<GetReadProfilePhotoURLEvent>(_getReadProfilePhotoURLEvent);
  }

  Future<void> _getReadProfilePhotoURLEvent(
    GetReadProfilePhotoURLEvent event,
    Emitter<ReadProfilePhotoURLState> emit,
  ) async {
    emit(LoadingReadProfilePhotoURLState());

    final url = await _readProfilePhotoURLUsecase.call(
      userId: event.userId,
    );

    url.fold(
      (left) {
        emit(
          ErrorReadProfilePhotoURLState(),
        );
      },
      (right) {
        emit(
          LoadedReadProfilePhotoURLState(
            url: right,
            userId: event.userId,
          ),
        );
      },
    );
  }
}
