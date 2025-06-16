import '../../domain/entities/payroll_details_entity.dart';
import '../models/payroll_details_model.dart';
import 'payroll_bank_payment_entity_adapter.dart';

class PayrollDetailsEntityAdapter {
  PayrollDetailsEntity fromModel({
    required PayrollDetailsModel payrollDetailsModel,
  }) {
    return PayrollDetailsEntity(
      paymentType: payrollDetailsModel.paymentType,
      bankPayment: payrollDetailsModel.bankPayment
          ?.map(
            (bankPayment) => PayrollBankPaymentEntityAdapter().fromModel(
              payrollBankPaymentModel: bankPayment,
            ),
          )
          .toList(),
    );
  }
}
