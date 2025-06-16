import 'package:equatable/equatable.dart';

abstract class FeedbackPersonEvent extends Equatable {
  const FeedbackPersonEvent();

  @override
  List<Object> get props {
    return [];
  }
}

class GetFeedbackPersonIdEvent extends FeedbackPersonEvent {
  final String employeeId;

  const GetFeedbackPersonIdEvent({
    required this.employeeId,
  });

  @override
  List<Object> get props {
    return [
      ...super.props,
      employeeId,
    ];
  }
}
