import 'package:equatable/equatable.dart';

import 'country_entity.dart';

class StateEntity extends Equatable {
  final String? id;
  final String? name;
  final String? abbreviation;
  final CountryEntity? country;

  const StateEntity({
    this.id,
    this.name,
    this.abbreviation,
    this.country,
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      abbreviation,
      country,
    ];
  }
}
