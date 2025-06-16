import 'package:equatable/equatable.dart';

import '../../enums/gender_type_enum.dart';
import '../../enums/personal_relationship_enum.dart';
import 'phone_contact_input_model.dart';

class EmergencialContactInputModel extends Equatable {
  final String? name;
  final PersonalRelationshipEnum? emergencialContactRelationshipEnum;
  final GenderTypeEnum? genderTypeEnum;
  final PhoneContactInputModel? phoneContactInputModel;

  const EmergencialContactInputModel({
    this.name,
    this.emergencialContactRelationshipEnum,
    this.genderTypeEnum,
    this.phoneContactInputModel,
  });

  @override
  List<Object?> get props {
    return [
      name,
      emergencialContactRelationshipEnum,
      genderTypeEnum,
      phoneContactInputModel,
    ];
  }
}
