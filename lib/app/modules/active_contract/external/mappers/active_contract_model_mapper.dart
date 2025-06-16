import '../../infra/models/active_contract_model.dart';

class ActiveContractModelMapper {
  ActiveContractModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return ActiveContractModel(
      employeeId: map['employeeId'] ?? '',
    );
  }
}
