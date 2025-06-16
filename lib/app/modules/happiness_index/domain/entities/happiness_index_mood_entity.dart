import 'package:equatable/equatable.dart';

import '../../enums/happiness_index_mood_enum.dart';
import 'happiness_index_group_entity.dart';

class HappinessIndexMoodEntity extends Equatable {
  final HappinessIndexMoodEnum happinessIndexMood;
  final DateTime date;
  final List<HappinessIndexGroupEntity>? happinessIndexGroups;
  final String? note;

  const HappinessIndexMoodEntity({
    required this.happinessIndexMood,
    required this.date,
    required this.happinessIndexGroups,
    required this.note,
  });

  @override
  List<Object?> get props => [
        happinessIndexMood,
        date,
        happinessIndexGroups,
        note,
      ];
}
