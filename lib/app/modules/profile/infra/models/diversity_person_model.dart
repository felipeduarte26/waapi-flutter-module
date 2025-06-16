import 'package:equatable/equatable.dart';

import '../../enums/refugee_answer_enum.dart';
import '../../enums/social_name_answer_enum.dart';
import 'gender_identity_model.dart';
import 'sexual_orientation_model.dart';

class DiversityPersonModel extends Equatable {
  final String? id;
  final GenderIdentityModel? genderIdentity;
  final String? genderIdentityDescription;
  final SocialNameAnswerEnum? socialNameAnswer;
  final String? socialNameDescription;
  final SexualOrientationModel? sexualOrientation;
  final String? sexualOrientationDescription;
  final RefugeeAnswerEnum? refugee;

  const DiversityPersonModel({
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
