import 'package:equatable/equatable.dart';

import '../../../domain/entities/sent_feedback_id_entity.dart';

abstract class SendFeedbackState extends Equatable {
  final SentFeedbackIdEntity sentFeedbackIdEntity;

  const SendFeedbackState({
    this.sentFeedbackIdEntity = const SentFeedbackIdEntity(
      id: '',
    ),
  });

  LoadingSendFeedbackState loadingSendFeedbackState() {
    return LoadingSendFeedbackState();
  }

  LoadedSendFeedbackState loadedSendFeedbackState({
    required SentFeedbackIdEntity sentFeedbackIdEntity,
  }) {
    return LoadedSendFeedbackState(
      sentFeedbackIdEntity: sentFeedbackIdEntity,
    );
  }

  ErrorSendFeedbackState errorSendFeedbackState({
    String? errorMessage,
  }) {
    return ErrorSendFeedbackState(
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props {
    return [
      sentFeedbackIdEntity,
    ];
  }
}

class InitialSendFeedbackState extends SendFeedbackState {}

class LoadingSendFeedbackState extends SendFeedbackState {}

class LoadedSendFeedbackState extends SendFeedbackState {
  const LoadedSendFeedbackState({
    required SentFeedbackIdEntity sentFeedbackIdEntity,
  }) : super(sentFeedbackIdEntity: sentFeedbackIdEntity);
}

class ErrorSendFeedbackState extends SendFeedbackState {
  final String? errorMessage;

  const ErrorSendFeedbackState({
    this.errorMessage,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      errorMessage,
    ];
  }
}
