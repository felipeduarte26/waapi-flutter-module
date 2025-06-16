import '../../domain/entities/emergencial_contact_entity.dart';
import '../models/emergencial_contact_model.dart';
import 'phone_contact_entity_adapter.dart';

class EmergencialContactEntityAdapter {
  EmergencialContactEntity fromModel({
    required EmergencialContactModel emergencialContactModel,
  }) {
    return EmergencialContactEntity(
      genderType: emergencialContactModel.genderType,
      id: emergencialContactModel.id,
      name: emergencialContactModel.name,
      relationship: emergencialContactModel.relationship,
      phoneContact: emergencialContactModel.phoneContact != null
          ? PhoneContactEntityAdapter().fromModel(
              phoneContactModel: emergencialContactModel.phoneContact!,
            )
          : null,
    );
  }
}
