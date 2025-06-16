import 'package:equatable/equatable.dart';

class SocialOwnerSpaceEntity extends Equatable {
  final String id;
  final String avatarUrl;
  final bool hasAvatar;
  final String name;
  final String permaname;

  const SocialOwnerSpaceEntity({
    required this.id,
    required this.avatarUrl,
    required this.hasAvatar,
    required this.name,
    required this.permaname,
  });

  @override
  List<Object> get props => [
        id,
        avatarUrl,
        hasAvatar,
        name,
        permaname,
      ];
}
