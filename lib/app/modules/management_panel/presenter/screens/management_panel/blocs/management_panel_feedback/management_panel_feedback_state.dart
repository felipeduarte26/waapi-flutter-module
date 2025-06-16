import 'package:equatable/equatable.dart';

import '../../../../../../feedback/domain/entities/feedback_entity.dart';

abstract class ManagementPanelFeedbackState extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class LoadedManagementPanelLatestFeedbacksState extends ManagementPanelFeedbackState {
  final List<FeedbackEntity> latestFeedbacks;

  LoadedManagementPanelLatestFeedbacksState({
    required this.latestFeedbacks,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      latestFeedbacks,
    ];
  }
}

class ErrorManagementPanelLatestFeedbacksState extends ManagementPanelFeedbackState {
  final String? message;

  ErrorManagementPanelLatestFeedbacksState({
    this.message,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      message,
    ];
  }
}

class LoadingManagementPanelLatestFeedbacksState extends ManagementPanelFeedbackState {}

class EmptyManagementPanelLatestFeedbacksState extends ManagementPanelFeedbackState {}

class InitialManagementPanelLatestFeedbacksState extends ManagementPanelFeedbackState {}
