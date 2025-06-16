import 'package:equatable/equatable.dart';

import '../../../domain/entities/nationality_entity.dart';

abstract class SearchNationalityEvent extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class SearchNationalityProfileEvent extends SearchNationalityEvent {
  final String search;

  SearchNationalityProfileEvent({
    required this.search,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      search,
    ];
  }
}

class SelectNationalityFromEntityToProfileEvent extends SearchNationalityEvent {
  final NationalityEntity nationalityEntity;

  SelectNationalityFromEntityToProfileEvent({
    required this.nationalityEntity,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      nationalityEntity,
    ];
  }
}

class UnselectNationalityProfileEvent extends SearchNationalityEvent {}

class ClearSearchNationalityProfileEvent extends SearchNationalityEvent {}
