import 'package:equatable/equatable.dart';

class FeedbackAttachmentModel extends Equatable {
  final String id;
  final String name;
  final String link;
  final String personId;

  const FeedbackAttachmentModel({
    required this.id,
    required this.name,
    required this.link,
    required this.personId,
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      link,
      personId,
    ];
  }
}
