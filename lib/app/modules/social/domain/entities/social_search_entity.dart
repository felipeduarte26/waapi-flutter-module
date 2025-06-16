import 'package:equatable/equatable.dart';

import 'social_post_entity.dart';
import 'social_profile_entity.dart';
import 'social_space_entity.dart';

class SocialSearchEntity extends Equatable {
  final List<SocialPostEntity> posts;
  final List<String> tags;
  final List<SocialProfileEntity> profiles;
  final List<SocialSpaceEntity> spaces;

  const SocialSearchEntity({
    required this.posts,
    required this.tags,
    required this.profiles,
    required this.spaces,
  });

   bool get isEmpty => posts.isEmpty && tags.isEmpty && profiles.isEmpty && spaces.isEmpty;

  SocialSearchEntity copyWith({
    List<SocialPostEntity>? posts,
    List<String>? tags,
    List<SocialProfileEntity>? profiles,
    List<SocialSpaceEntity>? spaces,
  }) {
    return SocialSearchEntity(
      posts: posts ?? this.posts,
      tags: tags ?? this.tags,
      profiles: profiles ?? this.profiles,
      spaces: spaces ?? this.spaces,
    );
  }

  @override
  List<Object?> get props {
    return [
      posts,
      tags,
      profiles,
      spaces,
    ];
  }
}
