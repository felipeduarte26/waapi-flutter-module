import '../../../core/helper/enum_helper.dart';
import '../enums/notification_type_enum.dart';

abstract class NotificationFilter {
  static bool typeIsAccepted({
    String? type,
  }) {
    final selectedNotificationType = EnumHelper<NotificationTypeEnum>().stringToEnum(
      stringToParse: type,
      values: NotificationTypeEnum.values,
    );

    return NotificationTypeEnum.values.contains(selectedNotificationType);
  }
}
