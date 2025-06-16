import 'package:equatable/equatable.dart';

abstract class MoodsState extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class LoadingMoodsState extends MoodsState {}

class InitialMoodsState extends MoodsState {}

class LoadedMoodsState extends MoodsState {
  final String url;

  LoadedMoodsState({
    required this.url,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      url,
    ];
  }
}

class ErrorMoodsState extends MoodsState {}
