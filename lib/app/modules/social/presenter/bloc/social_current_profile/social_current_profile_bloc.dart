import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_social_current_profile_usecase.dart';
import 'social_current_profile_event.dart';
import 'social_current_profile_state.dart';

class SocialCurrentProfileBloc extends Bloc<SocialCurrentProfileEvent, SocialCurrentProfileState> {
  final GetSocialCurrentProfileUsecase _getSocialCurrentProfileUsecase;

  SocialCurrentProfileBloc({
    required GetSocialCurrentProfileUsecase getSocialCurrentProfileUsecase,
  })  : _getSocialCurrentProfileUsecase = getSocialCurrentProfileUsecase,
        super(InitialSocialCurrentProfileState()) {
    on<GetSocialCurrentProfileEvent>(_getSocialCurrentProfileEvent);
  }

  Future<void> _getSocialCurrentProfileEvent(
    GetSocialCurrentProfileEvent event,
    Emitter<SocialCurrentProfileState> emit,
  ) async {
    emit(LoadingSocialCurrentProfileState());

    final profile = await _getSocialCurrentProfileUsecase.call();

    profile.fold(
      (left) {
        emit(
          ErrorSocialCurrentProfileState(),
        );
      },
      (right) {
        emit(
          LoadedSocialCurrentProfileState(
            profile: right,
          ),
        );
      },
    );
  }
}
