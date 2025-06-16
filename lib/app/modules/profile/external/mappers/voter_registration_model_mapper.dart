import '../../infra/models/voter_registration_model.dart';

class VoterRegistrationModelMapper {
  VoterRegistrationModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return VoterRegistrationModel(
      id: map['id'],
      number: map['number'],
      section: map['section'] is int ? map['section'] : null,
      zone: map['zone'] is int ? map['zone'] : null,
    );
  }
}
