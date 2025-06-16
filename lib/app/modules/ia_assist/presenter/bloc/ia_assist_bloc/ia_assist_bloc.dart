import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/ia_assist_usecase.dart';
import 'ia_assist_event.dart';
import 'ia_assist_state.dart';

class IAAssistBloc extends Bloc<IAAssistEvent, IAAssistState> {
  final IAAssistUsecase _iaAssistUsecase;

  IAAssistBloc({
    required IAAssistUsecase iaAssistUsecase,
  })  : _iaAssistUsecase = iaAssistUsecase,
        super(InitialIAAssistState()) {
    on<GenerateTextIAAssistEvent>(_generateTextIAAssistEvent);
    on<InitialIAAssistEvent>(_setInitialIAAssistStateEvent);
  }

  void _setInitialIAAssistStateEvent(
    InitialIAAssistEvent event,
    Emitter<IAAssistState> emit,
  ) {
    emit(InitialIAAssistState());
  }

  Future<void> _generateTextIAAssistEvent(
    GenerateTextIAAssistEvent event,
    Emitter<IAAssistState> emit,
  ) async {
    emit(LoadingIAAssistState());

    final text = await _iaAssistUsecase.call(
      prompt: event.prompt,
      temperature: event.temperature,
    );

    text.fold(
      (left) {
        emit(ErrorIAAssistState());
      },
      (right) {
        emit(LoadedIAAssistState(text: right));
      },
    );
  }
}
