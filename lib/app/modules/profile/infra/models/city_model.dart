import 'package:equatable/equatable.dart';

import 'state_model.dart';

class CityModel extends Equatable {
  final String? id;
  final String? name;
  final StateModel? state;

  const CityModel({
    this.id,
    this.name,
    this.state,
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      state,
    ];
  }
}
