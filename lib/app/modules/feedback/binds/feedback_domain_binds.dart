import 'package:flutter_modular/flutter_modular.dart';

import '../domain/usecases/delete_feedback_usecase.dart';
import '../domain/usecases/get_feedback_by_id_usecase.dart';
import '../domain/usecases/get_feedback_request_details_usecase.dart';
import '../domain/usecases/get_feedback_requests_usecase.dart';
import '../domain/usecases/get_latest_feedbacks_usecase.dart';
import '../domain/usecases/get_proficiency_list_usecase.dart';
import '../domain/usecases/get_received_feedbacks_usecase.dart';
import '../domain/usecases/get_sent_feedbacks_usecase.dart';
import '../domain/usecases/get_user_info_feedback_usecase.dart';
import '../domain/usecases/request_feedback_usecase.dart';
import '../domain/usecases/search_competences_usecase.dart';
import '../domain/usecases/search_employees_usecase.dart';
import '../domain/usecases/send_feedback_usecase.dart';
import '../domain/usecases/set_feedback_private_usecase.dart';
import '../domain/usecases/set_feedback_public_usecase.dart';

class FeedbackDomainBinds {
  static List<Bind<Object>> binds = [
    // Usecases
    Bind.singleton<SearchCompetencesUsecase>((i) {
      return SearchCompetencesUsecaseImpl(
        searchCompetencesRepository: i.get(),
      );
    }),

    Bind.singleton<GetLatestFeedbacksUsecase>(
      (i) {
        return GetLatestFeedbacksUsecaseImpl(
          getReceivedFeedbacksRepository: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton<RequestFeedbackUsecase>((i) {
      return RequestFeedbackUsecaseImpl(
        requestFeedbackRepository: i.get(),
      );
    }),

    Bind.singleton<GetFeedbackRequestsUsecase>((i) {
      return GetFeedbackRequestsUsecaseImpl(
        getFeedbackRequestsRepository: i.get(),
      );
    }),

    Bind.singleton<GetReceivedFeedbacksUsecase>((i) {
      return GetReceivedFeedbacksUsecaseImpl(
        getReceivedFeedbacksRepository: i.get(),
      );
    }),

    Bind.singleton<GetFeedbackByIdUsecase>((i) {
      return GetFeedbackByIdUsecaseImpl(
        getFeedbackByIdRepository: i.get(),
      );
    }),

    Bind.singleton<GetSentFeedbacksUsecase>((i) {
      return GetSentFeedbacksUsecaseImpl(
        getSentFeedbacksRepository: i.get(),
      );
    }),

    Bind.singleton<SetFeedbackPrivateUsecase>((i) {
      return SetFeedbackPrivateUsecaseImpl(
        setFeedbackPrivateRepository: i.get(),
      );
    }),

    Bind.singleton<SetFeedbackPublicUsecase>((i) {
      return SetFeedbackPublicUsecaseImpl(
        setFeedbackPublicRepository: i.get(),
      );
    }),

    Bind.singleton<DeleteFeedbackUsecase>((i) {
      return DeleteFeedbackUsecaseImpl(
        deleteFeedbackRepository: i.get(),
      );
    }),

    Bind.singleton<SearchEmployeesUsecase>((i) {
      return SearchEmployeesUsecaseImpl(
        searchEmployeesRepository: i.get(),
      );
    }),

    Bind.singleton<GetProficiencyListUsecase>((i) {
      return GetProficiencyListUsecaseImpl(
        getProficiencyListRepository: i.get(),
      );
    }),

    Bind.singleton<GetUserInfoFeedbackUsecase>((i) {
      return GetUserInfoFeedbackUsecaseImpl(
        getUserInfoFeedbackRepository: i.get(),
      );
    }),

    Bind.singleton<SendFeedbackUsecase>((i) {
      return SendFeedbackUsecaseImpl(
        sendFeedbackRepository: i.get(),
      );
    }),

    Bind.singleton<GetFeedbackRequestDetailsUsecase>((i) {
      return GetFeedbackRequestDetailsUsecaseImpl(
        getFeedbackRequestDetailsRepository: i.get(),
      );
    }),
  ];
}
