import 'package:equatable/equatable.dart';

import '../../enums/company_type_enum.dart';
import 'address_model.dart';

class EmployerModel extends Equatable {
  final String? name;
  final String? tradingName;
  final CompanyTypeEnum? type;
  final String? cnpj;
  final String? cnae;
  final AddressModel? address;

  const EmployerModel({
    this.name,
    this.tradingName,
    this.type,
    this.cnpj,
    this.cnae,
    this.address,
  });

  @override
  List<Object?> get props {
    return [
      name,
      tradingName,
      type,
      cnpj,
      cnae,
      address,
    ];
  }
}
