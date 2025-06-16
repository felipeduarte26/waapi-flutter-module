import 'dart:convert';

import '../../infra/models/happiness_index_group_model.dart';
import 'happiness_index_subgroup_model_mapper.dart';

class HappinessIndexGroupModelMapper {
  final HappinessIndexSubgroupModelMapper _subgroupModelMapper;

  HappinessIndexGroupModelMapper({required HappinessIndexSubgroupModelMapper subgroupModelMapper})
      : _subgroupModelMapper = subgroupModelMapper;

  HappinessIndexGroupModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return HappinessIndexGroupModel(
      name: map['name'],
      subgroups: map['subGroupReason'] != null
          ? (map['subGroupReason'] as List).map(
              (subgroup) {
                return _subgroupModelMapper.fromMap(map: subgroup);
              },
            ).toList()
          : null,
    );
  }

  List<HappinessIndexGroupModel> fromJsonList({
    required String groupJson,
  }) {
    if (groupJson.isEmpty) {
      return [];
    }

    final groupsDecoded = jsonDecode(groupJson);

    return (groupsDecoded['moodReasons'] as List).map(
      (groupMap) {
        return fromMap(
          map: groupMap,
        );
      },
    ).toList();
  }
}
