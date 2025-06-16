// ignore_for_file: unnecessary_null_comparison, unused_field, unused_local_variable

import '../../../../../../ponto_mobile_collector.dart';

import '../../../../core/domain/usecases/check_user_permission_usecase.dart';
import '../../../../core/domain/usecases/get_employee_manager_usecase.dart';

import '../../../../core/external/mappers/employee_mapper.dart';
import '../../../../core/infra/utils/enum/user_action_enum.dart';

import '../../../facial_recognition/domain/entities/employee_item_entity.dart';
import '../../../facial_recognition/domain/entities/pagination_employee_item_entity.dart';
import 'get_employees_by_manager_usecase.dart';
import 'verify_user_logged_is_admin_usecase.dart';
import 'verify_user_logged_is_manager_usecase.dart';

/// Default pageSize and pageNumber to search
const pageSize = 15;
const pageNumber = 0;

abstract class GetEmployeesToCompletedAppointmentsUsecase {
  Future<PaginationEmployeeItemEntity> call({
    String? nameEmployee,
    int pageNumber = pageNumber,
    int pageSize = pageSize,
    required String username,
  });
}

class GetEmployeesToCompletedAppointmentsUsecaseImpl
    implements GetEmployeesToCompletedAppointmentsUsecase {
  final GetEmployeesByManagerUsecase
      _getEmployeesToCompletedAppointmentsByManagerUseCase;
  final VerifyUserLoggedIsManagerUsecase _verifyUserLoggedIsManagerUsecase;
  final VerifyUserLoggedIsAdminUsecase _verifyUserLoggedIsAdminUsecase;
  final IEmployeeRepository _employeeRepository;
  final IClockingEventRepository _clockingEventRepository;
  final GetEmployeeManagerUsecase _getEmployeeManagerUsecase;
  final CheckUserPermissionUsecase _checkUserPermissionUsecase;

  var action = UserActionEnum.allow.action;

  GetEmployeesToCompletedAppointmentsUsecaseImpl({
    required GetEmployeesByManagerUsecase
        getEmployeesToCompletedAppointmentsByManagerUseCase,
    required VerifyUserLoggedIsManagerUsecase verifyUserLoggedIsManagerUsecase,
    required VerifyUserLoggedIsAdminUsecase verifyUserLoggedIsAdminUsecase,
    required IEmployeeRepository employeeRepository,
    required IClockingEventRepository clockingEventRepository,
    required GetEmployeeManagerUsecase getEmployeeManagerUsecase,
    required CheckUserPermissionUsecase checkUserPermissionUsecase,
  })  : _getEmployeesToCompletedAppointmentsByManagerUseCase =
            getEmployeesToCompletedAppointmentsByManagerUseCase,
        _verifyUserLoggedIsManagerUsecase = verifyUserLoggedIsManagerUsecase,
        _verifyUserLoggedIsAdminUsecase = verifyUserLoggedIsAdminUsecase,
        _employeeRepository = employeeRepository,
        _clockingEventRepository = clockingEventRepository,
        _getEmployeeManagerUsecase = getEmployeeManagerUsecase,
        _checkUserPermissionUsecase = checkUserPermissionUsecase;

  @override
  Future<PaginationEmployeeItemEntity> call({
    String? nameEmployee,
    int pageNumber = pageNumber,
    int pageSize = pageSize,
    required String username,
  }) async {
    List<String> employeeIdsFromClockingEventList = [];
    List<Employee>? employeesListByManager = [];

    bool isManager =
        await _verifyUserLoggedIsManagerUsecase.call(username: username);
    bool isAdmin =
        await _verifyUserLoggedIsAdminUsecase.call(username: username);

    List<ClockingEvent> clockingEvents =
        await _clockingEventRepository.getAll();

    employeeIdsFromClockingEventList = clockingEvents
        .where(
          (event) =>
              nameEmployee == null || event.employeeName.contains(nameEmployee),
        )
        .map((event) => event.employeeId)
        .toList();

    if (isManager) {
      employeesListByManager =
          await _getEmployeesToCompletedAppointmentsByManagerUseCase.call(
        username: username,
        employeeIdsFromClockingEventList: employeeIdsFromClockingEventList,
      );
      if (employeesListByManager != null && employeesListByManager.isNotEmpty) {
        return PaginationEmployeeItemEntity(
          pageNumber: 0,
          pageSize: 0,
          totalPage: (employeesListByManager.length / pageSize).ceil(),
          employees:
              EmployeeMapper.fromEntityToEmployeeItem(employeesListByManager)!,
        );
      }
    }
    if (isAdmin) {
      if (clockingEvents == null) {
        return PaginationEmployeeItemEntity(
          pageNumber: pageNumber,
          pageSize: pageSize,
          totalPage: 0,
          employees: const [],
        );
      }

      List<Employee>? employeesWithAppointmentsList = await _employeeRepository
          .findByIds(ids: employeeIdsFromClockingEventList);

      List<EmployeeItemEntity>? employeesItemList =
          EmployeeMapper.fromEntityToEmployeeItem(
        employeesWithAppointmentsList,
      );

      if (employeesItemList != null) {
        return PaginationEmployeeItemEntity(
          pageNumber: 0,
          pageSize: 0,
          totalPage: (employeesItemList.length / pageSize).ceil(),
          employees: employeesItemList,
        );
      }
    }

    return PaginationEmployeeItemEntity(
      pageNumber: pageNumber,
      pageSize: pageSize,
      totalPage: 0,
      employees: const [],
    );
  }
}
