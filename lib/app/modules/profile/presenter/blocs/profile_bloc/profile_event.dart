import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props {
    return [];
  }
}

class GetProfileEvent extends ProfileEvent {
  final String personId;
  final String employeeId;

  const GetProfileEvent({
    required this.personId,
    required this.employeeId,
  });

  @override
  List<Object> get props {
    return [
      ...super.props,
      employeeId,
      personId,
    ];
  }
}

class UpdatePhotoProfileEvent extends ProfileEvent {
  final String base64Image;
  final String contentType;
  final String userId;

  const UpdatePhotoProfileEvent({
    required this.base64Image,
    required this.contentType,
    required this.userId,
  });

  @override
  List<Object> get props {
    return [
      ...super.props,
      base64Image,
      contentType,
      userId,
    ];
  }
}
