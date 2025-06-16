import 'package:equatable/equatable.dart';

abstract class SocialSpaceInfoEvent extends Equatable {}

class GetSocialSpaceInfoEvent extends SocialSpaceInfoEvent {
  final String permaname;

  GetSocialSpaceInfoEvent({
    required this.permaname,
  });

  @override
  List<Object?> get props {
    return [
      permaname,
    ];
  }
}
