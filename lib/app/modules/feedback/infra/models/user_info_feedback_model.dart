import 'package:equatable/equatable.dart';

class UserInfoFeedbackModel extends Equatable {
  final String link;
  final String linkPhoto;
  final String id;
  final String name;
  final String nickname;
  final String username;

  const UserInfoFeedbackModel({
    required this.link,
    required this.linkPhoto,
    required this.id,
    required this.name,
    required this.nickname,
    required this.username,
  });

  @override
  List<Object?> get props {
    return [
      link,
      linkPhoto,
      id,
      name,
      nickname,
      username,
    ];
  }
}
