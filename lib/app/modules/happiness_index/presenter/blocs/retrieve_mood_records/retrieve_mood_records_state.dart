import 'package:equatable/equatable.dart';

import '../../../domain/entities/happiness_index_mood_entity.dart';

abstract class RetrieveMoodRecordsState extends Equatable {
  final List<HappinessIndexMoodEntity> moods;

  const RetrieveMoodRecordsState({
    this.moods = const [],
  });

  @override
  List<Object?> get props {
    return [
      moods,
    ];
  }
}

class InitialRetrieveMoodRecordsState extends RetrieveMoodRecordsState {
  const InitialRetrieveMoodRecordsState() : super(moods: const []);
}

class LoadingRetrieveMoodRecordsState extends RetrieveMoodRecordsState {
  const LoadingRetrieveMoodRecordsState() : super(moods: const []);
}

class LoadedRetrieveMoodRecordsState extends RetrieveMoodRecordsState {
  const LoadedRetrieveMoodRecordsState({
    required List<HappinessIndexMoodEntity> moods,
  }) : super(moods: moods);
}

class ErrorRetrieveMoodRecordsState extends RetrieveMoodRecordsState {
  final String? message;

  const ErrorRetrieveMoodRecordsState({
    required this.message,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      message,
    ];
  }
}
