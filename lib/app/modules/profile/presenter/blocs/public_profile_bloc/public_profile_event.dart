import 'package:equatable/equatable.dart';

abstract class PublicProfileEvent extends Equatable {}

class GetPublicProfileEvent extends PublicProfileEvent {
  final String userName;

  GetPublicProfileEvent({
    required this.userName,
  });

  @override
  List<Object?> get props {
    return [
      userName,
    ];
  }
}
