import '../../../feedback/infra/adapters/feedback_entity_adapter.dart';
import '../../domain/entities/public_profile_entity.dart';
import '../models/public_profile_model.dart';
import 'email_entity_adapter.dart';
import 'emergencial_contact_entity_adapter.dart';

class PublicProfileEntityAdapter {
  final EmailEntityAdapter _emailEntityAdapter;
  final FeedbackEntityAdapter _feedbackEntityAdapter;
  final EmergencialContactEntityAdapter _emergencialContactEntityAdapter;

  const PublicProfileEntityAdapter({
    required EmailEntityAdapter emailEntityAdapter,
    required FeedbackEntityAdapter feedbackEntityAdapter,
    required EmergencialContactEntityAdapter emergencialContactEntityAdapter,
  })  : _emailEntityAdapter = emailEntityAdapter,
        _feedbackEntityAdapter = feedbackEntityAdapter,
        _emergencialContactEntityAdapter = emergencialContactEntityAdapter;

  PublicProfileEntity fromModel({
    required PublicProfileModel publicProfileModel,
  }) {
    return PublicProfileEntity(
      name: publicProfileModel.name,
      photoUrl: publicProfileModel.photoUrl,
      showBirthday: publicProfileModel.showBirthday,
      birthDate: publicProfileModel.birthDate,
      department: publicProfileModel.department,
      jobPosition: publicProfileModel.jobPosition,
      profileSummary: publicProfileModel.profileSummary,
      emails: publicProfileModel.emails
          ?.map(
            (emailModel) => _emailEntityAdapter.fromModel(
              emailModel: emailModel,
            ),
          )
          .toList(),
      gender: publicProfileModel.gender,
      personId: publicProfileModel.personId,
      feedbacks: publicProfileModel.feedbacks
          ?.map(
            (feedbackModel) => _feedbackEntityAdapter.fromModel(
              feedbackModel: feedbackModel,
            ),
          )
          .toList(),
      emergencialContact: publicProfileModel.emergencialContact
          ?.map(
            (emergencialContactModel) => _emergencialContactEntityAdapter.fromModel(
              emergencialContactModel: emergencialContactModel,
            ),
          )
          .toList(),
    );
  }
}
