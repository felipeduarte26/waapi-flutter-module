import 'package:equatable/equatable.dart';

import '../../enums/address_type_enum.dart';
import 'administrative_region_model.dart';
import 'city_model.dart';

class AddressModel extends Equatable {
  final String? id;
  final CityModel? city;
  final String? postalCode;
  final String? neighborhood;
  final String? address;
  final String? number;
  final String? additional;
  final String? type;
  final AddressTypeEnum? addressType;
  final AdministrativeRegionModel? administrativeRegion;
  final String? updateDate;

  const AddressModel({
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
