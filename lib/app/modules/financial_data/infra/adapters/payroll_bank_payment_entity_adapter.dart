import '../../domain/entities/payroll_bank_payment_entity.dart';
import '../models/payroll_bank_payment_model.dart';

class PayrollBankPaymentEntityAdapter {
  PayrollBankPaymentEntity fromModel({
    required PayrollBankPaymentModel payrollBankPaymentModel,
  }) {
    return PayrollBankPaymentEntity(
      bank: payrollBankPaymentModel.bank,
      agency: payrollBankPaymentModel.agency,
      account: payrollBankPaymentModel.account,
    );
  }
}
