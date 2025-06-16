import 'package:equatable/equatable.dart';

abstract class HyperlinkPathState extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class InitialHyperlinkPathState extends HyperlinkPathState {}

class LoadingHyperlinkPathState extends HyperlinkPathState {}

class LoadedHyperlinkPathState extends HyperlinkPathState {
  final String path;

  LoadedHyperlinkPathState({
    required this.path,
  });

  @override
  List<Object?> get props {
    return [
      path,
    ];
  }
}

class ErrorGetHyperlinkPath extends HyperlinkPathState {}
