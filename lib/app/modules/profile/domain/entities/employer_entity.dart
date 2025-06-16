import 'package:equatable/equatable.dart';

import '../../enums/company_type_enum.dart';
import 'address_entity.dart';

class EmployerEntity extends Equatable {
  final String? name;
  final String? tradingName;
  final CompanyTypeEnum? type;
  final String? cnpj;
  final String? cnae;
  final AddressEntity? address;

  const EmployerEntity({
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
