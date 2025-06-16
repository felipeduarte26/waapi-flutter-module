import '../../domain/input_models/phone_contact_input_model.dart';

class PhoneContactInputModelMapper {
  Map<String, dynamic> toMap({
    required PhoneContactInputModel phoneContactInputModel,
  }) {
    return {
      'countryCode': phoneContactInputModel.countryCode,
      'localCode': phoneContactInputModel.localCode,
      'number': phoneContactInputModel.number,
      'branch': phoneContactInputModel.branch,
      'provider': phoneContactInputModel.provider,
    };
  }
}
