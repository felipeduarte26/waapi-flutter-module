import 'package:equatable/equatable.dart';

import '../../enums/gender_type_enum.dart';
import '../../enums/personal_relationship_enum.dart';
import 'phone_contact_entity.dart';

class EmergencialContactEntity extends Equatable {
  final String? id;
  final String? name;
  final GenderTypeEnum? genderType;
  final PersonalRelationshipEnum? relationship;
  final PhoneContactEntity? phoneContact;

  const EmergencialContactEntity({
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
