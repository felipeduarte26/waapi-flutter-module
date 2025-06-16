import 'package:equatable/equatable.dart';

import '../../../../../core/pagination/pagination_requirements.dart';
import '../../../domain/entities/social_space_entity.dart';

abstract class SocialSpacesEvent extends Equatable {}

class GetSocialSpacesEvent extends SocialSpacesEvent {
  final PaginationRequirements paginationRequirements;
  GetSocialSpacesEvent({
    required this.paginationRequirements,
  });

  @override
  List<Object> get props {
    return [
      paginationRequirements,
    ];
  }
}

class GetMoreSocialSpacesEvent extends SocialSpacesEvent {
  final PaginationRequirements paginationRequirements;
  final List<SocialSpaceEntity> socialSpaces;
  GetMoreSocialSpacesEvent({
    required this.paginationRequirements,
    required this.socialSpaces,
  });

  @override
  List<Object> get props {
    return [
      paginationRequirements,
      socialSpaces,
    ];
  }
}
