import 'package:equatable/equatable.dart';

class PlatformUser extends Equatable {
  final String? id;
  final String? mail;
  final String? platformUserName;

  const PlatformUser({
    this.id,
    this.mail,
    this.platformUserName,
  });

  @override
  List<Object?> get props => [
        id,
        mail,
        platformUserName,
      ];
}
