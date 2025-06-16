import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart';

import '../../../../core/domain/entities/user_permission_check_entity.dart';
import '../../../../core/domain/entities/user_permission_entity.dart';
import '../../../../core/domain/entities/user_permissions_entity.dart';
import '../../../../core/infra/services/shared_preferences/shared_preferences_service.dart';
import '../../../../core/infra/utils/enum/user_action_enum.dart';
import '../../../../core/infra/utils/enum/user_resource_enum.dart';
import '../../../facial_recognition/domain/entities/employee_item_entity.dart';

abstract class VerifyUserLoggedIsAdminUsecase {
  Future<bool> call({required String username});
}

class VerifyUserLoggedIsAdminUsecaseImpl
    implements VerifyUserLoggedIsAdminUsecase {
final SharedPreferencesService _sharedPreferencesService;

  late List<EmployeeItemEntity> employeesItemList;
  late List<EmployeeDto?> employeesWithAppointmentsList;
  late List<String>? employeeIdsFromClockingEventList;

  late List<EmployeeDto?> employeesListByManager;
  late List<EmployeeDto?> employeesListByManagerWithAppointments;

  var action = UserActionEnum.allow.action;

  VerifyUserLoggedIsAdminUsecaseImpl({
    required SharedPreferencesService sharedPreferencesService,
  })  : _sharedPreferencesService = sharedPreferencesService;

 @override
  Future<bool> call({required String username}) async {
    List<UserPermissionEntity> userPermissions = [];
    List<UserPermissionCheckEntity> userPermissionCheckEntity = [];
    bool authorized = true;

    var hasAdminPermission = UserPermissionCheckEntity(
      action: action,
      resource: UserResourceEnum.admin.resource,
    );
    userPermissionCheckEntity.add(hasAdminPermission);

    for (var element in userPermissionCheckEntity) {
      bool userPermissionValue =
          await _sharedPreferencesService.getUserPermission(
        userName: username,
        action: element.action,
        resource: element.resource,
      );

      authorized = userPermissionValue ? authorized : false;

      UserPermissionEntity authorizedPermission = UserPermissionEntity(
        action: element.action,
        authorized: userPermissionValue,
        owner: false,
        resource: element.resource,
      );

      userPermissions.add(authorizedPermission);
    }

    authorized = userPermissions.isEmpty ? false : authorized;

    UserPermissionsEntity userPermissionsEntity = UserPermissionsEntity(
      authorized: authorized,
      permissions: userPermissions,
    );

    return userPermissionsEntity.authorized;
  }
}
