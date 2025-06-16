import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_social_my_profiles_usecase.dart';
import 'social_profiles_event.dart';
import 'social_profiles_state.dart';

class SocialProfilesBloc extends Bloc<SocialProfilesEvent, SocialProfilesState> {
  final GetSocialMyProfilesUsecase _getSocialMyProfilesUsecase;

  SocialProfilesBloc({
    required GetSocialMyProfilesUsecase getSocialMyProfilesUsecase,
  })  : _getSocialMyProfilesUsecase = getSocialMyProfilesUsecase,
        super(InitialSocialProfilesState()) {
    on<GetSocialMyProfilesEvent>(_getSocialMyProfilesEvent);
    on<ResetSocialMyProfilesEvent>(_resetSocialMyProfilesEvent);
  }

  Future<void> _getSocialMyProfilesEvent(
    GetSocialMyProfilesEvent event,
    Emitter<SocialProfilesState> emit,
  ) async {
    emit(LoadingSocialMyProfilesState());

    final profiles = await _getSocialMyProfilesUsecase.call();

    profiles.fold(
      (left) {
        emit(
          ErrorSocialMyProfilesState(),
        );
      },
      (right) {
        emit(
          LoadedSocialMyProfilesState(
            profiles: right,
          ),
        );
      },
    );
  }

  Future<void> _resetSocialMyProfilesEvent(
    ResetSocialMyProfilesEvent event,
    Emitter<SocialProfilesState> emit,
  ) async {
    emit(InitialSocialProfilesState());
  }
}
