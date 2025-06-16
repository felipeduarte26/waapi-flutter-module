import 'package:equatable/equatable.dart';

import '../../../../../core/pagination/pagination_requirements.dart';

abstract class PublicFeedbacksEvent extends Equatable {
  const PublicFeedbacksEvent();
}

class GetPublicFeedbacksEvent extends PublicFeedbacksEvent {
  final String employeeId;
  final PaginationRequirements paginationRequirements;

  const GetPublicFeedbacksEvent({
    required this.employeeId,
    required this.paginationRequirements,
  });

  @override
  List<Object?> get props {
    return [
      employeeId,
      paginationRequirements,
    ];
  }
}
