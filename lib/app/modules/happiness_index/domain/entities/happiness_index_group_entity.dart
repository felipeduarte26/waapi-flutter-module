import 'package:equatable/equatable.dart';

import 'happiness_index_subgroup_entity.dart';

class HappinessIndexGroupEntity extends Equatable {
  final String? name;
  final List<HappinessIndexSubgroupEntity>? subgroups;

  const HappinessIndexGroupEntity({
    this.name,
    this.subgroups,
  });

  @override
  List<Object?> get props => [
        name,
        subgroups,
      ];
}
