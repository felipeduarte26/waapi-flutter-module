import '../../../../core/helper/enum_helper.dart';
import '../../domain/input_models/edit_personal_address_dto_input_model.dart';
import '../../enums/address_type_enum.dart';
import '../../infra/models/administrative_region_model.dart';

class EditPersonalAddressDTOInputModelMapper {
  Map<String, dynamic> toMap({
    required EditPersonalAddressDtoInputModel editPersonalAddressInputModel,
  }) {
    return {
      'postalCode': editPersonalAddressInputModel.postalCode,
      'neighborhood': editPersonalAddressInputModel.neighborhood,
      'address': editPersonalAddressInputModel.address,
      'type': 'PERSONAL',
      'addressType': EnumHelper<AddressTypeEnum>().enumToString(
        enumToParse: editPersonalAddressInputModel.addressType,
      ),
      if (editPersonalAddressInputModel.administrativeRegion != null)
        'administrativeRegion': _administrativeRegion(
          map: editPersonalAddressInputModel.administrativeRegion!,
        ),
      if (editPersonalAddressInputModel.administrativeRegion != null)
        'administrativeRegionId': editPersonalAddressInputModel.administrativeRegionId,
      'updateDate': editPersonalAddressInputModel.updateDate,
      'canceled': false,
      'isValid': {
        'address': true,
        'updateDate': true,
      },
      'isInvalid': 0,
      'number': editPersonalAddressInputModel.number ?? '',
      'additional': editPersonalAddressInputModel.additional,
      'personAddressId': editPersonalAddressInputModel.personAddressId,
      'cityId': editPersonalAddressInputModel.cityId,
      'requestType': 'UPDATE',
    };
  }

  Map _administrativeRegion({
    required AdministrativeRegionModel map,
  }) {
    return {
      'id': map.id,
      'cityId': map.city!.id!,
      'cityDTO': _cityDTO(
        map: map,
      ),
      'name': map.name,
    };
  }

  Map _cityDTO({
    required AdministrativeRegionModel map,
  }) {
    return {
      'id': map.city?.id ?? '',
      'state': {
        'id': map.city?.state?.id ?? '',
        'name': map.city?.state?.name ?? '',
        'abbreviation': map.city?.state?.abbreviation ?? '',
        'country': {
          'id': map.city?.state?.country?.id ?? '',
          'name': map.city?.state?.country?.name ?? '',
          'abbreviation': map.city?.state?.country?.abbreviation ?? '',
        },
      },
      'name': map.city?.name ?? '',
    };
  }
}
