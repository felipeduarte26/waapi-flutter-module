import 'package:equatable/equatable.dart';

import 'social_profile_entity.dart';

class SocialGroupEntity extends Equatable {
  final String id;
  final String name;
  final String permaname;
  final List<SocialProfileEntity>? profiles;
  final bool isSpaceGroup;

  const SocialGroupEntity({
    required this.id,
    required this.name,
    required this.permaname,
    this.profiles,
    this.isSpaceGroup = false,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        permaname,
        profiles,
        isSpaceGroup,
      ];
}
