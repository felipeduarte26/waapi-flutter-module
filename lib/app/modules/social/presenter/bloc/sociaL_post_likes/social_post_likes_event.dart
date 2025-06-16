import 'package:equatable/equatable.dart';
import '../../../../../core/pagination/pagination_requirements.dart';

abstract class SocialPostLikesEvent extends Equatable {
  const SocialPostLikesEvent();
}

class GetSocialPostLikesEvent extends SocialPostLikesEvent {
  final String postId;
  final PaginationRequirements paginationRequirements;

  const GetSocialPostLikesEvent({
    required this.postId,
    required this.paginationRequirements,
  });

  @override
  List<Object?> get props {
    return [
      postId,
      paginationRequirements,
    ];
  }
}
