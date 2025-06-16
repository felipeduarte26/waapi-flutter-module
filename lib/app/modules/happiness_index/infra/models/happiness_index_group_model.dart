import 'package:equatable/equatable.dart';

import 'happiness_index_subgroup_model.dart';

class HappinessIndexGroupModel extends Equatable {
  final String? name;
  final List<HappinessIndexSubgroupModel>? subgroups;

  const HappinessIndexGroupModel({
    this.name,
    this.subgroups,
  });

  @override
  List<Object?> get props => [
        name,
        subgroups,
      ];
}
