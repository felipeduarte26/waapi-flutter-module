import 'package:flutter_modular/flutter_modular.dart';

import '../external/datasources/delete_feedback_datasource_impl.dart';
import '../external/datasources/get_feedback_by_id_datasource_impl.dart';
import '../external/datasources/get_feedback_request_details_datasource_impl.dart';
import '../external/datasources/get_feedback_requests_datasource_impl.dart';
import '../external/datasources/get_proficiency_list_datasource_impl.dart';
import '../external/datasources/get_received_feedbacks_datasource_impl.dart';
import '../external/datasources/get_sent_feedbacks_datasource_impl.dart';
import '../external/datasources/get_user_info_feedback_datasource_impl.dart';
import '../external/datasources/request_feedback_datasource_impl.dart';
import '../external/datasources/search_competences_datasource_impl.dart';
import '../external/datasources/search_employees_datasource_impl.dart';
import '../external/datasources/send_feedback_datasource_impl.dart';
import '../external/datasources/set_feedback_private_datasource_impl.dart';
import '../external/datasources/set_feedback_public_datasource_impl.dart';
import '../external/mappers/employee_model_mapper.dart';
import '../external/mappers/feedback_model_list_mapper.dart';
import '../external/mappers/feedback_model_mapper.dart';
import '../external/mappers/feedback_request_by_me_model_mapper.dart';
import '../external/mappers/feedback_request_model_mapper.dart';
import '../external/mappers/feedback_request_to_me_model_mapper.dart';
import '../external/mappers/proficiency_feedback_model_mapper.dart';
import '../external/mappers/request_feedback_input_model_mapper.dart';
import '../external/mappers/send_feedback_id_model_mapper.dart';
import '../external/mappers/send_feedback_input_model_mapper.dart';
import '../external/mappers/skill_feedback_model_mapper.dart';
import '../external/mappers/user_info_feedback_model_mapper.dart';
import '../infra/datasources/delete_feedback_datasource.dart';
import '../infra/datasources/get_feedback_by_id_datasource.dart';
import '../infra/datasources/get_feedback_request_details_datasource.dart';
import '../infra/datasources/get_feedback_requests_datasource.dart';
import '../infra/datasources/get_proficiency_list_datasource.dart';
import '../infra/datasources/get_received_feedbacks_datasource.dart';
import '../infra/datasources/get_sent_feedbacks_datasource.dart';
import '../infra/datasources/get_user_info_feedback_datasource.dart';
import '../infra/datasources/request_feedback_datasource.dart';
import '../infra/datasources/search_competences_datasource.dart';
import '../infra/datasources/search_employees_datasource.dart';
import '../infra/datasources/send_feedback_datasource.dart';
import '../infra/datasources/set_feedback_private_datasource.dart';
import '../infra/datasources/set_feedback_public_datasource.dart';

class FeedbackExternalBinds {
  static List<Bind<Object>> binds = [
    // Datasources
    Bind.singleton<SearchCompetencesDatasource>((i) {
      return SearchCompetencesDatasourceImpl(
        restService: i.get(),
        skillFeedbackModelMapper: i.get(),
      );
    }),

    Bind.singleton<DeleteFeedbackDatasource>((i) {
      return DeleteFeedbackDatasourceImpl(
        restService: i.get(),
      );
    }),

    Bind.singleton<RequestFeedbackDatasource>((i) {
      return RequestFeedbackDatasourceImpl(
        restService: i.get(),
        requestFeedbackInputModelMapper: i.get(),
      );
    }),

    Bind.singleton<GetFeedbackRequestsDatasource>((i) {
      return GetFeedbackRequestsDatasourceImpl(
        restService: i.get(),
        feedbackRequestByMeModelMapper: i.get(),
        feedbackRequestToMeModelMapper: i.get(),
      );
    }),

    Bind.singleton<GetReceivedFeedbacksDatasource>(
      (i) {
        return GetReceivedFeedbacksDatasourceImpl(
          restService: i.get(),
          feedbackModelListMapper: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton<GetFeedbackByIdDatasource>(
      (i) {
        return GetFeedbackByIdDatasourceImpl(
          restService: i.get(),
          feedbackModelMapper: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton<GetSentFeedbacksDatasource>((i) {
      return GetSentFeedbacksDatasourceImpl(
        restService: i.get(),
        feedbackModelListMapper: i.get(),
      );
    }),

    Bind.singleton<SetFeedbackPrivateDatasource>((i) {
      return SetFeedbackPrivateDatasourceImpl(
        restService: i.get(),
      );
    }),

    Bind.singleton<SetFeedbackPublicDatasource>((i) {
      return SetFeedbackPublicDatasourceImpl(
        restService: i.get(),
      );
    }),

    Bind.singleton<SearchEmployeesDatasource>((i) {
      return SearchEmployeesDatasourceImpl(
        employeeModelMapper: i.get(),
        restService: i.get(),
      );
    }),

    Bind.singleton<GetProficiencyListDatasource>((i) {
      return GetProficiencyListDatasourceImpl(
        proficiencyModelMapper: i.get(),
        restService: i.get(),
      );
    }),

    Bind.singleton<GetUserInfoFeedbackDatasource>((i) {
      return GetUserInfoFeedbackDatasourceImpl(
        userInfoFeedbackModelMapper: i.get(),
        restService: i.get(),
      );
    }),

    Bind.singleton<SendFeedbackDatasource>((i) {
      return SendFeedbackDatasourceImpl(
        sendFeedbackInputModelMapper: i.get(),
        sentFeedbackIdModelMapper: i.get(),
        restService: i.get(),
      );
    }),

    Bind.singleton<GetFeedbackRequestDetailsDatasource>((i) {
      return GetFeedbackRequestDetailsDatasourceImpl(
        requestModelMapper: i.get(),
        restService: i.get(),
      );
    }),

    // Mappers
    Bind.singleton((i) {
      return FeedbackRequestByMeModelMapper();
    }),

    Bind.singleton((i) {
      return FeedbackRequestToMeModelMapper();
    }),

    Bind.singleton(
      (i) {
        return FeedbackModelListMapper(
          feedbackModelMapper: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton(
      (i) {
        return FeedbackModelMapper(
          skillFeedbackModelMapper: i.get(),
          proficiencyFeedbackModelMapper: i.get(),
          attachmentModelMapper: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton(
      (i) {
        return FeedbackModelMapper(
          skillFeedbackModelMapper: i.get(),
          proficiencyFeedbackModelMapper: i.get(),
          attachmentModelMapper: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton((i) {
      return FeedbackModelListMapper(
        feedbackModelMapper: i.get(),
      );
    }),

    Bind.singleton((i) {
      return FeedbackModelMapper(
        skillFeedbackModelMapper: i.get(),
        proficiencyFeedbackModelMapper: i.get(),
        attachmentModelMapper: i.get(),
      );
    }),

    Bind.singleton(
      (i) {
        return SkillFeedbackModelMapper();
      },
      export: true,
    ),

    Bind.singleton(
      (i) {
        return ProficiencyFeedbackModelMapper();
      },
      export: true,
    ),

    Bind.singleton((i) {
      return EmployeeModelMapper();
    }),

    Bind.singleton((i) {
      return UserInfoFeedbackModelMapper();
    }),

    Bind.singleton((i) {
      return SendFeedbackInputModelMapper();
    }),

    Bind.singleton((i) {
      return SendFeedbackIdModelMapper();
    }),

    Bind.singleton((i) {
      return RequestFeedbackInputModelMapper();
    }),

    Bind.singleton((i) {
      return FeedbackRequestModelMapper(
        feedbackRequestByMeModelMapper: i.get(),
        feedbackRequestToMeModelMapper: i.get(),
      );
    }),
  ];
}
