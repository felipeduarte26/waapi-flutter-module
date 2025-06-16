import 'package:equatable/equatable.dart';

class RneModel extends Equatable {
  final String? number;
  final String? issuer;
  final DateTime? issuedDate;

  const RneModel({
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
