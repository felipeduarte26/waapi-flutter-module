import 'package:equatable/equatable.dart';

abstract class HyperlinkPdfState extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class InitialHyperlinkPdfState extends HyperlinkPdfState {}

class LoadingHyperlinkPdfState extends HyperlinkPdfState {}

class LoadedHyperlinkPdfState extends HyperlinkPdfState {
  final List<int> path;

  LoadedHyperlinkPdfState({
    required this.path,
  });

  @override
  List<Object?> get props {
    return [
      path,
    ];
  }
}

class ErrorHyperlinkPdfState extends HyperlinkPdfState {}
