import 'dart:convert';

import '../../../../core/helper/enum_helper.dart';
import '../../enums/address_type_enum.dart';
import '../../infra/models/address_model.dart';
import '../../infra/models/administrative_region_model.dart';
import '../../infra/models/city_model.dart';
import 'administrative_region_model_mapper.dart';
import 'city_model_mapper.dart';

class AddressModelMapper {
  final CityModelMapper _cityModelMapper;
  final AdministrativeRegionModelMapper? _administrativeRegionModelMapper;

  AddressModelMapper({
    required CityModelMapper cityModelMapper,
    AdministrativeRegionModelMapper? administrativeRegionModelMapper,
  })  : _cityModelMapper = cityModelMapper,
        _administrativeRegionModelMapper = administrativeRegionModelMapper;

  AddressModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return AddressModel(
      id: map['id'],
      city: map['city'] != null
          ? _cityModelMapper.fromMap(
              map: map['city'],
            )
          : null,
      postalCode: map['postalCode'],
      neighborhood: map['neighborhood'],
      address: map['address'],
      number: map['number'],
      additional: map['additional'],
      type: map['type'],
      addressType: EnumHelper<AddressTypeEnum>().stringToEnum(
        stringToParse: map['addressType'],
        values: AddressTypeEnum.values,
      ),
      administrativeRegion: administrativeRegionModel(
        map: map['administrativeRegion'],
      ),
      updateDate: map['updateDate'],
    );
  }

  AdministrativeRegionModel? administrativeRegionModel({
    required Map<String, dynamic>? map,
  }) {
    return map != null
        ? _administrativeRegionModelMapper!.fromMap(
            map: map,
          )
        : null;
  }

  AddressModel fromMapAPI({
    required Map<String, dynamic> map,
  }) {
    return AddressModel(
      city: CityModel(
        name: map['localidade'],
      ),
      postalCode: map['cep'],
      neighborhood: map['bairro'],
      address: map['logradouro'],
    );
  }

  AddressModel fromJson({
    required String addressJson,
  }) {
    final address = jsonDecode(addressJson);

    return fromMapAPI(
      map: address,
    );
  }
}
