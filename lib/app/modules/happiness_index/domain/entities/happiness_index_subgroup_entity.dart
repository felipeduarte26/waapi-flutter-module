import 'package:equatable/equatable.dart';

import 'happiness_index_reason_entity.dart';

class HappinessIndexSubgroupEntity extends Equatable {
  final String? name;
  final bool? isDefault;
  final List<HappinessIndexReasonEntity>? reasons;

  const HappinessIndexSubgroupEntity({
    this.name,
    this.isDefault,
    this.reasons,
  });

  @override
  List<Object?> get props => [
        name,
        isDefault,
        reasons,
      ];
}
