import 'package:equatable/equatable.dart';

import '../../enums/address_type_enum.dart';
import 'administrative_region_entity.dart';
import 'city_entity.dart';

class AddressEntity extends Equatable {
  final String? id;
  final CityEntity? city;
  final String? postalCode;
  final String? neighborhood;
  final String? address;
  final String? number;
  final String? additional;
  final String? type;
  final AddressTypeEnum? addressType;
  final AdministrativeRegionEntity? administrativeRegion;
  final String? updateDate;

  const AddressEntity({
    this.id,
    this.city,
    this.postalCode,
    this.neighborhood,
    this.address,
    this.number,
    this.additional,
    this.type,
    this.addressType,
    this.administrativeRegion,
    this.updateDate,
  });

  @override
  List<Object?> get props {
    return [
      id,
      city,
      postalCode,
      neighborhood,
      address,
      number,
      additional,
      type,
      addressType,
      administrativeRegion,
      updateDate,
    ];
  }
}
