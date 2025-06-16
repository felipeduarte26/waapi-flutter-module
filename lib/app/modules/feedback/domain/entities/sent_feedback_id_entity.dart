import 'package:equatable/equatable.dart';

class SentFeedbackIdEntity extends Equatable {
  final String id;

  const SentFeedbackIdEntity({
    required this.id,
  });

  @override
  List<Object?> get props {
    return [
      id,
    ];
  }
}
