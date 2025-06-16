import 'package:flutter_modular/flutter_modular.dart';

import '../../routes/routes.dart';
import '../attachment/attachment_module.dart';
import '../ia_assist/ia_assist_module.dart';
import 'binds/feedback_domain_binds.dart';
import 'binds/feedback_external_binds.dart';
import 'binds/feedback_infra_binds.dart';
import 'binds/feedback_presenter_binds.dart';
import 'presenter/screens/details_received_feedback/blocs/details_received_feedback_screen_bloc/details_received_feedback_screen_bloc.dart';
import 'presenter/screens/details_received_feedback/details_received_feedback_screen.dart';
import 'presenter/screens/details_request_feedback/details_request_feedback_screen.dart';
import 'presenter/screens/details_sent_feedback/details_sent_feedback_screen.dart';
import 'presenter/screens/feedback_attachments/feedback_attachments_screen.dart';
import 'presenter/screens/feedbacks_screen/bloc/feedbacks_screen_bloc.dart';
import 'presenter/screens/feedbacks_screen/feedbacks_screen.dart';
import 'presenter/screens/request_feedback/request_feedback_screen.dart';
import 'presenter/screens/write_feedback_screen/write_feedback_screen.dart';

class FeedbackModule extends Module {
  @override
  List<Bind<Object>> get binds {
    return [
      ...FeedbackDomainBinds.binds,
      ...FeedbackInfraBinds.binds,
      ...FeedbackExternalBinds.binds,
      ...FeedbackPresenterBinds.binds,
    ];
  }

  @override
  List<Module> get imports {
    return [
      AttachmentModule(),
      IAAssistModule(),
    ];
  }

  @override
  List<ModularRoute> get routes {
    return [
      ChildRoute(
        FeedbackRoutes.feedbackScreenRoute,
        child: (_, __) {
          return FeedbacksScreen(
            feedbacksScreenBloc: Modular.get<FeedbacksScreenBloc>(),
          );
        },
      ),
      ChildRoute(
        FeedbackRoutes.detailsSentFeedbackScreenRoute,
        child: (_, args) {
          return DetailsSentFeedbackScreen(
            sentFeedbackId: args.data['sentFeedbackId'],
          );
        },
      ),
      ChildRoute(
        FeedbackRoutes.feedbackAttachmentsScreenRoute,
        child: (_, args) {
          return FeedbackAttachmentsScreen(
            feedbackEntity: args.data['feedbackEntity'],
          );
        },
      ),
      ChildRoute(
        FeedbackRoutes.writeFeedbackScreenRoute,
        child: (_, args) {
          return WriteFeedbackScreen(
            feedbackRequestEntity: args.data['feedbackRequestEntity'],
            feedbackAnalyticsTypeEnum: args.data['feedbackAnalyticsTypeEnum'],
            personId: args.data['personId'],
          );
        },
      ),
      ChildRoute(
        FeedbackRoutes.feedbacksDetailsReceivedModuleRoute,
        child: (_, args) {
          return DetailsReceivedFeedbackScreen(
            detailsReceivedFeedbacksScreenBloc: Modular.get<DetailsReceivedFeedbackScreenBloc>(),
            receivedFeedbackId: args.data['receivedFeedbackId'],
          );
        },
      ),
      ChildRoute(
        FeedbackRoutes.detailsRequestFeedbackScreenRoute,
        child: (_, args) {
          return DetailsRequestFeedbackScreen(
            feedbackRequestId: args.data['feedbackRequestId'],
            isRequestedByMe: args.data['isRequestedByMe'],
          );
        },
      ),
      ChildRoute(
        FeedbackRoutes.requestFeedbackScreenRoute,
        child: (_, args) {
          return const RequestFeedbackScreen();
        },
      ),
    ];
  }
}
