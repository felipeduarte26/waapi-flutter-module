import 'package:equatable/equatable.dart';

import '../../../../core/enums/brazilian_state_enum.dart';
import '../../enums/cnh_category_enum.dart';

class CnhEntity extends Equatable {
  final String? number;
  final CnhCategoryEnum? category;
  final BrazilianStateEnum? issuerState;
  final String? issuer;
  final DateTime? firstIssuedDate;
  final DateTime? issuedDate;
  final DateTime? expiryDate;

  const CnhEntity({
    this.number,
    this.category,
    this.issuerState,
    this.firstIssuedDate,
    this.issuedDate,
    this.issuer,
    this.expiryDate,
  });

  @override
  List<Object?> get props {
    return [
      number,
      category,
      issuerState,
      firstIssuedDate,
      issuedDate,
      expiryDate,
      issuer,
    ];
  }
}
