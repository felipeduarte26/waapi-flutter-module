import 'package:equatable/equatable.dart';

class BankAccountModel extends Equatable {
  final String? id;
  final String? bank;
  final String? agency;
  final String? account;

  const BankAccountModel({
    this.id,
    this.bank,
    this.agency,
    this.account,
  });

  @override
  List<Object?> get props {
    return [
      id,
      bank,
      agency,
      account,
    ];
  }
}
