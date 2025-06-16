import 'dart:convert';

import '../../infra/models/happiness_index_subgroup_model.dart';
import 'happiness_index_reason_model_mapper.dart';

class HappinessIndexSubgroupModelMapper {
  final HappinessIndexReasonModelMapper _reasonModelMapper;

  const HappinessIndexSubgroupModelMapper({
    required HappinessIndexReasonModelMapper reasonModelMapper,
  }) : _reasonModelMapper = reasonModelMapper;

  HappinessIndexSubgroupModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return HappinessIndexSubgroupModel(
      isDefault: map['isDefault'],
      name: map['name'],
      reasons: map['reason'] != null
          ? (map['reason'] as List).map(
              (reason) {
                return _reasonModelMapper.fromMap(map: reason);
              },
            ).toList()
          : null,
    );
  }

  List<HappinessIndexSubgroupModel> fromJsonList({
    required String subgroupJson,
  }) {
    if (subgroupJson.isEmpty) {
      return [];
    }

    final subgroupsDecoded = jsonDecode(subgroupJson);

    return (subgroupsDecoded as List).map(
      (subgroupMap) {
        return fromMap(
          map: subgroupMap,
        );
      },
    ).toList();
  }
}
