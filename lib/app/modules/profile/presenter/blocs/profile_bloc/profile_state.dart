import 'package:equatable/equatable.dart';

import '../../../domain/entities/profile_entity.dart';

abstract class ProfileState extends Equatable {
  final ProfileEntity? profileEntity;
  final String? urlPhotoProfile;

  const ProfileState({
    required this.profileEntity,
    required this.urlPhotoProfile,
  });

  LoadingProfileState loadingProfileState() {
    return LoadingProfileState(
      profileEntity: profileEntity,
      urlPhotoProfile: urlPhotoProfile,
    );
  }

  LoadedProfileState loadedProfileState({
    required ProfileEntity profileEntity,
  }) {
    return LoadedProfileState(
      profileEntity: profileEntity,
      urlPhotoProfile: urlPhotoProfile,
    );
  }

  ErrorUpdateProfileState errorUpdateProfileState() {
    return ErrorUpdateProfileState(
      profileEntity: profileEntity,
      urlPhotoProfile: urlPhotoProfile,
    );
  }

  UpdatingPhotoProfileState updatingPhotoProfileState() {
    return UpdatingPhotoProfileState(
      profileEntity: profileEntity,
      urlPhotoProfile: urlPhotoProfile,
    );
  }

  UpdatedPhotoProfileState updatedPhotoProfileState({
    required String urlPhotoProfile,
  }) {
    return UpdatedPhotoProfileState(
      profileEntity: profileEntity,
      urlPhotoProfile: urlPhotoProfile,
    );
  }

  ErrorUpdatePhotoProfileState errorUpdatePhotoProfileState({
    required String base64Image,
    required String contentType,
    required String userId,
  }) {
    return ErrorUpdatePhotoProfileState(
      profileEntity: profileEntity,
      urlPhotoProfile: urlPhotoProfile,
      base64Image: base64Image,
      contentType: contentType,
      userId: userId,
    );
  }

  @override
  List<Object?> get props {
    return [
      profileEntity,
    ];
  }
}

class InitialProfileState extends ProfileState {
  const InitialProfileState({
    ProfileEntity? profileEntity,
    String? urlPhotoProfile,
  }) : super(
          profileEntity: profileEntity,
          urlPhotoProfile: urlPhotoProfile,
        );
}

class LoadingProfileState extends ProfileState {
  const LoadingProfileState({
    ProfileEntity? profileEntity,
    String? urlPhotoProfile,
  }) : super(
          profileEntity: profileEntity,
          urlPhotoProfile: urlPhotoProfile,
        );
}

class LoadedProfileState extends ProfileState {
  const LoadedProfileState({
    ProfileEntity? profileEntity,
    String? urlPhotoProfile,
  }) : super(
          profileEntity: profileEntity,
          urlPhotoProfile: urlPhotoProfile,
        );
}

class ErrorProfileState extends ProfileState {
  const ErrorProfileState({
    ProfileEntity? profileEntity,
    String? urlPhotoProfile,
  }) : super(
          profileEntity: profileEntity,
          urlPhotoProfile: urlPhotoProfile,
        );
}

class ErrorUpdateProfileState extends ProfileState {
  const ErrorUpdateProfileState({
    ProfileEntity? profileEntity,
    String? urlPhotoProfile,
  }) : super(
          profileEntity: profileEntity,
          urlPhotoProfile: urlPhotoProfile,
        );
}

class UpdatingPhotoProfileState extends ProfileState {
  const UpdatingPhotoProfileState({
    ProfileEntity? profileEntity,
    String? urlPhotoProfile,
  }) : super(
          profileEntity: profileEntity,
          urlPhotoProfile: urlPhotoProfile,
        );
}

class UpdatedPhotoProfileState extends ProfileState {
  const UpdatedPhotoProfileState({
    ProfileEntity? profileEntity,
    String? urlPhotoProfile,
  }) : super(
          profileEntity: profileEntity,
          urlPhotoProfile: urlPhotoProfile,
        );
}

class ErrorUpdatePhotoProfileState extends ProfileState {
  final String base64Image;
  final String contentType;
  final String userId;

  const ErrorUpdatePhotoProfileState({
    ProfileEntity? profileEntity,
    String? urlPhotoProfile,
    required this.base64Image,
    required this.contentType,
    required this.userId,
  }) : super(
          profileEntity: profileEntity,
          urlPhotoProfile: urlPhotoProfile,
        );
}
