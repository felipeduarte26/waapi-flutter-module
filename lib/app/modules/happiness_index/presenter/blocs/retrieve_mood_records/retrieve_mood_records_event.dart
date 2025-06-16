import 'package:equatable/equatable.dart';

abstract class RetrieveMoodRecordsEvent extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class GetRetrieveMoodRecordsEvent extends RetrieveMoodRecordsEvent {
  final String language;
  final DateTime startDate;
  final DateTime endDate;

  GetRetrieveMoodRecordsEvent({
    required this.language,
    required this.startDate,
    required this.endDate,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      language,
      startDate,
      endDate,
    ];
  }
}
