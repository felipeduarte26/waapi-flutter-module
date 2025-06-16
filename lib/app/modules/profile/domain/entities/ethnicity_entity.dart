import 'package:equatable/equatable.dart';

class EthnicityEntity extends Equatable {
  final String? id;
  final String? name;
  final int? code;

  const EthnicityEntity({
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
