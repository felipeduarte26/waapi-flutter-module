import 'package:equatable/equatable.dart';

class SocialMentionModel extends Equatable {
  final String mentionKey;
  final String mentionValue;

  const SocialMentionModel({
    required this.mentionKey,
    required this.mentionValue,
  });
  @override
  List<Object> get props => [
        mentionKey,
        mentionValue,
      ];
}
