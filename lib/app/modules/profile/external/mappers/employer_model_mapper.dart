import '../../../../core/helper/enum_helper.dart';
import '../../enums/company_type_enum.dart';
import '../../infra/models/employer_model.dart';
import 'address_model_mapper.dart';

class EmployerModelMapper {
  final AddressModelMapper _addressModelMapper;

  const EmployerModelMapper({
    required AddressModelMapper addressModelMapper,
  }) : _addressModelMapper = addressModelMapper;

  EmployerModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return EmployerModel(
      name: map['name'],
      tradingName: map['tradingName'],
      type: EnumHelper<CompanyTypeEnum>().stringToEnum(
        stringToParse: map['type'],
        values: CompanyTypeEnum.values,
      ),
      cnpj: map['cnpj'],
      cnae: map['cnae'],
      address: map['address'] != null
          ? _addressModelMapper.fromMap(
              map: map['address'],
            )
          : null,
    );
  }
}
