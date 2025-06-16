import 'package:equatable/equatable.dart';

import '../../enum/payment_type_enum.dart';
import 'payroll_bank_payment_model.dart';

class PayrollDetailsModel extends Equatable {
  final PaymentTypeEnum? paymentType;
  final List<PayrollBankPaymentModel>? bankPayment;

  const PayrollDetailsModel({
    this.paymentType,
    this.bankPayment,
  });

  @override
  List<Object?> get props => [
        paymentType,
        bankPayment,
      ];
}
