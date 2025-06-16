abstract class ApplicationKeyBaseState {}

class LoadingUserIsAuthenticatedState extends ApplicationKeyBaseState {}

class HasNoConnectivityState extends ApplicationKeyBaseState {}

class UserWithoutPermissionState extends ApplicationKeyBaseState {}

class KeyNotRegisteredState extends ApplicationKeyBaseState {}

class RegisterNewKeyState extends ApplicationKeyBaseState {}

class KeyAlreadyRegisteredState extends ApplicationKeyBaseState {}

class KeyRegisteredSuccessfullyState extends ApplicationKeyBaseState {}

class VerifyingUnsycedClockingEventsState extends ApplicationKeyBaseState {}

class HasUnsyncedClockingEventsState extends ApplicationKeyBaseState {}

class ConfirmRemoveKeysState extends ApplicationKeyBaseState {}

class RemovingKeysState extends ApplicationKeyBaseState {}

class RemoveKeyErrorState extends ApplicationKeyBaseState {}

class KeysRemovedState extends ApplicationKeyBaseState {}
