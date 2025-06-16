import 'package:flutter_modular/flutter_modular.dart';

import '../presenter/blocs/details_received_feedback_bloc/details_received_feedback_bloc.dart';
import '../presenter/blocs/details_sent_feedback_bloc/details_sent_feedback_bloc.dart';
import '../presenter/blocs/feedback_person_bloc/feedback_person_bloc.dart';
import '../presenter/blocs/feedback_requests_bloc/feedback_requests_bloc.dart';
import '../presenter/blocs/proficiency_list_bloc/proficiency_list_bloc.dart';
import '../presenter/blocs/received_feedbacks_bloc/received_feedbacks_bloc.dart';
import '../presenter/blocs/request_feedback_bloc/request_feedback_bloc.dart';
import '../presenter/blocs/search_competences_bloc/search_competences_bloc.dart';
import '../presenter/blocs/search_employee_bloc/search_employee_bloc.dart';
import '../presenter/blocs/send_feedback_bloc/send_feedback_bloc.dart';
import '../presenter/blocs/sent_feedbacks_bloc/sent_feedbacks_bloc.dart';
import '../presenter/blocs/user_info_feedback_bloc/user_info_feedback_bloc.dart';
import '../presenter/screens/details_received_feedback/blocs/details_received_feedback_screen_bloc/details_received_feedback_screen_bloc.dart';
import '../presenter/screens/details_request_feedback/bloc/details_request_feedback_screen_bloc.dart';
import '../presenter/screens/details_sent_feedback/bloc/details_sent_feedback_screen_bloc.dart';
import '../presenter/screens/feedback_attachments/bloc/feedback_attachments_screen_bloc.dart';
import '../presenter/screens/feedbacks_screen/bloc/feedbacks_screen_bloc.dart';
import '../presenter/screens/request_feedback/bloc/request_feedback_screen_bloc.dart';
import '../presenter/screens/write_feedback_screen/bloc/write_feedback_screen_bloc.dart';

class FeedbackPresenterBinds {
  static List<Bind<Object>> binds = [
    // Blocs
    Bind.singleton((i) {
      return ReceivedFeedbacksBloc(
        getReceivedFeedbacksUsecase: i.get(),
        authorizationBloc: i.get(),
      );
    }),

    Bind.factory((i) {
      return RequestFeedbackBloc(
        requestFeedbackUsecase: i.get(),
      );
    }),

    Bind.factory((i) {
      return RequestFeedbackScreenBloc(
        requestFeedbackBloc: i.get(),
        searchEmployeeBloc: i.get(),
        feedbackPersonBloc: i.get(),
      );
    }),

    Bind.singleton((i) {
      return FeedbackRequestsBloc(
        getFeedbackRequestsUsecase: i.get(),
      );
    }),

    Bind.singleton((i) {
      return SentFeedbacksBloc(
        authorizationBloc: i.get(),
        getSentFeedbacksUsecase: i.get(),
      );
    }),

    Bind.singleton((i) {
      return FeedbacksScreenBloc(
        receivedFeedbacksBloc: i.get(),
        authorizationBloc: i.get(),
        feedbackRequestsBloc: i.get(),
        sentFeedbacksBloc: i.get(),
      );
    }),

    Bind.singleton((i) {
      return FeedbackAttachmentsScreenBloc(
        attachmentsBloc: i.get(),
      );
    }),

    Bind.factory((i) {
      return DetailsSentFeedbackBloc(
        deleteFeedbackUsecase: i.get(),
        getFeedbackByIdUsecase: i.get(),
      );
    }),

    Bind.factory((i) {
      return DetailsSentFeedbackScreenBloc(
        detailsSentFeedbackBloc: i.get(),
      );
    }),

    Bind.factory((i) {
      return SearchEmployeeBloc(
        searchEmployeesUsecase: i.get(),
      );
    }),

    Bind.factory((i) {
      return SearchCompetencesBloc(
        searchCompetencesUsecase: i.get(),
      );
    }),

    Bind.factory((i) {
      return ProficiencyListBloc(
        getProficiencyListUsecase: i.get(),
      );
    }),

    Bind.factory((i) {
      return UserInfoFeedbackBloc(
        getUserInfoFeedbackUsecase: i.get(),
      );
    }),

    Bind.factory((i) {
      return WriteFeedbackScreenBloc(
        searchEmployeeBloc: i.get(),
        searchCompetencesBloc: i.get(),
        sendFeedbackBloc: i.get(),
        proficiencyListBloc: i.get(),
        userInfoFeedbackBloc: i.get(),
        authorizationBloc: i.get(),
        iaAssistBloc: i.get(),
      );
    }),

    Bind.factory((i) {
      return SendFeedbackBloc(
        sendFeedbackUsecase: i.get(),
      );
    }),

    Bind.factory((i) {
      return DetailsReceivedFeedbackBloc(
        authorizationBloc: i.get(),
        setFeedbackPrivateUsecase: i.get(),
        setFeedbackPublicUsecase: i.get(),
        getFeedbackByIdUsecase: i.get(),
      );
    }),

    Bind.factory((i) {
      return DetailsReceivedFeedbackScreenBloc(
        authorizationBloc: i.get(),
        detailsReceivedFeedbacksBloc: i.get(),
        shareFileBloc: i.get(),
      );
    }),

    Bind.factory((i) {
      return DetailsRequestFeedbackScreenBloc(
        getFeedbackRequestDetailsUsecase: i.get(),
      );
    }),

    Bind.lazySingleton((i) {
      return FeedbackPersonBloc(
        getPersonIdUsecase: i.get(),
      );
    }),
  ];
}
