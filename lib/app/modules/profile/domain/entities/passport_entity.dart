import 'package:equatable/equatable.dart';

import '../../../../core/enums/brazilian_state_enum.dart';

class PassportEntity extends Equatable {
  final String? id;
  final String? number;
  final String? issuer;
  final DateTime? issuedDate;
  final DateTime? expiryDate;
  final String? issuingCountryId;
  final String? issuingCountryName;
  final String? issuingAuthority;
  final BrazilianStateEnum? issuingState;

  const PassportEntity({
    this.id,
    this.number,
    this.issuer,
    this.issuedDate,
    this.expiryDate,
    this.issuingCountryId,
    this.issuingCountryName,
    this.issuingAuthority,
    this.issuingState,
  });

  @override
  List<Object?> get props {
    return [
      id,
      number,
      issuer,
      issuedDate,
      expiryDate,
      issuingCountryId,
      issuingCountryName,
      issuingAuthority,
      issuingState,
    ];
  }
}
