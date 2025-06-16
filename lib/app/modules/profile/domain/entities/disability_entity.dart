import 'package:equatable/equatable.dart';

class DisabilityEntity extends Equatable {
  final String? id;
  final String? name;
  final int? code;
  final String? type;

  const DisabilityEntity({
    this.id,
    this.name,
    this.code,
    this.type,
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      code,
      type,
    ];
  }
}
