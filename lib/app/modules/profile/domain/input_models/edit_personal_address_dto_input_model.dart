// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import '../../enums/address_type_enum.dart';
import '../../infra/models/administrative_region_model.dart';

class EditPersonalAddressDtoInputModel extends Equatable {
  final String postalCode;
  final String neighborhood;
  final String address;
  final String type;
  final AddressTypeEnum addressType;
  final AdministrativeRegionModel? administrativeRegion;
  final String updateDate;
  final int? number;
  final String additional;
  final String personAddressId;
  final String cityId;
  final String? administrativeRegionId;
  final String requestType;

  const EditPersonalAddressDtoInputModel({
    required this.postalCode,
    required this.neighborhood,
    required this.address,
    required this.type,
    required this.addressType,
    this.administrativeRegion,
    required this.updateDate,
    required this.number,
    required this.additional,
    required this.personAddressId,
    required this.cityId,
    this.administrativeRegionId,
    required this.requestType,
  });

  @override
  List<Object?> get props {
    return [
      postalCode,
      addressType,
      administrativeRegion,
      neighborhood,
      address,
      type,
      number,
      additional,
      updateDate,
      personAddressId,
      cityId,
      administrativeRegionId,
      requestType,
    ];
  }
}
