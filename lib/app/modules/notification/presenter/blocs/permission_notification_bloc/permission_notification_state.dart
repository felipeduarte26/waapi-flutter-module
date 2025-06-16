import 'package:equatable/equatable.dart';

abstract class PermissionNotificationState extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class InitialPermissionNotificationState extends PermissionNotificationState {}

class LoadingPermissionNotificationState extends PermissionNotificationState {}

class NotDeterminedPermissionNotificationState extends PermissionNotificationState {}

class AuthorizedPermissionNotificationState extends PermissionNotificationState {}

class ForceRequestPermissionNotificationState extends PermissionNotificationState {}

class ErrorOpenSettingsPermissionNotificationState extends PermissionNotificationState {}

class ErrorFirebaseGetTokenNotificationState extends PermissionNotificationState {}

class DeniedPermissionNotificationState extends PermissionNotificationState {}

class SucceedPermissionNotificationState extends PermissionNotificationState {}

class ClearedTokenPermissionNotificationState extends PermissionNotificationState {}

class SavedNativePermissionNotificationState extends PermissionNotificationState {}

class ErrorPermissionNotificationState extends PermissionNotificationState {}

class ErrorOnClearTokenNotificationState extends PermissionNotificationState {}

class ClearedAndSavedAndSignOutNotificationState extends PermissionNotificationState {}
