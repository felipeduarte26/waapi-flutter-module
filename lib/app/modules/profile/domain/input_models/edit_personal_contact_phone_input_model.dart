import 'package:equatable/equatable.dart';

import '../../infra/models/phone_contact_model.dart';

class EditPersonalContactPhoneInputModel extends Equatable {
  final String? id;
  final PhoneContactModel phoneContact;
  final String? type;
  final String? originalType;
  final String? employeeId;

  const EditPersonalContactPhoneInputModel({
    this.id,
    required this.phoneContact,
    this.type,
    this.originalType,
    this.employeeId,
  });

  @override
  List<Object?> get props {
    return [
      id,
      phoneContact,
      type,
      originalType,
      employeeId,
    ];
  }
}
