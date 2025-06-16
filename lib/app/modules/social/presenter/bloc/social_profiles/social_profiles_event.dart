import 'package:equatable/equatable.dart';

abstract class SocialProfilesEvent extends Equatable {}

class GetSocialMyProfilesEvent extends SocialProfilesEvent {
  GetSocialMyProfilesEvent();

  @override
  List<Object> get props {
    return [];
  }
}

class ResetSocialMyProfilesEvent extends SocialProfilesEvent {
  ResetSocialMyProfilesEvent();

  @override
  List<Object> get props {
    return [];
  }
}
