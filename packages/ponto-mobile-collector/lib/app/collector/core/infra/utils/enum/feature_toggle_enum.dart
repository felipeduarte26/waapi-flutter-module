enum FeatureToggleEnum {
  insightOutOfBound(featureName: 'insight_out_of_bound'),
  selfie(featureName: 'selfie  '),
  qrcode(featureName: 'qrcode'),
  faceRecognition(featureName: 'face_recognition'),
  waapiponto(featureName: 'waapiponto');

  final String featureName;

  const FeatureToggleEnum({required this.featureName});
}
