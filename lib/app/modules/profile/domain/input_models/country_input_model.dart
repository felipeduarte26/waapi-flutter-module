import 'package:equatable/equatable.dart';

class CountryInputModel extends Equatable {
  final String? id;
  final String? name;
  final String? abbreviation;

  const CountryInputModel({
    this.id,
    this.name,
    this.abbreviation,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        abbreviation,
      ];
}
