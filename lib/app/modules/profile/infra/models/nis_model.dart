import 'package:equatable/equatable.dart';

class NisModel extends Equatable {
  final String? id;
  final String? number;
  final DateTime? registrationDate;

  const NisModel({
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
