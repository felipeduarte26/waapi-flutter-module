import 'package:equatable/equatable.dart';

import '../../../feedback/domain/entities/feedback_entity.dart';
import '../../enums/gender_type_enum.dart';
import 'email_entity.dart';
import 'emergencial_contact_entity.dart';

class PublicProfileEntity extends Equatable {
  final String photoUrl;
  final String name;
  final String? jobPosition;
  final String? department;
  final bool showBirthday;
  final DateTime? birthDate;
  final GenderTypeEnum? gender;
  final List<EmailEntity>? emails;
  final String personId;
  final List<FeedbackEntity>? feedbacks;
  final List<EmergencialContactEntity>? emergencialContact;
  final String? profileSummary;

  const PublicProfileEntity({
    required this.photoUrl,
    required this.name,
    this.jobPosition,
    this.department,
    required this.showBirthday,
    this.birthDate,
    required this.gender,
    this.emails,
    required this.personId,
    this.feedbacks,
    this.emergencialContact,
    this.profileSummary,
  });

  @override
  List<Object?> get props {
    return [
      photoUrl,
      name,
      jobPosition,
      department,
      showBirthday,
      birthDate,
      gender,
      emails,
      personId,
      feedbacks,
      emergencialContact,
      profileSummary,
    ];
  }
}
