import 'package:equatable/equatable.dart';

abstract class SocialMentionsEvent extends Equatable {}

class GetSocialMentionsEvent extends SocialMentionsEvent {
  final String query;

  GetSocialMentionsEvent({
    required this.query,
  });

  @override
  List<Object?> get props {
    return [
      query,
    ];
  }
}

class ClearSocialMentionsEvent extends SocialMentionsEvent {
  @override
  List<Object?> get props => [];
}
