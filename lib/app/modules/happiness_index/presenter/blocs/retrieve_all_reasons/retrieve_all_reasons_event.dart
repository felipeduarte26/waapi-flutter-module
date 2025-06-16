import 'package:equatable/equatable.dart';

abstract class RetrieveAllReasonsEvent extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class GetRetrieveAllReasonsEvent extends RetrieveAllReasonsEvent {
  final String language;

  GetRetrieveAllReasonsEvent({
    required this.language,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      language,
    ];
  }
}
