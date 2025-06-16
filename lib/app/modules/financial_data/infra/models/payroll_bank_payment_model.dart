import 'package:equatable/equatable.dart';

class PayrollBankPaymentModel extends Equatable {
  final String? bank;
  final String? agency;
  final String? account;

  const PayrollBankPaymentModel({
    this.bank,
    this.agency,
    this.account,
  });

  @override
  List<Object?> get props => [
        bank,
        agency,
        account,
      ];
}
