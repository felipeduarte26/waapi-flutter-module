import 'dart:convert';

import '../../domain/entities/push_message_entity.dart';
import '../../domain/entities/push_notification_dto.dart';

class PushNotificationAdapter {
  static Map<String, dynamic> toMap(String source) {
    return json.decode(source);
  }

   static PushNotificationDto fromJSON(String source) {
    // Converta a string para UTF-8 antes de decodificar
    List<int> utf8Bytes = source.toString().codeUnits;
    String utf8String = utf8.decode(utf8Bytes);

    // Decodifica o JSON de forma segura usando try-catch para capturar erros de decodificação
    try {
      var decodedJson = jsonDecode(utf8String);
      var pushMessageResult = decodedJson['messages'];

      var messagesResult = pushMessageResult['messages'];

      List<PushMessageEntity> messagesList = [];

      for (var message in messagesResult) {
        PushMessageEntity messageEntity = PushMessageEntity (
          id: message['id'],
          title: message['title'],
          messageContent: message['messageContent'],
          createdAt: DateTime.parse(message['createdAt']),
          read: message['read'],
        );
        messagesList.add(messageEntity);
      }
      
      return PushNotificationDto(messages: messagesList);
    } catch (e) {
      // Em caso de erro de decodificação, imprime o erro e retorna uma lista vazia
      return PushNotificationDto(messages: []);
    }
  }

}
