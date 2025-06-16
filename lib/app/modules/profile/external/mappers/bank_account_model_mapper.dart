import '../../infra/models/bank_account_model.dart';

class BankAccountModelMapper {
  BankAccountModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return BankAccountModel(
      id: map['id'],
      account: map['account'],
      agency: map['agency'],
      bank: map['bank'],
    );
  }
}
