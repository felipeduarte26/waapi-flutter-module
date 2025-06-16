import 'package:equatable/equatable.dart';

import '../../../../../core/pagination/pagination_requirements.dart';

abstract class SentFeedbacksEvent extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class GetSentFeedbacksEvent extends SentFeedbacksEvent {
  final PaginationRequirements paginationRequirements;
  final bool overrideNotAllowedStates;

  GetSentFeedbacksEvent({
    required this.paginationRequirements,
    this.overrideNotAllowedStates = false,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      paginationRequirements,
      overrideNotAllowedStates,
    ];
  }
}

class ReloadListSentFeedbacksEvent extends SentFeedbacksEvent {}
