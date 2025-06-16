import 'package:equatable/equatable.dart';

abstract class SocialSearchEvent extends Equatable {
  const SocialSearchEvent();
}

class GetSocialSearchResultEvent extends SocialSearchEvent {
  final String query;
  final int from;

  const GetSocialSearchResultEvent({
    required this.query,
    required this.from,
  });

  @override
  List<Object> get props {
    return [
      query,
      from,
    ];
  }
}

class GetSocialSearchMoreResultEvent extends SocialSearchEvent {
  final String query;
  final int from;

  const GetSocialSearchMoreResultEvent({
    required this.query,
    required this.from,
  });

  @override
  List<Object> get props {
    return [
      query,
      from,
    ];
  }
}
