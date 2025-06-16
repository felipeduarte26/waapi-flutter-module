import 'package:equatable/equatable.dart';

import '../../../../core/enums/brazilian_state_enum.dart';

class RgModel extends Equatable {
  final String? id;
  final String? number;
  final String? issuer;
  final DateTime? issuedDate;
  final BrazilianStateEnum? issuingState;

  const RgModel({
    this.id,
    this.number,
    this.issuer,
    this.issuedDate,
    this.issuingState,
  });

  @override
  List<Object?> get props {
    return [
      id,
      number,
      issuer,
      issuedDate,
      issuingState,
    ];
  }
}
