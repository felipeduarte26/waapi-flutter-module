import 'package:equatable/equatable.dart';

abstract class SocialHashtagsEvent extends Equatable {}

class GetSocialHashtagsEvent extends SocialHashtagsEvent {
  final String query;

  GetSocialHashtagsEvent({
    required this.query,
  });

  @override
  List<Object?> get props {
    return [
      query,
    ];
  }
}

class ClearSocialHashtagsEvent extends SocialHashtagsEvent {
  @override
  List<Object?> get props => [];
}
