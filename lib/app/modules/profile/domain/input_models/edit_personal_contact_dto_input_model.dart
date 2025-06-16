import 'package:equatable/equatable.dart';

import 'edit_personal_contact_email_input_model.dart';
import 'edit_personal_contact_phone_input_model.dart';
import 'edit_personal_contact_social_network_input_model.dart';

class EditPersonalContactDtoInputModel extends Equatable {
  final String employeeId;
  final bool isRealData;
  final String commentary;
  final List<EditPersonalContactSocialNetworkInputModel> socialNetworks;
  final List<EditPersonalContactPhoneInputModel> personPhone;
  final List<EditPersonalContactPhoneInputModel> employeePhone;
  final List<EditPersonalContactEmailInputModel> personEmail;
  final List<EditPersonalContactEmailInputModel> employeeEmail;

  const EditPersonalContactDtoInputModel({
    required this.employeeId,
    required this.isRealData,
    required this.commentary,
    required this.socialNetworks,
    required this.personPhone,
    required this.employeePhone,
    required this.personEmail,
    required this.employeeEmail,
  });

  @override
  List<Object> get props {
    return [
      employeeId,
      isRealData,
      commentary,
      socialNetworks,
      personPhone,
      employeePhone,
      personEmail,
      employeeEmail,
    ];
  }
}
