import 'package:equatable/equatable.dart';

abstract class GetURLPostState extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class LoadingGetURLPostState extends GetURLPostState {}

class InitialGetURLPostState extends GetURLPostState {}

class LoadedGetURLPostState extends GetURLPostState {
  final String url;
  final String postId;

  LoadedGetURLPostState({
    required this.url,
    required this.postId,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      url,
      postId,
    ];
  }
}

class ErrorGetURLPostState extends GetURLPostState {}
