import '../../domain/entities/phone_contact_entity.dart';
import '../models/phone_contact_model.dart';

class PhoneContactEntityAdapter {
  PhoneContactEntity fromModel({
    required PhoneContactModel phoneContactModel,
  }) {
    return PhoneContactEntity(
      id: phoneContactModel.id,
      number: phoneContactModel.number,
      branch: phoneContactModel.branch,
      countryCode: phoneContactModel.countryCode,
      localCode: phoneContactModel.localCode,
      provider: phoneContactModel.provider,
      type: phoneContactModel.type,
    );
  }
}
