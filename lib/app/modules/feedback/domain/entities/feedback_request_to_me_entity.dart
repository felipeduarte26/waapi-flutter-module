import '../../enums/feedback_request_status_enum.dart';
import 'feedback_request_entity.dart';

class FeedbackRequestToMeEntity extends FeedbackRequestEntity {
  const FeedbackRequestToMeEntity({
    required String id,
    required DateTime when,
    required String fromPersonId,
    required String toPersonId,
    FeedbackRequestStatusEnum? status,
    required String text,
    required String photoLinkFrom,
    required String nameFrom,
    required String photoLinkTo,
    required String nameTo,
    required String fromUsername,
    required String toUsername,
  }) : super(
          id: id,
          when: when,
          fromPersonId: fromPersonId,
          toPersonId: toPersonId,
          status: status,
          text: text,
          photoLinkFrom: photoLinkFrom,
          nameFrom: nameFrom,
          photoLinkTo: photoLinkTo,
          nameTo: nameTo,
          fromUsername: fromUsername,
          toUsername: toUsername,
        );
}
