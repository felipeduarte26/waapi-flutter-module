import 'package:equatable/equatable.dart';

import '../../../../core/enums/brazilian_state_enum.dart';

class CtpsEntity extends Equatable {
  final String? id;
  final String? number;
  final String? serie;
  final String? serieDigit;
  final DateTime? issuedDate;
  final BrazilianStateEnum? state;

  const CtpsEntity({
    this.id,
    this.number,
    this.serie,
    this.serieDigit,
    this.issuedDate,
    this.state,
  });

  @override
  List<Object?> get props {
    return [
      id,
      number,
      serie,
      serieDigit,
      issuedDate,
      state,
    ];
  }
}
