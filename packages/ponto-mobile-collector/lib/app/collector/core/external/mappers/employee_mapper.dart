import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
import 'package:mobile_authentication/mobile_authentication_service.dart'
    as auth;

import '../../../modules/facial_recognition/domain/entities/employee_item_entity.dart';
import '../../domain/entities/employee.dart';
import '../../domain/input_model/employee_dto.dart';
import 'company_mapper.dart';
import 'fence_mapper.dart';
import 'manager_mapper.dart';
import 'platform_user_mapper.dart';
import 'reminder_mapper.dart';

class EmployeeMapper {
  static EmployeeDto? fromClockToCollectorDto(clock.EmployeeDto? dtoClock) {
    if (dtoClock == null) {
      return null;
    }
    return EmployeeDto(
      id: dtoClock.id,
      arpId: dtoClock.arpId,
      company: CompanyMapper.fromClockToCollectorDto(dtoClock.company)!,
      cpfNumber: dtoClock.cpf,
      employeeCode: dtoClock.employeeCode,
      employeeType: dtoClock.employeeType.toString(),
      enabled: dtoClock.enable,
      faceRegistered: dtoClock.faceRegistered,
      fences: FenceMapper.fromClockToCollectorDtoList(dtoClock.fences),
      mail: dtoClock.mail,
      managers: ManagerMapper.fromClockToCollectorDtoList(dtoClock.managers),
      name: dtoClock.name ?? '',
      nfcCode: dtoClock.nfcCode,
      //pis: dtoClock.pis, // TO DO: incluir pis no Employee?
      platformUsers: PlatformUserMapper.fromClockToCollectorDtoList(
        dtoClock.platformUsers,
      ),
      registrationNumber: dtoClock.registrationNumber,
      reminders: ReminderMapper.fromClockToCollectorDtoList(dtoClock.reminders),
      pis: dtoClock.pis,
    );
  }

  static clock.EmployeeDto? fromCollectorDtoToClock(EmployeeDto? dto) {
    if (dto == null) {
      return null;
    }
    return clock.EmployeeDto(
      id: dto.id,
      arpId: dto.arpId,
      company: CompanyMapper.fromCollectorDtoToClock(dto.company),
      cpf: dto.cpfNumber,
      employeeCode: dto.employeeCode,
      employeeType: dto.employeeType.toString(),
      enable: dto.enabled,
      faceRegistered: dto.faceRegistered,
      fences: FenceMapper.fromCollectorDtoToClockList(dto.fences),
      mail: dto.mail,
      managers: ManagerMapper.fromCollectorDtoToClockList(dto.managers),
      name: dto.name,
      nfcCode: dto.nfcCode,
      //pis: dto.pis, // TO DO: incluir pis no Employee?
      platformUsers:
          PlatformUserMapper.fromCollectorDtoToClockList(dto.platformUsers),
      registrationNumber: dto.registrationNumber,
      reminders: ReminderMapper.fromCollectorDtoToClockList(dto.reminders),
      pis: dto.pis,
    );
  }

  static Employee? fromDtoToEntityCollector(EmployeeDto? dto) {
    if (dto == null) {
      return null;
    }
    return Employee(
      id: dto.id,
      arpId: dto.arpId,
      company: CompanyMapper.fromDtoToEntityCollector(dto.company)!,
      cpf: dto.cpfNumber,
      employeeType: dto.employeeType.toString(),
      enable: dto.enabled,
      mail: dto.mail,
      name: dto.name,
      nfcCode: dto.nfcCode,
      registrationNumber: dto.registrationNumber,
      employeeCode: dto.employeeCode,
      faceRegistered: dto.faceRegistered,
      fences: FenceMapper.fromDtoToEntityCollectorList(dto.fences),
      managerEmployees:
          ManagerMapper.fromDtoToEntityCollectorList(dto.managers),
      platformUsers: PlatformUserMapper.fromDtoToEntityCollectorList(
        dto.platformUsers,
      ),
      pis: dto.pis,
      reminders: ReminderMapper.fromDtoToEntityCollectorList(dto.reminders),
    );
  }

  static EmployeeDto? fromEntityToDtoCollector(Employee? entity) {
    if (entity == null) {
      return null;
    }
    return EmployeeDto(
      id: entity.id,
      arpId: entity.arpId,
      company: CompanyMapper.fromEntityToDtoCollector(entity.company)!,
      cpfNumber: entity.cpf,
      employeeType: entity.employeeType.toString(),
      enabled: entity.enable,
      mail: entity.mail,
      name: entity.name ?? '',
      nfcCode: entity.nfcCode,
      registrationNumber: entity.registrationNumber,
      employeeCode: entity.employeeCode,
      faceRegistered: entity.faceRegistered,
      fences: FenceMapper.fromEntityToDtoCollectorList(entity.fences),
      managers:
          ManagerMapper.fromEntityToDtoCollectorList(entity.managerEmployees),
      platformUsers: PlatformUserMapper.fromEntityToDtoCollectorList(
        entity.platformUsers,
      ),
      pis: entity.pis,
    );
  }

  static EmployeeDto? fromAuthToCollectorDto(auth.LoginEmployeeDTO? authClock) {
    if (authClock == null) {
      return null;
    }
    return EmployeeDto(
      id: authClock.id,
      arpId: authClock.arpId,
      company: CompanyMapper.fromAuthToCollectorDto(authClock.company)!,
      cpfNumber: authClock.cpfNumber,
      employeeCode: authClock.employeeCode,
      employeeType: authClock.employeeType.toString(),
      enabled: authClock.enabled,
      faceRegistered: authClock.faceRegistered,
      fences: FenceMapper.fromAuthToCollectorDtoList(authClock.fences),
      mail: authClock.mail,
      managers: ManagerMapper.fromAuthToCollectorDtoList(authClock.managers),
      name: authClock.name,
      nfcCode: authClock.nfcCode,
      platformUsers: PlatformUserMapper.fromAuthToCollectorDtoList(
        authClock.platformUsers,
      ),
      registrationNumber: authClock.registrationNumber,
      reminders: ReminderMapper.fromAuthToCollectorDtoList(authClock.reminders),
      pis: authClock.pis,
    );
  }

  static Employee? fromClockToCollectorEntity(clock.EmployeeDto? dtoClock) {
    if (dtoClock == null) {
      return null;
    }
    return Employee(
      id: dtoClock.id,
      arpId: dtoClock.arpId,
      company: CompanyMapper.fromClockToCollectorEntity(dtoClock.company)!,
      cpf: dtoClock.cpf,
      employeeType: dtoClock.employeeType,
      enable: dtoClock.enable,
      mail: dtoClock.mail,
      name: dtoClock.name ?? '',
      nfcCode: dtoClock.nfcCode,
      registrationNumber: dtoClock.registrationNumber,
      employeeCode: dtoClock.employeeCode,
      faceRegistered: dtoClock.faceRegistered,
      fences: FenceMapper.fromClockToCollectorEntityList(dtoClock.fences),
      pis: dtoClock.pis,
      platformUsers: PlatformUserMapper.fromClockToCollectorEntityList(
        dtoClock.platformUsers,
      ),
      managerEmployees:
          ManagerMapper.fromClockToCollectorEntityList(dtoClock.managers),
    );
  }

  static List<EmployeeDto>? fromEntityToDtoCollectorList(
    List<Employee>? entity,
  ) {
    if (entity == null) {
      return null;
    }
    List<EmployeeDto> list = [];
    for (var item in entity) {
      list.add(fromEntityToDtoCollector(item)!);
    }
    return list;
  }

  static List<EmployeeItemEntity>? fromEntityToEmployeeItem(
    List<Employee>? employeesWithAppointmentsList,
  ) {
    if (employeesWithAppointmentsList == null) {
      return null;
    }
    List<EmployeeItemEntity> employeesItemList = [];
    for (Employee? employee in employeesWithAppointmentsList) {
      if (employee == null) {
        return employeesItemList;
      }
      EmployeeItemEntity employeeItemEntity = EmployeeItemEntity(
        id: employee.id,
        name: employee.name ?? '',
        identifier: employee.cpf,
      );
      employeesItemList.add(employeeItemEntity);
    }
    return employeesItemList;
  }
}
