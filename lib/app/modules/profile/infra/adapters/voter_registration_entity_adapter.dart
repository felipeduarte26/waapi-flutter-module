import '../../domain/entities/voter_registration_entity.dart';
import '../models/voter_registration_model.dart';

class VoterRegistrationEntityAdapter {
  VoterRegistrationEntity fromModel({
    required VoterRegistrationModel voterRegistrationModel,
  }) {
    return VoterRegistrationEntity(
      number: voterRegistrationModel.number,
      id: voterRegistrationModel.id,
      zone: voterRegistrationModel.zone,
      section: voterRegistrationModel.section,
    );
  }
}
