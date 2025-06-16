class UrlPhotoRequestModel {
  String uploadType;
  String employeeId;
  List<String> photoNames;

  UrlPhotoRequestModel({
    required this.uploadType,
    required this.employeeId,
    required this.photoNames,
  });
}
