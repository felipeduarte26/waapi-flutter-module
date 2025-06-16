import 'package:equatable/equatable.dart';

import '../../enums/refugee_answer_enum.dart';
import '../../enums/social_name_answer_enum.dart';
import 'gender_identity_entity.dart';
import 'sexual_orientation_entity.dart';

class DiversityPersonEntity extends Equatable {
  final String? id;
  final GenderIdentityEntity? genderIdentity;
  final String? genderIdentityDescription;
  final SocialNameAnswerEnum? socialNameAnswer;
  final String? socialNameDescription;
  final SexualOrientationEntity? sexualOrientation;
  final String? sexualOrientationDescription;
  final RefugeeAnswerEnum? refugee;

  const DiversityPersonEntity({
    required this.id,
    required this.genderIdentity,
    required this.genderIdentityDescription,
    required this.socialNameAnswer,
    required this.socialNameDescription,
    required this.sexualOrientation,
    required this.sexualOrientationDescription,
    required this.refugee,
  });

  @override
  List<Object?> get props {
    return [
      id,
      genderIdentity,
      genderIdentityDescription,
      socialNameAnswer,
      socialNameDescription,
      sexualOrientation,
      sexualOrientationDescription,
      refugee,
    ];
  }
}
