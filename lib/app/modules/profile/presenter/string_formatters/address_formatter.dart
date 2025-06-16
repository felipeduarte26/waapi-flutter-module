import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../domain/entities/address_entity.dart';
import 'enum_address_string_formatter.dart';
import 'zip_code_formatter.dart';

class AddressFormatter {
  static String getAddressFormatted({
    required AddressEntity address,
    required AppLocalizations appLocalizations,
    required EnumAddressStringFormatter enumAddressStringFormatter,
    required ZipCodeFormatter zipCodeFormatter,
  }) {
    String addressFormatted = '';

    if (address.addressType != null) {
      var convertedAddressType = enumAddressStringFormatter.getEnumAddressString(
        addressTypeEnum: address.addressType!,
        appLocalizations: appLocalizations,
      );
      addressFormatted += convertedAddressType;
    }

    if (address.address != null && address.address!.isNotEmpty) {
      address.number != null && address.number!.isNotEmpty
          ? addressFormatted += ' ${address.address},'
          : addressFormatted += ' ${address.address}.';
      addressFormatted = addressFormatted.trimLeft();
    }

    if (address.number != null && address.number!.isNotEmpty) {
      addressFormatted += ' ${address.number}.';
    }

    if (address.neighborhood != null && address.neighborhood!.isNotEmpty) {
      addressFormatted += ' ${address.neighborhood}';
    }

    if (address.city?.name != null &&
        address.city!.name!.isNotEmpty &&
        address.city?.state?.abbreviation != null &&
        address.city!.state!.abbreviation!.isNotEmpty) {
      addressFormatted += ' ${address.city!.name} -';
    } else if (address.city?.name != null && address.city!.name!.isNotEmpty) {
      addressFormatted += ' ${address.city!.name}';
    }

    address.city?.state?.abbreviation != null && address.city!.state!.abbreviation!.isNotEmpty
        ? addressFormatted += ' ${address.city!.state!.abbreviation},'
        : addressFormatted += ',';

    if (address.city?.state?.country?.name != null && address.city!.state!.country!.name!.isNotEmpty) {
      address.postalCode != null && address.postalCode!.isNotEmpty
          ? addressFormatted += ' ${address.city!.state!.country!.name},'
          : addressFormatted += ' ${address.city!.state!.country!.name}';
    }

    if (address.postalCode != null && address.postalCode!.isNotEmpty) {
      final zipCode = zipCodeFormatter.formatZipCode(
        zipCode: address.postalCode!,
        country: address.city?.state?.country?.name,
      );
      addressFormatted += ' ${appLocalizations.addressZipCode}: $zipCode';
    }

    return addressFormatted;
  }
}
