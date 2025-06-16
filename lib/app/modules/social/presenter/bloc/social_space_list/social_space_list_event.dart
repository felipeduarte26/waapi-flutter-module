import 'package:equatable/equatable.dart';

import '../../../../../core/pagination/pagination_requirements.dart';
import '../../../domain/entities/social_space_entity.dart';

abstract class SocialSpaceListEvent extends Equatable {}

class GetSocialSpaceListEvent extends SocialSpaceListEvent {
  final PaginationRequirements paginationRequirements;
  final List<SocialSpaceEntity> socialSpaceEntityList;

  GetSocialSpaceListEvent({
    required this.paginationRequirements,
    required this.socialSpaceEntityList,
  });

  @override
  List<Object?> get props {
    return [
      paginationRequirements,
    ];
  }
}
