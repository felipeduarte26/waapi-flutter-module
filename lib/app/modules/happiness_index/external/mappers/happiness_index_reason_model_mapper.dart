import '../../infra/models/happiness_index_reason_model.dart';

class HappinessIndexReasonModelMapper {
  HappinessIndexReasonModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return HappinessIndexReasonModel(
      id: map['id'],
      description: map['description'],
    );
  }
}
