import 'package:equatable/equatable.dart';

import 'email_entity.dart';
import 'phone_contact_entity.dart';

class ContractEntity extends Equatable {
  final String? employeeId;
  final String? jobPosition;
  final String? departament;
  final List<PhoneContactEntity>? phoneContact;
  final List<EmailEntity>? emails;

  const ContractEntity({
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
