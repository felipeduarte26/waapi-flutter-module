import 'package:equatable/equatable.dart';

import '../../enums/social_profile_type_enum.dart';
import 'social_space_entity.dart';

class SocialProfileEntity extends Equatable {
  final String id;
  final String name;
  final String permaname;
  final String? avatarUrl;
  final bool? hasAvatar;
  final List<String>? tags;
  final List<SocialSpaceEntity>? spaces;
  final SocialProfileTypeEnum? profileType;

  const SocialProfileEntity({
    required this.id,
    required this.name,
    required this.permaname,
    this.avatarUrl,
    this.hasAvatar,
    this.tags,
    this.spaces,
    this.profileType,
  });

  String get userName => name.replaceAll(' ', '.');

  @override
  List<Object?> get props {
    return [
      id,
      name,
      permaname,
      avatarUrl,
      hasAvatar,
      tags,
      spaces,
      profileType,
    ];
  }
}
