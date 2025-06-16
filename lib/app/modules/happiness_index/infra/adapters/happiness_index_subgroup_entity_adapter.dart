import '../../domain/entities/happiness_index_reason_entity.dart';
import '../../domain/entities/happiness_index_subgroup_entity.dart';
import '../models/happiness_index_subgroup_model.dart';

class HappinessIndexSubgroupEntityAdapter {
  HappinessIndexSubgroupEntity fromModel({
    required HappinessIndexSubgroupModel subgroupModel,
  }) {
    return HappinessIndexSubgroupEntity(
      isDefault: subgroupModel.isDefault,
      name: subgroupModel.name,
      reasons: subgroupModel.reasons
          ?.map(
            (reason) => HappinessIndexReasonEntity(
              id: reason.id,
              description: reason.description,
            ),
          )
          .toList(),
    );
  }
}
