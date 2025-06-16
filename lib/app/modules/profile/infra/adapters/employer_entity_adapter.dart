import '../../domain/entities/employer_entity.dart';
import '../../infra/models/employer_model.dart';
import 'address_entity_adapter.dart';

class EmployerEntityAdapter {
  EmployerEntity fromModel({
    required EmployerModel employerModel,
  }) {
    return EmployerEntity(
      cnae: employerModel.cnae,
      cnpj: employerModel.cnpj,
      name: employerModel.name,
      tradingName: employerModel.tradingName,
      type: employerModel.type,
      address: employerModel.address != null
          ? AddressEntityAdapter().fromModel(
              addressModel: employerModel.address!,
            )
          : null,
    );
  }
}
