import 'package:equatable/equatable.dart';

import '../../../domain/entities/hyperlink_entity.dart';

abstract class HyperlinkState extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class InitialHyperlinkState extends HyperlinkState {}

class LoadingHyperlinkState extends HyperlinkState {}

class LoadedHyperlinkState extends HyperlinkState {
  final List<HyperlinkEntity> hyperlinksEntity;

  LoadedHyperlinkState({
    required this.hyperlinksEntity,
  });

  @override
  List<Object?> get props {
    return [
      hyperlinksEntity,
    ];
  }
}

class ErrorHyperlinkState extends HyperlinkState {}
