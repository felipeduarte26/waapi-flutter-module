import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
import 'package:mobile_authentication/mobile_authentication_service.dart'
    as auth;

import '../../domain/entities/manager_employee.dart';
import '../../domain/input_model/employee_dto.dart';
import '../../domain/input_model/manager_employee_dto.dart';
import 'employee_mapper.dart';
import 'platform_user_mapper.dart';

class ManagerMapper {
  static List<ManagerEmployeeDto>? fromClockToCollectorDtoList(
    List<clock.ManagerEmployeeDto>? clockList,
  ) {
    if (clockList == null) {
      return null;
    }
    List<ManagerEmployeeDto> managerEmployees = [];

    for (var managerEmployee in clockList) {
      var managerEmployeeCollector = fromClockToCollectorDto(managerEmployee);
      if (managerEmployeeCollector != null) {
        managerEmployees.add(managerEmployeeCollector);
      }
    }
    return managerEmployees;
  }

  static ManagerEmployeeDto? fromClockToCollectorDto(
    clock.ManagerEmployeeDto? dto,
  ) {
    if (dto == null) {
      return null;
    }

    return ManagerEmployeeDto(
      id: dto.id,
      platformUserName: dto.platformUserName,
      platformUsers:
          PlatformUserMapper.fromClockToCollectorDtoList(dto.platformUsers),
    );
  }

  static List<clock.ManagerEmployeeDto>? fromCollectorDtoToClockList(
    List<ManagerEmployeeDto>? dtoList,
  ) {
    if (dtoList == null) {
      return null;
    }
    List<clock.ManagerEmployeeDto> managerEmployees = [];

    for (var managerEmployee in dtoList) {
      var managerEmployeeClock = fromCollectorDtoToClock(managerEmployee);
      if (managerEmployeeClock != null) {
        managerEmployees.add(managerEmployeeClock);
      }
    }
    return managerEmployees;
  }

  static clock.ManagerEmployeeDto? fromCollectorDtoToClock(
    ManagerEmployeeDto? dto,
  ) {
    if (dto == null) {
      return null;
    }

    return clock.ManagerEmployeeDto(
      id: dto.id,
      platformUserName: dto.platformUserName,
      platformUsers:
          PlatformUserMapper.fromCollectorDtoToClockList(dto.platformUsers),
    );
  }

  static List<ManagerEmployee>? fromDtoToEntityCollectorList(
    List<ManagerEmployeeDto>? dtoList,
  ) {
    if (dtoList == null) {
      return null;
    }
    List<ManagerEmployee> managers = [];

    for (var manager in dtoList) {
      var managerCollector = fromDtoToEntityCollector(manager);
      if (managerCollector != null) {
        managers.add(managerCollector);
      }
    }
    return managers;
  }

  static ManagerEmployee? fromDtoToEntityCollector(ManagerEmployeeDto? dto) {
    if (dto == null) {
      return null;
    }

    return ManagerEmployee(
      id: dto.id,
      platformUserName: dto.platformUserName,
      platformUsers:
          PlatformUserMapper.fromDtoToEntityCollectorList(dto.platformUsers),
    );
  }

  static List<ManagerEmployeeDto>? fromEntityToDtoCollectorList(
    List<ManagerEmployee>? entityList,
  ) {
    if (entityList == null) {
      return null;
    }
    List<ManagerEmployeeDto> managers = [];

    for (var manager in entityList) {
      var managerCollector = fromEntityToDtoCollector(manager);
      if (managerCollector != null) {
        managers.add(managerCollector);
      }
    }
    return managers;
  }

  static ManagerEmployeeDto? fromEntityToDtoCollector(ManagerEmployee? entity) {
    if (entity == null) {
      return null;
    }

    return ManagerEmployeeDto(
      id: entity.id,
      platformUserName: entity.platformUserName,
      platformUsers:
          PlatformUserMapper.fromEntityToDtoCollectorList(entity.platformUsers),
    );
  }

  static List<ManagerEmployeeDto>? fromAuthToCollectorDtoList(
    List<auth.ManagerEmployeeDTO>? authList,
  ) {
    if (authList == null) {
      return null;
    }
    List<ManagerEmployeeDto> managerEmployees = [];

    for (var managerEmployee in authList) {
      var managerEmployeeCollector = fromAuthToCollectorDto(managerEmployee);
      if (managerEmployeeCollector != null) {
        managerEmployees.add(managerEmployeeCollector);
      }
    }
    return managerEmployees;
  }

  static ManagerEmployeeDto? fromAuthToCollectorDto(
    auth.ManagerEmployeeDTO? dtoAuth,
  ) {
    if (dtoAuth == null) {
      return null;
    }

    return ManagerEmployeeDto(
      id: dtoAuth.id,
      mail: dtoAuth.mail,
      platformUsers:
          PlatformUserMapper.fromAuthToCollectorDtoList(dtoAuth.platformUsers),
      platformUserName: dtoAuth.platformUserName,
      employees: convertToListDtoCollector(dtoAuth.employees),
    );
  }

  static List<EmployeeDto>? convertToListDtoCollector(
    List<auth.LoginEmployeeDTO>? employees,
  ) {
    if (employees == null) {
      return null;
    }
    List<EmployeeDto> employeesList = [];

    for (var employee in employees) {
      EmployeeDto? employeeCollector =
          EmployeeMapper.fromAuthToCollectorDto(employee);
      if (employeeCollector != null) {
        employeesList.add(employeeCollector);
      }
    }
    return employeesList;
  }

  static List<ManagerEmployee>? fromClockToCollectorEntityList(
      List<clock.ManagerEmployeeDto>? clockList,) {
    if (clockList == null) {
      return null;
    }
    List<ManagerEmployee> managerEmployees = [];

    for (var managerEmployee in clockList) {
      var managerEmployeeCollector =
          fromClockToCollectorEntity(managerEmployee);
      if (managerEmployeeCollector != null) {
        managerEmployees.add(managerEmployeeCollector);
      }
    }
    return managerEmployees;
  }

  static ManagerEmployee? fromClockToCollectorEntity(
      clock.ManagerEmployeeDto? dtoClock,) {
    if (dtoClock == null) {
      return null;
    }

    return ManagerEmployee(
      id: dtoClock.id,
      platformUserName: dtoClock.platformUserName,
      platformUsers: PlatformUserMapper.fromClockToCollectorEntityList(
          dtoClock.platformUsers,),
    );
  }
}
