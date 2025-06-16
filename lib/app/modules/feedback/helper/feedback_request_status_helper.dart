import '../../../core/extension/string_extension.dart';
import '../enums/feedback_request_status_enum.dart';

abstract class FeedbackRequestStatusHelper {
  static FeedbackRequestStatusEnum? stringToEnum({
    required String? string,
  }) {
    if (string != null && string.isNotEmpty) {
      final formattedString = string.toCamelCase;
      return FeedbackRequestStatusEnum.values.asNameMap()[formattedString]!;
    }

    return null;
  }

  static String enumToString({
    required FeedbackRequestStatusEnum status,
  }) {
    return status.name.toSnakeCase;
  }
}
