import 'package:equatable/equatable.dart';

class NisEntity extends Equatable {
  final String? id;
  final String? number;
  final DateTime? registrationDate;

  const NisEntity({
    this.id,
    this.number,
    this.registrationDate,
  });

  @override
  List<Object?> get props {
    return [
      id,
      number,
      registrationDate,
    ];
  }
}
