enum FaceRegistrationStatusEnum {
  unknownError(0),
  veryBlurryImage(136),
  moreThanOneFaceFoundInTheImage(137),
  facesNotFoundInTheImage(138),
  nonFrontalFace(139),
  poorQualityImage(140),
  verySmallFaceInTheImage(141),
  faceTooCloseToTheEdgeOfTheImage(142),
  evidenceOfFraud(143),
  idsWithCloseImagesWereFound(144),
  errorReadingTheImage(145),
  externalIdCannotContainSpecialCharacters(146),
  personNotFound(147),
  imageNotFound(148),
  errorWhenDeletingThePerson(149),
  imageTooLarge(150),
  glassesDetectedOrTooMuchEyeShadow(151),
  lowConfidenceFaceDetection(152),
  externalIdIsAlreadyInUse(153);

  final int code;

  const FaceRegistrationStatusEnum(this.code);

  static FaceRegistrationStatusEnum build({required int statusCode}) {
    return FaceRegistrationStatusEnum.values.firstWhere(
      (e) => e.code == statusCode,
      orElse: () => FaceRegistrationStatusEnum.unknownError,
    );
  }
}
