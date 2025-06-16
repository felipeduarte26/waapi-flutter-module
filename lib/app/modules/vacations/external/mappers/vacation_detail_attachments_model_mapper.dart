import '../../infra/models/vacation_detail_attachments_model.dart';

class VacationDetailAttachmentsModelMapper {
  static VacationDetailAttachmentsModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return VacationDetailAttachmentsModel(
      id: map['id'],
      name: map['name'],
      link: map['link'],
      personId: map['personId'],
      sourceId: map['sourceId'],
      sourceType: map['sourceType'],
    );
  }
}
