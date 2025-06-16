import 'package:equatable/equatable.dart';

import '../../infra/utils/enum/type_journey_time_enum.dart';

class TimelineItemDto extends Equatable {
  final TypeJourneyTimeEnum? typeJourneyTimeEnum;
  final bool? isBeginning;
  final DateTime? startDate;
  final DateTime? endDate;

  const TimelineItemDto({
    this.typeJourneyTimeEnum,
    this.isBeginning,
    this.startDate,
    this.endDate,
  });

  @override
  List<Object?> get props => [
        typeJourneyTimeEnum,
        isBeginning,
        startDate,
        endDate,
      ];
}
