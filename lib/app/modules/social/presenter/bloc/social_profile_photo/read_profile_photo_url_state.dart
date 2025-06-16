import 'package:equatable/equatable.dart';

abstract class ReadProfilePhotoURLState extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class LoadingReadProfilePhotoURLState extends ReadProfilePhotoURLState {}

class InitialReadProfilePhotoURLState extends ReadProfilePhotoURLState {}

class LoadedReadProfilePhotoURLState extends ReadProfilePhotoURLState {
  final String url;
  final String userId;

  LoadedReadProfilePhotoURLState({
    required this.url,
    required this.userId,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      url,
      userId,
    ];
  }
}

class ErrorReadProfilePhotoURLState extends ReadProfilePhotoURLState {}
