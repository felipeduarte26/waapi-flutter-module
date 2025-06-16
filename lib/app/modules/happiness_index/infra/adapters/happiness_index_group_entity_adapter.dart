import '../../domain/entities/happiness_index_group_entity.dart';
import '../../domain/entities/happiness_index_reason_entity.dart';
import '../../domain/entities/happiness_index_subgroup_entity.dart';
import '../models/happiness_index_group_model.dart';

class HappinessIndexGroupEntityAdapter {
  HappinessIndexGroupEntity fromModel({
    required HappinessIndexGroupModel groupModel,
  }) {
    return HappinessIndexGroupEntity(
      name: groupModel.name,
      subgroups: groupModel.subgroups
          ?.map(
            (subgroup) => HappinessIndexSubgroupEntity(
              isDefault: subgroup.isDefault,
              name: subgroup.name,
              reasons: subgroup.reasons
                  ?.map(
                    (reason) => HappinessIndexReasonEntity(
                      id: reason.id,
                      description: reason.description,
                    ),
                  )
                  .toList(),
            ),
          )
          .toList(),
    );
  }
}
