import 'package:equatable/equatable.dart';

import '../../../../../core/pagination/pagination_requirements.dart';

abstract class SearchPersonEvent extends Equatable {
  const SearchPersonEvent();

  @override
  List<Object> get props {
    return [];
  }
}

class SearchPersonByTermEvent extends SearchPersonEvent {
  final PaginationRequirements paginationRequirements;

  const SearchPersonByTermEvent({
    required this.paginationRequirements,
  });

  @override
  List<Object> get props {
    return [
      ...super.props,
      paginationRequirements,
    ];
  }
}
