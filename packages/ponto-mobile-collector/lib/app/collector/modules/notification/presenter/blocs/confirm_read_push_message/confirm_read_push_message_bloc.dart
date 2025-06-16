import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/confirm_read_push_message_usecase.dart';
import '../counter_notifications_bloc/counter_notifications_bloc.dart';
import '../counter_notifications_bloc/counter_notifications_event.dart';
import 'confirm_read_push_message_event.dart';
import 'confirm_read_push_message_state.dart';

class ConfirmReadPushMessageBloc
    extends Bloc<ConfirmReadPushMessageEvent, ConfirmReadPushMessageState> {
  final ConfirmReadPushMessageUseCase confirmReadPushMessageUseCase;
  final CounterNotificationsBloc counterNotificationsBloc;

  ConfirmReadPushMessageBloc({
    required this.confirmReadPushMessageUseCase,
    required this.counterNotificationsBloc,
  }) : super(InitialConfirmReadPushMessageState()) {
    on<GetConfirmReadPushMessageEventEvent>(_getConfirmReadNotificationsEvent);
  }

  Future<void> _getConfirmReadNotificationsEvent(
    GetConfirmReadPushMessageEventEvent event,
    Emitter<ConfirmReadPushMessageState> emit,
  ) async {
    emit(LoadingConfirmReadPushMessageState());

    if (!event.read) {
      final confirmReadPushMessage =
          await confirmReadPushMessageUseCase.call(messageId: event.messageId);

      if (confirmReadPushMessage.confirmed) {
        emit(
          SucceedConfirmReadPushMessageState(
            confirmReadPushMessage: confirmReadPushMessage,
          ),
        );
        counterNotificationsBloc.add(GetCounterNotificationsEvent());
      } else {
        emit(
          ErrorConfirmReadPushMessageState(),
        );
      }
    }
  }
}
