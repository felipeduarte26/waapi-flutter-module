import 'dart:convert';

import '../../infra/models/attachment_model.dart';

class AttachmentModelMapper {
  AttachmentModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return AttachmentModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      link: map['link'] ?? '',
      personId: map['personId'] ?? '',
    );
  }

  AttachmentModel fromJson({
    required String attachmentJson,
  }) {
    final List jsonToList = json.decode(attachmentJson);

    return fromMap(
      map: jsonToList.first,
    );
  }
}
