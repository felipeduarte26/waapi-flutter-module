import '../../domain/entities/happiness_index_reason_entity.dart';
import '../models/happiness_index_reason_model.dart';

class HappinessIndexReasonEntityAdapter {
  HappinessIndexReasonEntity fromModel({
    required HappinessIndexReasonModel reasonModel,
  }) {
    return HappinessIndexReasonEntity(
      id: reasonModel.id,
      description: reasonModel.description,
    );
  }
}
