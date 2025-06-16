import 'package:equatable/equatable.dart';

import '../../enums/feedback_request_status_enum.dart';

abstract class FeedbackRequestModel extends Equatable {
  final String id;
  final DateTime when;
  final String fromPersonId;
  final String toPersonId;
  final FeedbackRequestStatusEnum? status;
  final String text;
  final String photoLinkFrom;
  final String nameFrom;
  final String photoLinkTo;
  final String nameTo;
  final String fromUsername;
  final String toUsername;

  const FeedbackRequestModel({
    required this.id,
    required this.when,
    required this.fromPersonId,
    required this.toPersonId,
    this.status,
    required this.text,
    required this.photoLinkFrom,
    required this.nameFrom,
    required this.photoLinkTo,
    required this.nameTo,
    required this.fromUsername,
    required this.toUsername,
  });

  @override
  List<Object?> get props {
    return [
      id,
      when,
      fromPersonId,
      toPersonId,
      status,
      text,
      photoLinkFrom,
      nameFrom,
      photoLinkTo,
      nameTo,
      fromUsername,
      toUsername,
    ];
  }
}
