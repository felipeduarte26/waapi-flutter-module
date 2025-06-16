import 'package:equatable/equatable.dart';

class EthnicityModel extends Equatable {
  final String? id;
  final String? name;
  final int? code;

  const EthnicityModel({
    this.id,
    this.name,
    this.code,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        code,
      ];
}
