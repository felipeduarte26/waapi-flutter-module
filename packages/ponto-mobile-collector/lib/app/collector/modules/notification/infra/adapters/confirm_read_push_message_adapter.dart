import 'dart:convert';

import '../../domain/entities/confirm_read_push_message_entity.dart';

class ConfirmReadPushMessageAdapter {
  static Map<String, dynamic> toMap(String source) {
    return json.decode(source);
  }

  static ConfirmReadPushMessageEntity fromJSON(String source) {
    // Converta a string para UTF-8 antes de decodificar
    List<int> utf8Bytes = source.toString().codeUnits;
    String utf8String = utf8.decode(utf8Bytes);

    // Decodifica o JSON de forma segura usando try-catch para capturar erros de decodificação
    try {
      var decodedJson = jsonDecode(utf8String);
      bool confirmed = decodedJson['confirmed'];

      return ConfirmReadPushMessageEntity(
        confirmed: confirmed,
      );
    } catch (e) {
      // Em caso de erro de decodificação, imprime o erro e retorna uma lista vazia
      return ConfirmReadPushMessageEntity(confirmed: false);
    }
  }
}
