import 'package:equatable/equatable.dart';

import 'country_input_model.dart';

class StateInputModel extends Equatable {
  final String? id;
  final String? name;
  final String? abbreviation;
  final CountryInputModel? country;

  const StateInputModel({
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
