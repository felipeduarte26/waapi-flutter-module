import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart';

import '../../../../../../ponto_mobile_collector.dart';
import '../../../../core/domain/entities/user_permission_check_entity.dart';
import '../../../../core/domain/entities/user_permission_entity.dart';
import '../../../../core/domain/entities/user_permissions_entity.dart';
import '../../../../core/infra/utils/enum/user_action_enum.dart';
import '../../../../core/infra/utils/enum/user_resource_enum.dart';
import '../../../facial_recognition/domain/entities/employee_item_entity.dart';

abstract class VerifyUserLoggedIsManagerUsecase {
  Future<bool> call({required String username});
}

class VerifyUserLoggedIsManagerUsecaseImpl
    implements VerifyUserLoggedIsManagerUsecase {
  final SharedPreferencesService _sharedPreferencesService;

  late List<EmployeeItemEntity> employeesItemList;
  late List<EmployeeDto?> employeesWithAppointmentsList;
  late List<String>? employeeIdsFromClockingEventList;

  late List<EmployeeDto?> employeesListByManager;
  late List<EmployeeDto?> employeesListByManagerWithAppointments;

  var action = UserActionEnum.allow.action;

  VerifyUserLoggedIsManagerUsecaseImpl({
    required SharedPreferencesService sharedPreferencesService,
  }) : _sharedPreferencesService = sharedPreferencesService;

  @override
  Future<bool> call({required String username}) async {
    List<UserPermissionEntity> userPermissions = [];
    List<UserPermissionCheckEntity> userPermissionCheckEntity = [];
    bool authorized = true;

    var hasManagerPermission = UserPermissionCheckEntity(
      action: action,
      resource: UserResourceEnum.manager.resource,
    );
    userPermissionCheckEntity.add(hasManagerPermission);

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
