import 'package:equatable/equatable.dart';

import '../../enum/payment_type_enum.dart';
import 'payroll_bank_payment_entity.dart';

class PayrollDetailsEntity extends Equatable {
  final PaymentTypeEnum? paymentType;
  final List<PayrollBankPaymentEntity>? bankPayment;

  const PayrollDetailsEntity({
    this.paymentType,
    this.bankPayment,
  });

  @override
  List<Object?> get props => [
        paymentType,
        bankPayment,
      ];
}
