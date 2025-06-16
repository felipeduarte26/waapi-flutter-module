import 'package:equatable/equatable.dart';

abstract class DiversityEvent extends Equatable {
  const DiversityEvent();

  @override
  List<Object> get props {
    return [];
  }
}

class GetDiversityEvent extends DiversityEvent {
  final String personId;

  const GetDiversityEvent({
    required this.personId,
  });

  @override
  List<Object> get props {
    return [
      ...super.props,
      personId,
    ];
  }
}
