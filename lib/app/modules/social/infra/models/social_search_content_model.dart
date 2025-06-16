import 'package:equatable/equatable.dart';

import 'social_post_model.dart';
import 'social_profile_model.dart';


class SocialSearchContentModel extends Equatable {
  final List<SocialPostModel> posts;
  final List<String> tags;
  final List<SocialProfileModel> profiles;

  const SocialSearchContentModel({
    required this.posts,
    required this.tags,
    required this.profiles,
  });


  @override
  List<Object?> get props {
    return [
      posts,
      tags,
      profiles,
    ];
  }
}
