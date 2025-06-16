enum DeviceAuthorizationStatusEnum {
  authorized,
  deviceAuthorizationIsPending,
  deviceAuthorizationWasRejected,
  deviceActivationIsPending,
  deviceActivationWasRejected;

  static DeviceAuthorizationStatusEnum build(String name) {
    if (name == DeviceAuthorizationStatusEnum.authorized.name) {
      return DeviceAuthorizationStatusEnum.authorized;
    }

    if (name ==
        DeviceAuthorizationStatusEnum.deviceAuthorizationIsPending.name) {
      return DeviceAuthorizationStatusEnum.deviceAuthorizationIsPending;
    }

    if (name ==
        DeviceAuthorizationStatusEnum.deviceAuthorizationWasRejected.name) {
      return DeviceAuthorizationStatusEnum.deviceAuthorizationWasRejected;
    }

    if (name == DeviceAuthorizationStatusEnum.deviceActivationIsPending.name) {
      return DeviceAuthorizationStatusEnum.deviceActivationIsPending;
    }

    if (name ==
        DeviceAuthorizationStatusEnum.deviceActivationWasRejected.name) {
      return DeviceAuthorizationStatusEnum.deviceActivationWasRejected;
    }

    throw Exception('DeviceAuthorizationStatusEnum not found.');
  }
}
