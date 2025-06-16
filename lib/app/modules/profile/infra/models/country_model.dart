import 'package:equatable/equatable.dart';

class CountryModel extends Equatable {
  final String? id;
  final String? name;
  final String? abbreviation;

  const CountryModel({
    this.id,
    this.name,
    this.abbreviation,
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      abbreviation,
    ];
  }
}
