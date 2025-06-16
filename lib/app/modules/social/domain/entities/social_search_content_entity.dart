import 'package:equatable/equatable.dart';

import 'social_post_entity.dart';
import 'social_profile_entity.dart';

class SocialSearchContentEntity extends Equatable {
  final List<SocialPostEntity> posts;
  final List<String> tags;
  final List<SocialProfileEntity> profiles;

  const SocialSearchContentEntity({
    required this.posts,
    required this.tags,
    required this.profiles,
  });

  factory SocialSearchContentEntity.empty() {
    return const SocialSearchContentEntity(
      posts: [],
      tags: [],
      profiles: [],
    );
  }

  factory SocialSearchContentEntity.merge(List<SocialSearchContentEntity> entities) {
    List<SocialPostEntity> posts = [];
    List<String> tags = [];
    List<SocialProfileEntity> profiles = [];

    for (var entity in entities) {
      posts.addAll(entity.posts);
      tags.addAll(entity.tags);
      profiles.addAll(entity.profiles);
    }

    return SocialSearchContentEntity(
      posts: posts,
      tags: tags,
      profiles: profiles,
    );
  }

  SocialSearchContentEntity copyWith({
    List<SocialPostEntity>? posts,
    List<String>? tags,
    List<SocialProfileEntity>? profiles,
  }) {
    return SocialSearchContentEntity(
      posts: posts ?? this.posts,
      tags: tags ?? this.tags,
      profiles: profiles ?? this.profiles,
    );
  }

  @override
  List<Object?> get props {
    return [
      posts,
      tags,
      profiles,
    ];
  }
}
