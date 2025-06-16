import 'package:equatable/equatable.dart';

import 'country_model.dart';

class StateModel extends Equatable {
  final String? id;
  final String? name;
  final String? abbreviation;
  final CountryModel? country;

  const StateModel({
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
