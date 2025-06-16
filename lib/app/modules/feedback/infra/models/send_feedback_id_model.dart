import 'package:equatable/equatable.dart';

class SendFeedbackIdModel extends Equatable {
  final String id;

  const SendFeedbackIdModel({
    required this.id,
  });

  @override
  List<Object?> get props {
    return [
      id,
    ];
  }
}
