class FeedbackRoutes {
  // Module route name
  static const String feedbackModuleRoute = '/feedback';

  // Feedback screen routes name
  static const String feedbackScreenRoute = '/';
  static const String feedbackScreenInitialRoute = '$feedbackModuleRoute$feedbackScreenRoute';

  // Details feedback
  static const String detailsSentFeedbackScreenRoute = '/details_sent_feedback';
  static const String detailsFeedbackScreenInitialRoute = '$feedbackModuleRoute$detailsSentFeedbackScreenRoute';

  // Request feedback
  static const String requestFeedbackScreenRoute = '/request_feedback';
  static const String requestFeedbackScreenInitialRoute = '$feedbackModuleRoute$requestFeedbackScreenRoute';

  // Feedback attachments
  static const String feedbackAttachmentsScreenRoute = '/attachments';
  static const String feedbackAttachmentsScreenInitialRoute = '$feedbackModuleRoute$feedbackAttachmentsScreenRoute';

  // Feedback write_feedback
  static const String writeFeedbackScreenRoute = '/write_feedback';
  static const String writeFeedbackScreenInitialRoute = '$feedbackModuleRoute$writeFeedbackScreenRoute';

  // DetailsReceivedFeedbacksScreen screen routes name
  static const String feedbacksDetailsReceivedModuleRoute = '/details_received_feedbacks';
  static const String toFeedbacksDetailsReceivedScreenRoute =
      '$feedbackModuleRoute$feedbacksDetailsReceivedModuleRoute';

  // Details request feedback
  static const String detailsRequestFeedbackScreenRoute = '/details_request_feedback';
  static const String detailsRequestFeedbackScreenInitialRoute =
      '$feedbackModuleRoute$detailsRequestFeedbackScreenRoute';
}
