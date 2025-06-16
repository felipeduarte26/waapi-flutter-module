import 'package:equatable/equatable.dart';

import '../../../../../core/pagination/pagination_requirements.dart';

abstract class ReceivedFeedbacksEvent extends Equatable {}

class GetReceivedFeedbacksEvent extends ReceivedFeedbacksEvent {
  final PaginationRequirements paginationRequirements;
  final bool overrideNotAllowedStates;

  GetReceivedFeedbacksEvent({
    required this.paginationRequirements,
    this.overrideNotAllowedStates = false,
  });

  @override
  List<Object?> get props {
    return [
      paginationRequirements,
      overrideNotAllowedStates,
    ];
  }
}

class ReloadListReceivedFeedbacksEvent extends ReceivedFeedbacksEvent {
  @override
  List<Object?> get props {
    return [];
  }
}
