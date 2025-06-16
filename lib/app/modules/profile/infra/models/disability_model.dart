import 'package:equatable/equatable.dart';

class DisabilityModel extends Equatable {
  final String? id;
  final String? name;
  final int? code;
  final String? type;

  const DisabilityModel({
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
