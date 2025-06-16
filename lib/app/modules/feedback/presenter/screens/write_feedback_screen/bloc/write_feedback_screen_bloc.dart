import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../authorization/presenter/blocs/authorization_bloc/authorization_bloc.dart';
import '../../../../../ia_assist/presenter/bloc/ia_assist_bloc/ia_assist_bloc.dart';
import '../../../../../ia_assist/presenter/bloc/ia_assist_bloc/ia_assist_state.dart';
import '../../../blocs/proficiency_list_bloc/proficiency_list_bloc.dart';
import '../../../blocs/proficiency_list_bloc/proficiency_list_state.dart';
import '../../../blocs/search_competences_bloc/search_competences_bloc.dart';
import '../../../blocs/search_competences_bloc/search_competences_state.dart';
import '../../../blocs/search_employee_bloc/search_employee_bloc.dart';
import '../../../blocs/search_employee_bloc/search_employee_state.dart';
import '../../../blocs/send_feedback_bloc/send_feedback_bloc.dart';
import '../../../blocs/send_feedback_bloc/send_feedback_state.dart';
import '../../../blocs/user_info_feedback_bloc/user_info_feedback_bloc.dart';
import '../../../blocs/user_info_feedback_bloc/user_info_feedback_state.dart';
import 'write_feedback_screen_event.dart';
import 'write_feedback_screen_state.dart';

class WriteFeedbackScreenBloc extends Bloc<WriteFeedbackScreenEvent, WriteFeedbackScreenState> {
  final SearchEmployeeBloc searchEmployeeBloc;
  final SearchCompetencesBloc searchCompetencesBloc;
  final SendFeedbackBloc sendFeedbackBloc;
  final ProficiencyListBloc proficiencyListBloc;
  final UserInfoFeedbackBloc userInfoFeedbackBloc;
  final AuthorizationBloc authorizationBloc;
  final IAAssistBloc iaAssistBloc;

  late StreamSubscription searchEmployeeSubscription;
  late StreamSubscription searchCompetencesSubscription;
  late StreamSubscription sendFeedbackSubscription;
  late StreamSubscription proficiencyListSubscription;
  late StreamSubscription userInfoFeedbackSubscription;
  late StreamSubscription iaAssistSubscription;

  WriteFeedbackScreenBloc({
    required this.searchEmployeeBloc,
    required this.searchCompetencesBloc,
    required this.sendFeedbackBloc,
    required this.proficiencyListBloc,
    required this.userInfoFeedbackBloc,
    required this.authorizationBloc,
    required this.iaAssistBloc,
  }) : super(
          CurrentWriteFeedbackScreenState(
            searchEmployeeState: const InitialSearchEmployeeState(),
            searchCompetencesState: InitialSearchCompetencesState(),
            proficiencyListState: const InitialProficiencyListState(),
            userInfoFeedbackState: const InitialUserInfoFeedbackState(),
            sendFeedbackState: InitialSendFeedbackState(),
            iaAssistState: InitialIAAssistState(),
          ),
        ) {
    on<ChangeSearchEmployeeStateEvent>(_changeSearchEmployeeStateEvent);
    on<ChangeSearchCompetencesStateEvent>(_changeSearchCompetencesStateEvent);
    on<ChangeSendFeedbackStateEvent>(_changeSendFeedbackStateEvent);
    on<ChangeProficiencyListStateEvent>(_changeProficiencyListStateEvent);
    on<ChangeUserInfoFeedbackStateEvent>(_changeUserInfoFeedbackStateEvent);
    on<ChangeIAAssistStateEvent>(_changeIAAssistStateEvent);

    searchEmployeeSubscription = searchEmployeeBloc.stream.listen(
      (searchEmployeeState) {
        add(
          ChangeSearchEmployeeStateEvent(
            searchEmployeeState: searchEmployeeState,
          ),
        );
      },
    );

    searchCompetencesSubscription = searchCompetencesBloc.stream.listen(
      (searchEmployeeState) {
        add(
          ChangeSearchCompetencesStateEvent(
            searchCompetencesState: searchEmployeeState,
          ),
        );
      },
    );

    sendFeedbackSubscription = sendFeedbackBloc.stream.listen(
      (sendFeedbackState) {
        add(
          ChangeSendFeedbackStateEvent(
            sendFeedbackState: sendFeedbackState,
          ),
        );
      },
    );

    proficiencyListSubscription = proficiencyListBloc.stream.listen(
      (proficiencyListState) {
        add(
          ChangeProficiencyListStateEvent(
            proficiencyListState: proficiencyListState,
          ),
        );
      },
    );

    userInfoFeedbackSubscription = userInfoFeedbackBloc.stream.listen(
      (userInfoFeedbackState) {
        add(
          ChangeUserInfoFeedbackStateEvent(
            userInfoFeedbackState: userInfoFeedbackState,
          ),
        );
      },
    );

    iaAssistSubscription = iaAssistBloc.stream.listen(
      (iaAssistState) {
        add(
          ChangeIAAssistStateEvent(
            iaAssistState: iaAssistState,
          ),
        );
      },
    );
  }

  void _changeSearchEmployeeStateEvent(
    ChangeSearchEmployeeStateEvent event,
    Emitter<WriteFeedbackScreenState> emit,
  ) {
    emit(
      state.currentState(
        searchEmployeeState: event.searchEmployeeState,
      ),
    );
  }

  void _changeSearchCompetencesStateEvent(
    ChangeSearchCompetencesStateEvent event,
    Emitter<WriteFeedbackScreenState> emit,
  ) {
    emit(
      state.currentState(
        searchCompetencesState: event.searchCompetencesState,
      ),
    );
  }

  void _changeSendFeedbackStateEvent(
    ChangeSendFeedbackStateEvent event,
    Emitter<WriteFeedbackScreenState> emit,
  ) {
    emit(
      state.currentState(
        sendFeedbackState: event.sendFeedbackState,
      ),
    );
  }

  void _changeProficiencyListStateEvent(
    ChangeProficiencyListStateEvent event,
    Emitter<WriteFeedbackScreenState> emit,
  ) {
    emit(
      state.currentState(
        proficiencyListState: event.proficiencyListState,
      ),
    );
  }

  void _changeUserInfoFeedbackStateEvent(
    ChangeUserInfoFeedbackStateEvent event,
    Emitter<WriteFeedbackScreenState> emit,
  ) {
    emit(
      state.currentState(
        userInfoFeedbackState: event.userInfoFeedbackState,
      ),
    );
  }

  void _changeIAAssistStateEvent(
    ChangeIAAssistStateEvent event,
    Emitter<WriteFeedbackScreenState> emit,
  ) {
    emit(
      state.currentState(
        iaAssistState: event.iaAssistState,
      ),
    );
  }

  @override
  Future<void> close() async {
    await searchEmployeeSubscription.cancel();
    await searchCompetencesSubscription.cancel();
    await sendFeedbackSubscription.cancel();
    await proficiencyListSubscription.cancel();
    await userInfoFeedbackSubscription.cancel();
    await iaAssistSubscription.cancel();
    return super.close();
  }
}
