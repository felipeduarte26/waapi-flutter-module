import 'package:equatable/equatable.dart';

import '../../../domain/entities/confirm_read_push_message_entity.dart';

abstract class ConfirmReadPushMessageState extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class InitialConfirmReadPushMessageState extends ConfirmReadPushMessageState {}

class LoadingConfirmReadPushMessageState extends ConfirmReadPushMessageState {}

class SucceedConfirmReadPushMessageState extends ConfirmReadPushMessageState {
  final ConfirmReadPushMessageEntity confirmReadPushMessage;

  SucceedConfirmReadPushMessageState({
    required this.confirmReadPushMessage,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      confirmReadPushMessage,
    ];
  }
}

class ErrorConfirmReadPushMessageState extends ConfirmReadPushMessageState {}
