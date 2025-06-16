import 'package:equatable/equatable.dart';

class RicEntity extends Equatable {
  final String? id;
  final String? number;
  final String? issuer;
  final DateTime? issuedDate;
  final String? issuingCityId;
  final String? issuingCityName;

  const RicEntity({
    this.id,
    this.number,
    this.issuer,
    this.issuedDate,
    this.issuingCityId,
    this.issuingCityName,
  });

  @override
  List<Object?> get props {
    return [
      id,
      number,
      issuer,
      issuedDate,
      issuingCityId,
      issuingCityName,
    ];
  }
}
