enum FaceRecognitionStatusEnum {
  unknown(0),
  success(90),
  iaError(91),
  notRecognized(93),
  noPersonsRegistered(95),
  notAuthenticated(96),
  fraudEvidence(97);

  final int code;

  const FaceRecognitionStatusEnum(this.code);

  bool get isSuccess => this == FaceRecognitionStatusEnum.success;

  static FaceRecognitionStatusEnum build({required int statusCode}) {
    return FaceRecognitionStatusEnum.values.firstWhere(
      (e) => e.code == statusCode,
      orElse: () => FaceRecognitionStatusEnum.unknown,
    );
  }
}
