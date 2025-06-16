import 'package:equatable/equatable.dart';

import '../../enum/calculation_type_enum.dart';

class PayrollCalculationModel extends Equatable {
  final String? id;
  final DateTime? paymentDate;
  final String? paymentReference;
  final CalculationTypeEnum? type;

  const PayrollCalculationModel({
    this.id,
    this.paymentDate,
    this.paymentReference,
    this.type,
  });

  @override
  List<Object?> get props => [
        id,
        paymentDate,
        paymentReference,
        type,
      ];
}
