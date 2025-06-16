import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/input_models/mark_notification_as_read_input_model.dart';
import '../../../domain/usecases/mark_notification_as_read_usecase.dart';
import 'mark_notification_as_read_event.dart';
import 'mark_notification_as_read_state.dart';

class MarkNotificationAsReadBloc extends Bloc<MarkNotificationAsReadEvent, MarkNotificationAsReadState> {
  final MarkNotificationAsReadUsecase _markNotificationAsReadUsecase;

  MarkNotificationAsReadBloc({
    required MarkNotificationAsReadUsecase markNotificationAsReadUsecase,
  })  : _markNotificationAsReadUsecase = markNotificationAsReadUsecase,
        super(InitialMarkNotificationAsReadState()) {
    on<SendMarkNotificationAsReadEvent>(_markNotificationAsReadEvent);
  }

  Future<void> _markNotificationAsReadEvent(
    SendMarkNotificationAsReadEvent event,
    Emitter<MarkNotificationAsReadState> emit,
  ) async {
    emit(LoadingMarkNotificationAsReadState());

    if (event.isAlreadyRead) {
      emit(SucceedMarkNotificationAsReadState());
      return;
    }

    final isMarkRead = await _markNotificationAsReadUsecase.call(
      markNotificationAsReadInputModel: MarkNotificationAsReadInputModel(
        notificationId: event.notificationId,
      ),
    );

    isMarkRead.fold(
      (left) {
        emit(ErrorMarkNotificationAsReadState());
      },
      (right) {
        emit(SucceedMarkNotificationAsReadState());
      },
    );
  }
}
