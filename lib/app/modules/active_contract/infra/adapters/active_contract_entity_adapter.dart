import '../../domain/entities/active_contract_entity.dart';
import '../models/active_contract_model.dart';

class ActiveContractEntityAdapter {
  ActiveContractEntity fromModel({
    required ActiveContractModel activeContractModel,
  }) {
    return ActiveContractEntity(
      employeeId: activeContractModel.employeeId,
    );
  }
}
