import 'package:equatable/equatable.dart';

abstract class SocialSpaceMembershipState extends Equatable {
  const SocialSpaceMembershipState();

  @override
  List<Object> get props => [];
}

class InitialSocialSpaceMembershipState extends SocialSpaceMembershipState {}

class ErrorSocialSpaceMembershipState extends SocialSpaceMembershipState {}

class LoadingSocialSpaceMembershipState extends SocialSpaceMembershipState {}

class LeaveSocialSpaceMembershipState extends SocialSpaceMembershipState {}

class EnterSocialSpaceMembershipState extends SocialSpaceMembershipState {}

class WaitingAprovalSocialSpaceMembershipState extends SocialSpaceMembershipState {}
