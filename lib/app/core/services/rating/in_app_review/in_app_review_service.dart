import 'package:in_app_review/in_app_review.dart';

import '../../error_logging/error_logging_service.dart';
import '../rating_service.dart';

class InAppReviewService implements RatingService<InAppReview> {
  final InAppReview _instance;
  final ErrorLoggingService _errorLoggingService;

  const InAppReviewService({
    required InAppReview instance,
    required ErrorLoggingService errorLoggingService,
  })  : _instance = instance,
        _errorLoggingService = errorLoggingService;

  @override
  InAppReview get instance {
    return _instance;
  }

  @override
  Future<void> ratingAction() async {
    try {
      final isAvailable = await instance.isAvailable();
      if (isAvailable) {
        instance.requestReview();
      }
    } catch (error, stackTrace) {
      _errorLoggingService.recordError(
        exception: error,
        stackTrace: stackTrace,
      );
    }
  }
}
