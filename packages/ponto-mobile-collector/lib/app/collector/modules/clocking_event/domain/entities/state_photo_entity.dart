class StatePhotoEntity {
  String? name;
  bool hasPermission;
  bool success;

  StatePhotoEntity({
    this.name,
    required this.hasPermission,
    required this.success,
  });
}
