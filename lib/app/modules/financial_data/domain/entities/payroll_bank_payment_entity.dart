import 'package:equatable/equatable.dart';

class PayrollBankPaymentEntity extends Equatable {
  final String? bank;
  final String? agency;
  final String? account;

  const PayrollBankPaymentEntity({
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
