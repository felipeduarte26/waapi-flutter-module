import 'package:equatable/equatable.dart';

abstract class ManagementPanelFeedbackEvent extends Equatable {}

class GetLatestFeedbacksEvent extends ManagementPanelFeedbackEvent {
  final bool isAllowToViewMyFeedbacks;

  GetLatestFeedbacksEvent({
    required this.isAllowToViewMyFeedbacks,
  });

  @override
  List<Object?> get props {
    return [
      isAllowToViewMyFeedbacks,
    ];
  }
}
