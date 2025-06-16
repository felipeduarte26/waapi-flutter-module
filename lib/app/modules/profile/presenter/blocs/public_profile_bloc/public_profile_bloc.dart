import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_public_profile_usecase.dart';
import 'public_profile_event.dart';
import 'public_profile_state.dart';

class PublicProfileBloc extends Bloc<PublicProfileEvent, PublicProfileState> {
  final GetPublicProfileUsecase _getPublicProfileUsecase;

  PublicProfileBloc({
    required GetPublicProfileUsecase getPublicProfileUsecase,
  })  : _getPublicProfileUsecase = getPublicProfileUsecase,
        super(InitialPublicProfileState()) {
    on<GetPublicProfileEvent>(_getPublicProfileEvent);
  }

  Future<void> _getPublicProfileEvent(
    GetPublicProfileEvent event,
    Emitter<PublicProfileState> emit,
  ) async {
    emit(LoadingPublicProfileState());

    final publicProfileEntity = await _getPublicProfileUsecase.call(
      userName: event.userName,
    );

    publicProfileEntity.fold(
      (left) {
        emit(
          ErrorPublicProfileState(
            userName: event.userName,
          ),
        );
      },
      (right) {
        emit(
          LoadedPublicProfileState(
            publicProfileEntity: right,
          ),
        );
      },
    );
  }
}
