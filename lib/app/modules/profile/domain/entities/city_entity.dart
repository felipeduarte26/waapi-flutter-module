import 'package:equatable/equatable.dart';

import 'state_entity.dart';

class CityEntity extends Equatable {
  final String? id;
  final String? name;
  final StateEntity? state;

  const CityEntity({
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
