import '../../../../core/domain/input_model/clocking_event_dto.dart';
import '../../../../core/domain/usecases/get_employee_manager_usecase.dart';
import 'get_employees_by_manager_usecase.dart';

abstract class GetClockingEventByManagerUsecase {
  Future<List<ClockingEventDto>> call({
    required List<ClockingEventDto> appointments,
    required String username,
  });
}

class GetClockingEventByManagerUsecaseImpl
    implements GetClockingEventByManagerUsecase {
  final GetEmployeeManagerUsecase _getEmployeeManagerUsecase;
  final GetEmployeesByManagerUsecase _getEmployeesByManagerUsecase;

  GetClockingEventByManagerUsecaseImpl({
    required GetEmployeeManagerUsecase getEmployeeManagerUsecase,
    required GetEmployeesByManagerUsecase getEmployeesByManagerUsecase,
  })  : _getEmployeeManagerUsecase = getEmployeeManagerUsecase,
        _getEmployeesByManagerUsecase = getEmployeesByManagerUsecase;

  @override
  Future<List<ClockingEventDto>> call({
    required List<ClockingEventDto> appointments,
    required String username,
  }) async {
    var managerEmployee = await _getEmployeeManagerUsecase.call(
      username: username,
    );

    var employeeIdsFromClockingEventList =
        appointments.map((element) => element.employeeDto!.id).toList();

    var employeesListByManager = await _getEmployeesByManagerUsecase.call(
      username: username,
      employeeIdsFromClockingEventList: employeeIdsFromClockingEventList,
    );

    var employeesIds = employeesListByManager!.map((e) => e.id).toList();

    if (managerEmployee != null) {
      employeesIds.add(managerEmployee.id);
    }

    return appointments.where((element) {
      return employeesIds.contains(element.employeeDto!.id);
    }).toList();
  }
}
