import 'package:equatable/equatable.dart';

import '../../../../../core/pagination/pagination_requirements.dart';

abstract class SocialListMembersEvent extends Equatable {}

class GetSocialListMembersEvent extends SocialListMembersEvent {
  final PaginationRequirements paginationRequirements;

  GetSocialListMembersEvent({
    required this.paginationRequirements,
  });

  @override
  List<Object?> get props {
    return [
      paginationRequirements,
    ];
  }
}
