import 'package:equatable/equatable.dart';

abstract class ProficiencyListEvent extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class ProficiencyListToWriteFeedbackEvent extends ProficiencyListEvent {
  ProficiencyListToWriteFeedbackEvent();

  @override
  List<Object?> get props {
    return [
      ...super.props,
    ];
  }
}

class SelectedStarCountFeedbackEvent extends ProficiencyListEvent {}
