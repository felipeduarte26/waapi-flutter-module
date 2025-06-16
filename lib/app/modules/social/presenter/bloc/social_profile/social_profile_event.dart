import 'package:equatable/equatable.dart';

abstract class SocialProfileEvent extends Equatable {}

class GetSocialProfileEvent extends SocialProfileEvent {
  final String permaname;

  GetSocialProfileEvent({
    required this.permaname,
  });

  @override
  List<Object?> get props {
    return [
      permaname,
    ];
  }
}
