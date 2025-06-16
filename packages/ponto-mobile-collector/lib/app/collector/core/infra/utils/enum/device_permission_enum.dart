enum DevicePermissionEnum {
  camera(value: 'CAMERA'),
  location(value: 'LOCATION'),
  photos(value: 'PHOTOS'),
  manageExternalStorage(value: 'MANAGE_EXTERNAL_STORAGE'),
  notification(value: 'POST_NOTIFICATIONS');

  final String value;

  const DevicePermissionEnum({required this.value});

  static DevicePermissionEnum build(String value) {
    if (value == DevicePermissionEnum.camera.value) {
      return DevicePermissionEnum.camera;
    }

    if (value == DevicePermissionEnum.location.value) {
      return DevicePermissionEnum.location;
    }

    if (value == DevicePermissionEnum.photos.value) {
      return DevicePermissionEnum.photos;
    }

    if (value == DevicePermissionEnum.manageExternalStorage.value) {
      return DevicePermissionEnum.manageExternalStorage;
    }
    if (value == DevicePermissionEnum.notification.value) {
      return DevicePermissionEnum.notification;
    }

    throw Exception('DevicePermissionEnum not found.');
  }
}
