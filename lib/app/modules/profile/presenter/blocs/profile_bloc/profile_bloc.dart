import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_profile_usecase.dart';
import '../../../domain/usecases/update_photo_profile_usecase.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUsecase _getProfileUsecase;
  final UpdatePhotoProfileUsecase _updatePhotoProfileUsecase;

  ProfileBloc({
    required GetProfileUsecase getProfileUsecase,
    required UpdatePhotoProfileUsecase updatePhotoProfileUsecase,
  })  : _getProfileUsecase = getProfileUsecase,
        _updatePhotoProfileUsecase = updatePhotoProfileUsecase,
        super(const InitialProfileState()) {
    on<GetProfileEvent>(_getProfileEvent);
    on<UpdatePhotoProfileEvent>(_updatePhotoProfileEvent);
  }

  Future<void> _getProfileEvent(
    GetProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.loadingProfileState());

    final profileEntity = await _getProfileUsecase.call(
      personId: event.personId,
      employeeId: event.employeeId,
    );

    profileEntity.fold(
      (left) {
        if (state.profileEntity != null) {
          emit(state.errorUpdateProfileState());
          emit(
            state.loadedProfileState(
              profileEntity: state.profileEntity!,
            ),
          );
          return;
        }
        emit(const ErrorProfileState());
      },
      (right) {
        emit(
          state.loadedProfileState(
            profileEntity: right,
          ),
        );
      },
    );
  }

  Future<void> _updatePhotoProfileEvent(
    UpdatePhotoProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.updatingPhotoProfileState());

    final newUrlPhoto = await _updatePhotoProfileUsecase.call(
      contentType: event.contentType,
      photoBase64: event.base64Image,
      userId: event.userId,
    );

    newUrlPhoto.fold(
      (left) {
        emit(
          state.errorUpdatePhotoProfileState(
            contentType: event.contentType,
            base64Image: event.base64Image,
            userId: event.userId,
          ),
        );
        emit(
          state.loadedProfileState(
            profileEntity: state.profileEntity!,
          ),
        );
      },
      (right) {
        emit(
          state.updatedPhotoProfileState(
            urlPhotoProfile: right,
          ),
        );
        emit(
          state.loadedProfileState(
            profileEntity: state.profileEntity!,
          ),
        );
      },
    );
  }
}
