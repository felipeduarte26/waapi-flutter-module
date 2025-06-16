import 'package:equatable/equatable.dart';

import 'state_input_model.dart';

class CityInputModel extends Equatable {
  final String? id;
  final String? name;
  final StateInputModel? state;

  const CityInputModel({
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
