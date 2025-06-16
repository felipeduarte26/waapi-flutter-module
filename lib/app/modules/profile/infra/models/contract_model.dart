import 'package:equatable/equatable.dart';

import 'email_model.dart';
import 'phone_contact_model.dart';

class ContractModel extends Equatable {
  final String? employeeId;
  final String? jobPosition;
  final String? departament;
  final List<PhoneContactModel>? phoneContact;
  final List<EmailModel>? emails;

  const ContractModel({
    this.employeeId,
    this.jobPosition,
    this.departament,
    this.phoneContact,
    this.emails,
  });

  @override
  List<Object?> get props {
    return [
      employeeId,
      jobPosition,
      departament,
      phoneContact,
      emails,
    ];
  }
}
