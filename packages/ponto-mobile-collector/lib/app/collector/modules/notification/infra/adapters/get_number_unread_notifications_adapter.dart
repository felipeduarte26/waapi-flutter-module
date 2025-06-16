import 'dart:convert';

import '../../domain/entities/has_unread_push_message_entity.dart';

class GetNumberUnreadNotificationsAdapter {
  static Map<String, dynamic> toMap(String source) {
    return json.decode(source);
  }

   static HasUnreadPushMessageEntity fromJSON(String source) {
    // Converta a string para UTF-8 antes de decodificar
    List<int> utf8Bytes = source.toString().codeUnits;
    String utf8String = utf8.decode(utf8Bytes);

    // Decodifica o JSON de forma segura usando try-catch para capturar erros de decodificação
    try {
      var decodedJson = jsonDecode(utf8String);
      bool hasUnreadPushMessage = decodedJson['hasUnreadPushMessage'];
      int number = decodedJson['number'];
      
      return HasUnreadPushMessageEntity(hasUnreadPushMessage: hasUnreadPushMessage, number: number);
    } catch (e) {
      // Em caso de erro de decodificação, imprime o erro e retorna uma lista vazia
      return HasUnreadPushMessageEntity(hasUnreadPushMessage: false, number: 0);
    }
  }

}
