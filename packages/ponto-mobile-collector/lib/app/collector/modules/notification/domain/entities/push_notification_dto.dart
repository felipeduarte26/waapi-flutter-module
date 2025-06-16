import 'push_message_entity.dart';

class PushNotificationDto {
  List<PushMessageEntity> messages;

  PushNotificationDto({
    required this.messages,
  });

  factory PushNotificationDto.fromJson(Map<String, dynamic> json) {
    return PushNotificationDto(
      messages: (json['messages'] as List<dynamic>)
          .map((e) => PushMessageEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'messages': messages.map((e) => e.toJson()).toList(),
    };
  }
}
