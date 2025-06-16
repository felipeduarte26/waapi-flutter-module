import 'package:equatable/equatable.dart';

class RneEntity extends Equatable {
  final String? number;
  final String? issuer;
  final DateTime? issuedDate;

  const RneEntity({
    this.number,
    this.issuedDate,
    this.issuer,
  });

  @override
  List<Object?> get props {
    return [
      number,
      issuedDate,
      issuer,
    ];
  }
}
