import 'package:equatable/equatable.dart';

abstract class SocialCurrentProfileEvent extends Equatable {}

class GetSocialCurrentProfileEvent extends SocialCurrentProfileEvent {
  GetSocialCurrentProfileEvent();

  @override
  List<Object> get props {
    return [];
  }
}
