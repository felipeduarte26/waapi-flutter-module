import 'package:equatable/equatable.dart';

import '../../../feedback/infra/models/feedback_model.dart';
import '../../enums/gender_type_enum.dart';
import 'email_model.dart';
import 'emergencial_contact_model.dart';

class PublicProfileModel extends Equatable {
  final String photoUrl;
  final String name;
  final String? jobPosition;
  final String? department;
  final bool showBirthday;
  final DateTime? birthDate;
  final GenderTypeEnum? gender;
  final List<EmailModel>? emails;
  final String personId;
  final List<FeedbackModel>? feedbacks;
  final List<EmergencialContactModel>? emergencialContact;
  final String? profileSummary;

  const PublicProfileModel({
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
