import 'package:equatable/equatable.dart';

class SocialMentionEntity extends Equatable {
  final String mentionKey;
  final String mentionValue;

  const SocialMentionEntity({
    required this.mentionKey,
    required this.mentionValue,
  });
  @override
  List<Object> get props => [
        mentionKey,
        mentionValue,
      ];
}
