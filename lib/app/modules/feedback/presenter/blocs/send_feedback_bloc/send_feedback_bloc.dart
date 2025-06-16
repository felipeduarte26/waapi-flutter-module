import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/input_models/proficiency_input_model.dart';
import '../../../domain/input_models/send_feedback_input_model.dart';
import '../../../domain/input_models/skill_input_model.dart';
import '../../../domain/usecases/send_feedback_usecase.dart';
import 'send_feedback_event.dart';
import 'send_feedback_state.dart';

class SendFeedbackBloc extends Bloc<SendFeedbackEvent, SendFeedbackState> {
  final SendFeedbackUsecase _sendFeedbackUsecase;

  SendFeedbackBloc({
    required SendFeedbackUsecase sendFeedbackUsecase,
  })  : _sendFeedbackUsecase = sendFeedbackUsecase,
        super(
          InitialSendFeedbackState(),
        ) {
    on<SendWrittenFeedbackEvent>(
      _sendWrittenFeedbackEvent,
    );
  }

  Future<void> _sendWrittenFeedbackEvent(
    SendWrittenFeedbackEvent event,
    Emitter<SendFeedbackState> emit,
  ) async {
    emit(
      state.loadingSendFeedbackState(),
    );
    ProficiencyInputModel? proficiencyInputModel;

    if (event.proficiency != null) {
      proficiencyInputModel = ProficiencyInputModel(
        id: event.proficiency!.id,
        color: event.proficiency!.color,
        name: event.proficiency!.name,
        level: event.proficiency!.level,
      );
    }

    final SendFeedbackInputModel sendFeedbackInputModel = SendFeedbackInputModel(
      message: event.message,
      when: event.when,
      toUserName: event.toUserName,
      visibility: event.visibility,
      skills: event.skills.map(
        (skill) {
          return SkillInputModel(
            competencyId: skill.id,
            skill: skill.name,
          );
        },
      ).toList(),
      starCount: event.starCount,
      requestId: event.requestId,
      proficiency: proficiencyInputModel,
    );

    final sentFeedbackIdEntity = await _sendFeedbackUsecase.call(
      sendFeedbackInputModel: sendFeedbackInputModel,
      feedbackAnalyticsTypeEnum: event.feedbackAnalyticsTypeEnum,
    );

    sentFeedbackIdEntity.fold(
      (left) {
        emit(
          state.errorSendFeedbackState(
            errorMessage: left.message,
          ),
        );
      },
      (right) {
        emit(
          state.loadedSendFeedbackState(
            sentFeedbackIdEntity: right,
          ),
        );
      },
    );
  }
}
