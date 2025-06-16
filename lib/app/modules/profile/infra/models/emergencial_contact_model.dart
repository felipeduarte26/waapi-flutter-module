import 'package:equatable/equatable.dart';

import '../../enums/gender_type_enum.dart';
import '../../enums/personal_relationship_enum.dart';
import 'phone_contact_model.dart';

class EmergencialContactModel extends Equatable {
  final String? id;
  final String? name;
  final GenderTypeEnum? genderType;
  final PersonalRelationshipEnum? relationship;
  final PhoneContactModel? phoneContact;

  const EmergencialContactModel({
    this.id,
    this.name,
    this.genderType,
    this.relationship,
    this.phoneContact,
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      genderType,
      relationship,
      phoneContact,
    ];
  }
}
