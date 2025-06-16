import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_social_profile_usecase.dart';
import 'social_profile_event.dart';
import 'social_profile_state.dart';

class SocialProfileBloc extends Bloc<SocialProfileEvent, SocialProfileState> {
  final GetSocialProfileUsecase _getSocialProfileUsecase;

  SocialProfileBloc({required GetSocialProfileUsecase getSocialProfileUsecase})
      : _getSocialProfileUsecase = getSocialProfileUsecase,
        super(InitialSocialProfileState()) {
    on<GetSocialProfileEvent>(_getSocialProfileEvent);
  }

  Future<void> _getSocialProfileEvent(
    GetSocialProfileEvent event,
    Emitter<SocialProfileState> emit,
  ) async {
    emit(LoadingSocialProfileState());

    final profile = await _getSocialProfileUsecase.call(
      permaname: event.permaname,
    );

    profile.fold(
      (left) {
        emit(ErrorSocialProfileState());
      },
      (right) {
        if (right.id.isEmpty) {
          emit(EmptySocialProfileState());
        } else {
          emit(
            LoadedSocialProfileState(
              socialProfileEntity: right,
            ),
          );
        }
      },
    );
  }
}
