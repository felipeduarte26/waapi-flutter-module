import '../../infra/models/payroll_bank_payment_model.dart';

class PayrollBankPaymentModelMapper {
  PayrollBankPaymentModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return PayrollBankPaymentModel(
      bank: map['bank'],
      agency: map['agency'],
      account: map['account'],
    );
  }
}
