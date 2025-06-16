import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_space_info_usecase.dart';
import 'social_space_info_event.dart';
import 'social_space_info_state.dart';

class SocialSpaceInfoBloc extends Bloc<SocialSpaceInfoEvent, SocialSpaceInfoState> {
  final GetSpaceInfoUsecase _getSocialSpaceInfoUsecase;

  SocialSpaceInfoBloc({required GetSpaceInfoUsecase getSocialSpaceInfoUsecase})
      : _getSocialSpaceInfoUsecase = getSocialSpaceInfoUsecase,
        super(InitialSocialSpaceInfoState()) {
    on<GetSocialSpaceInfoEvent>(_getSocialSpaceInfoEvent);
  }

  Future<void> _getSocialSpaceInfoEvent(
    GetSocialSpaceInfoEvent event,
    Emitter<SocialSpaceInfoState> emit,
  ) async {
    emit(LoadingSocialSpaceInfoState());

    final profile = await _getSocialSpaceInfoUsecase.call(
      permaname: event.permaname,
    );

    profile.fold(
      (left) {
        emit(ErrorSocialSpaceInfoState());
      },
      (right) {
        if (right.permaname.isEmpty) {
          emit(EmptySocialSpaceInfoState());
        } else {
          emit(
            LoadedSocialSpaceInfoState(
              socialSpaceEntity: right,
            ),
          );
        }
      },
    );
  }
}
