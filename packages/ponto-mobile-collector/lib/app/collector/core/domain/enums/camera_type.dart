enum CameraType {
  photoCapture,
  facialRecognition;

  bool isPhotoCapture() => this == CameraType.photoCapture;
  bool isFacialRecognition() => this == CameraType.facialRecognition;
}
