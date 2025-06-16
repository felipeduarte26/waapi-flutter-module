import '../../domain/entities/address_entity.dart';
import '../models/address_model.dart';
import 'administrative_region_entity_adapter.dart';
import 'city_entity_adapter.dart';

class AddressEntityAdapter {
  AddressEntity fromModel({
    required AddressModel addressModel,
  }) {
    return AddressEntity(
      id: addressModel.id,
      city: addressModel.city != null
          ? CityEntityAdapter().fromModel(
              cityModel: addressModel.city!,
            )
          : null,
      additional: addressModel.additional,
      address: addressModel.address,
      addressType: addressModel.addressType,
      neighborhood: addressModel.neighborhood,
      number: addressModel.number,
      postalCode: addressModel.postalCode,
      type: addressModel.type,
      updateDate: addressModel.updateDate,
      administrativeRegion: addressModel.administrativeRegion != null
          ? AdministrativeRegionEntityAdapter().fromModel(
              administrativeRegionModel: addressModel.administrativeRegion!,
            )
          : null,
    );
  }
}
