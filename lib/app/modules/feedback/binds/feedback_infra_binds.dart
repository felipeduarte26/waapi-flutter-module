import 'package:flutter_modular/flutter_modular.dart';

import '../../attachment/infra/adapters/attachment_entity_adapter.dart';
import '../domain/repositories/delete_feedback_repository.dart';
import '../domain/repositories/get_feedback_by_id_repository.dart';
import '../domain/repositories/get_feedback_request_details_repository.dart';
import '../domain/repositories/get_feedback_requests_repository.dart';
import '../domain/repositories/get_proficiency_list_repository.dart';
import '../domain/repositories/get_received_feedbacks_repository.dart';
import '../domain/repositories/get_sent_feedbacks_repository.dart';
import '../domain/repositories/get_user_info_feedback_repository.dart';
import '../domain/repositories/request_feedback_repository.dart';
import '../domain/repositories/search_competences_repository.dart';
import '../domain/repositories/search_employees_repository.dart';
import '../domain/repositories/send_feedback_repository.dart';
import '../domain/repositories/set_feedback_private_repository.dart';
import '../domain/repositories/set_feedback_public_repository.dart';
import '../infra/adapters/employee_entity_adapter.dart';
import '../infra/adapters/feedback_entity_adapter.dart';
import '../infra/adapters/feedback_request_by_me_entity_adapter.dart';
import '../infra/adapters/feedback_request_to_me_entity_adapter.dart';
import '../infra/adapters/proficiency_feedback_entity_adapter.dart';
import '../infra/adapters/sent_feedback_id_entity_adapter.dart';
import '../infra/adapters/skill_feedback_entity_adapter.dart';
import '../infra/adapters/user_info_feedback_entity_adapter.dart';
import '../infra/repositories/delete_feedback_repository_impl.dart';
import '../infra/repositories/get_feedback_by_id_repository_impl.dart';
import '../infra/repositories/get_feedback_request_details_repository_impl.dart';
import '../infra/repositories/get_feedback_requests_repository_impl.dart';
import '../infra/repositories/get_proficiency_list_repository_impl.dart';
import '../infra/repositories/get_received_feedbacks_repository_impl.dart';
import '../infra/repositories/get_sent_feedbacks_repository_impl.dart';
import '../infra/repositories/get_user_info_feedback_repository_impl.dart';
import '../infra/repositories/request_feedback_repository_impl.dart';
import '../infra/repositories/search_competences_repository_impl.dart';
import '../infra/repositories/search_employees_repository_impl.dart';
import '../infra/repositories/send_feedback_repository_impl.dart';
import '../infra/repositories/set_feedback_private_repository_impl.dart';
import '../infra/repositories/set_feedback_public_repository_impl.dart';

class FeedbackInfraBinds {
  static List<Bind<Object>> binds = [
    // Repositories
    Bind.singleton<SearchCompetencesRepository>((i) {
      return SearchCompetencesRepositoryImpl(
        searchCompetencesDatasource: i.get(), 
        skillFeedbackEntityAdapter: i.get(),
      );
    }),

    Bind.singleton<DeleteFeedbackRepository>((i) {
      return DeleteFeedbackRepositoryImpl(
        deleteFeedbackDatasource: i.get(),
      );
    }),

    Bind.singleton<RequestFeedbackRepository>((i) {
      return RequestFeedbackRepositoryImpl(
        requestFeedbackDatasource: i.get(),
      );
    }),

    Bind.singleton<GetFeedbackRequestsRepository>((i) {
      return GetFeedbackRequestsRepositoryImpl(
        feedbackRequestByMeEntityAdapter: i.get(),
        feedbackRequestToMeEntityAdapter: i.get(),
        getFeedbackRequestsDatasource: i.get(),
        
      );
    }),

    Bind.singleton<GetReceivedFeedbacksRepository>(
      (i) {
        return GetReceivedFeedbacksRepositoryImpl(
          getReceivedFeedbacksDatasource: i.get(),
          feedbackEntityAdapter: i.get(),
          
        );
      },
      export: true,
    ),

    Bind.singleton<GetFeedbackByIdRepository>(
      (i) {
        return GetFeedbackByIdRepositoryImpl(
          getFeedbackByIdDatasource: i.get(),
          feedbackEntityAdapter: i.get(),
          
        );
      },
      export: true,
    ),

    Bind.singleton<GetSentFeedbacksRepository>((i) {
      return GetSentFeedbacksRepositoryImpl(
        getSentFeedbacksDatasource: i.get(),
        feedbackEntityAdapter: i.get(),
        
      );
    }),

    Bind.singleton<SetFeedbackPrivateRepository>((i) {
      return SetFeedbackPrivateRepositoryImpl(
        setFeedbackPrivateDatasource: i.get(),
        
      );
    }),

    Bind.singleton<SetFeedbackPublicRepository>((i) {
      return SetFeedbackPublicRepositoryImpl(
        setFeedbackPublicDatasource: i.get(),
        
      );
    }),

    Bind.singleton<SearchEmployeesRepository>((i) {
      return SearchEmployeesRepositoryImpl(
        searchEmployeesDatasource: i.get(),
        employeeEntityAdapter: i.get(),
        
      );
    }),

    Bind.singleton<GetProficiencyListRepository>((i) {
      return GetProficiencyListRepositoryImpl(
        getProficiencyListDatasource: i.get(),
        proficiencyEntityAdapter: i.get(),
        
      );
    }),

    Bind.singleton<GetUserInfoFeedbackRepository>((i) {
      return GetUserInfoFeedbackRepositoryImpl(
        getUserInfoFeedbackDatasource: i.get(),
        userInfoFeedbackEntityAdapter: i.get(),
        
      );
    }),

    Bind.singleton<SendFeedbackRepository>((i) {
      return SendFeedbackRepositoryImpl(
        sendFeedbackDatasource: i.get(),
        sentFeedbackIdEntityAdapter: i.get(),
      );
    }),

    Bind.singleton<GetFeedbackRequestDetailsRepository>((i) {
      return GetFeedbackRequestDetailsRepositoryImpl(
        feedbackRequestByMeEntityAdapter: i.get(),
        feedbackRequestToMeEntityAdapter: i.get(),
        getFeedbackRequestDetailsDatasource: i.get(),
        
      );
    }),

    // Entity adapters
    Bind.singleton(
      (i) {
        return FeedbackEntityAdapter(
          proficiencyFeedbackEntityAdapter: i.get(),
          attachmentEntityAdapter: i.get(),
          skillFeedbackEntityAdapter: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton((i) {
      return FeedbackEntityAdapter(
        proficiencyFeedbackEntityAdapter: i.get(),
        attachmentEntityAdapter: i.get(),
        skillFeedbackEntityAdapter: i.get(),
      );
    }),

    Bind.singleton((i) {
      return FeedbackRequestByMeEntityAdapter();
    }),

    Bind.singleton((i) {
      return FeedbackRequestToMeEntityAdapter();
    }),

    Bind.singleton(
      (i) {
        return ProficiencyFeedbackEntityAdapter();
      },
      export: true,
    ),

    Bind.singleton(
      (i) {
        return AttachmentEntityAdapter();
      },
      export: true,
    ),

    Bind.singleton(
      (i) {
        return SkillFeedbackEntityAdapter();
      },
      export: true,
    ),

    Bind.singleton((i) {
      return EmployeeEntityAdapter();
    }),

    Bind.singleton((i) {
      return UserInfoFeedbackEntityAdapter();
    }),

    Bind.singleton((i) {
      return SentFeedbackIdEntityAdapter();
    }),
  ];
}
