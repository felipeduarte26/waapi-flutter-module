import '../../domain/entities/bank_account_entity.dart';
import '../models/bank_account_model.dart';

class BankAccountEntityAdapter {
  BankAccountEntity fromModel({
    required BankAccountModel bankAccountModel,
  }) {
    return BankAccountEntity(
      id: bankAccountModel.id,
      bank: bankAccountModel.bank,
      agency: bankAccountModel.agency,
      account: bankAccountModel.account,
    );
  }
}
