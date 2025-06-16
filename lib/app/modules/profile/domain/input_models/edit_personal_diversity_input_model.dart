import 'package:equatable/equatable.dart';

class EditPersonalDiversityInputModel extends Equatable {
  final String? id;
  final String personId;
  final String? diversityId;
  final String? genderIdentityId;
  final String? genderIdentityDescription;
  final String? socialNameAnswer;
  final String? socialNameDescription;
  final String? sexualOrientationId;
  final String? sexualOrientationDescription;
  final String? refugee;

  const EditPersonalDiversityInputModel({
    this.id,
    required this.personId,
    this.diversityId,
    this.genderIdentityId,
    this.genderIdentityDescription,
    this.socialNameAnswer,
    this.socialNameDescription,
    this.sexualOrientationId,
    this.sexualOrientationDescription,
    this.refugee,
  });

  @override
  List<Object?> get props => [
        id,
        personId,
        diversityId,
        genderIdentityId,
        genderIdentityDescription,
        socialNameAnswer,
        socialNameDescription,
        sexualOrientationId,
        sexualOrientationDescription,
        refugee,
      ];
}
