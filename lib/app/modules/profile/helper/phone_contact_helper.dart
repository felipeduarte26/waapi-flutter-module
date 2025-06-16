import '../domain/entities/phone_contact_entity.dart';

class PhoneContactHelper {
  static String? getFullPhone({
    required PhoneContactEntity? phoneContact,
  }) {
    var fullPhone = '';

    if (phoneContact == null) {
      return null;
    }

    if (phoneContact.countryCode != null && phoneContact.countryCode! > 0) {
      fullPhone = '+${phoneContact.countryCode} ';
    }

    if (phoneContact.localCode != null && phoneContact.localCode! > 0) {
      fullPhone += '${phoneContact.localCode} ';
    }

    if (phoneContact.number != null && phoneContact.number!.isNotEmpty) {
      fullPhone += '${phoneContact.number}';
    }

    if (fullPhone.isEmpty) {
      return null;
    }

    return fullPhone;
  }
}
