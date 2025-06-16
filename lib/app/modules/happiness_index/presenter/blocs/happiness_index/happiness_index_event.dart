import 'package:equatable/equatable.dart';

import '../../../enums/happiness_index_mood_enum.dart';

abstract class HappinessIndexEvent extends Equatable {
  const HappinessIndexEvent();

  @override
  List<Object> get props {
    return [];
  }
}

class GetCurrentHappinessIndexEvent extends HappinessIndexEvent {
  final String language;

  const GetCurrentHappinessIndexEvent({
    required this.language,
  });

  @override
  List<Object> get props {
    return [
      ...super.props,
      language,
    ];
  }
}

class SaveHappinessIndexEvent extends HappinessIndexEvent {
  final HappinessIndexMoodEnum mood;
  final String language;
  final String notes;
  final List<String> reasons;

  const SaveHappinessIndexEvent({
    required this.mood,
    required this.language,
    required this.notes,
    required this.reasons,
  });

  @override
  List<Object> get props {
    return [
      ...super.props,
      language,
      mood,
      notes,
      reasons,
    ];
  }
}

class HappinessIndexIsEnabledEvent extends HappinessIndexEvent {}
