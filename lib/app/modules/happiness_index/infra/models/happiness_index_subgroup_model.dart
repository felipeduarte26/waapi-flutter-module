import 'package:equatable/equatable.dart';

import 'happiness_index_reason_model.dart';

class HappinessIndexSubgroupModel extends Equatable {
  final String? name;
  final bool? isDefault;
  final List<HappinessIndexReasonModel>? reasons;

  const HappinessIndexSubgroupModel({
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
