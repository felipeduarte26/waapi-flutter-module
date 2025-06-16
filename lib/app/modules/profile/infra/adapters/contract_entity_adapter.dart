import '../../domain/entities/contract_entity.dart';
import '../models/contract_model.dart';
import 'email_entity_adapter.dart';
import 'phone_contact_entity_adapter.dart';

class ContractEntityAdapter {
  ContractEntity fromModel({
    required ContractModel contractModel,
  }) {
    return ContractEntity(
      departament: contractModel.departament,
      employeeId: contractModel.employeeId,
      jobPosition: contractModel.jobPosition,
      emails: contractModel.emails?.map((email) {
        return EmailEntityAdapter().fromModel(
          emailModel: email,
        );
      }).toList(),
      phoneContact: contractModel.phoneContact?.map((phoneContact) {
        return PhoneContactEntityAdapter().fromModel(
          phoneContactModel: phoneContact,
        );
      }).toList(),
    );
  }
}
