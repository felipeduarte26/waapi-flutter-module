import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart' as clock;
import 'package:mobile_authentication/mobile_authentication_service.dart' as auth;

import '../../domain/entities/platform_user.dart';
import '../../domain/input_model/platform_user_dto.dart';

class PlatformUserMapper{

  static List<PlatformUserDto>? fromClockToCollectorDtoList(List<clock.PlatformUserEmployeeDto>? clockList) {
    if (clockList == null) {
      return null;
    }
    List<PlatformUserDto> platformUserEmployees = [];
    

    for (var platformUserEmployee in clockList) {
      var platformUserEmployeeCollector = fromClockToCollectorDto(platformUserEmployee);
      if (platformUserEmployeeCollector != null) {
        platformUserEmployees.add(platformUserEmployeeCollector);
      }
    }
    return platformUserEmployees;
  }
  
  static PlatformUserDto? fromClockToCollectorDto(clock.PlatformUserEmployeeDto? dtoClock) {
    if (dtoClock == null) {
      return null;
    }

    return PlatformUserDto(
      id: dtoClock.id,
      username: dtoClock.username,
    );
  }

  static List<clock.PlatformUserEmployeeDto>? fromCollectorDtoToClockList(List<PlatformUserDto>? dtoList) {
    if (dtoList == null) {
      return null;
    }
    List<clock.PlatformUserEmployeeDto> platformUserEmployees = [];
    

    for (var platformUserEmployee in dtoList) {
      var platformUserEmployeeClock = fromCollectorDtoToClock(platformUserEmployee);
      if (platformUserEmployeeClock != null) {
        platformUserEmployees.add(platformUserEmployeeClock);
      }
    }
    return platformUserEmployees;
  }
  
  static clock.PlatformUserEmployeeDto? fromCollectorDtoToClock(PlatformUserDto? dto) {
    if (dto == null) {
      return null;
    }

    return clock.PlatformUserEmployeeDto(
      id: dto.id,
      username: dto.username,
    );
  }

   static List<PlatformUserDto>? fromAuthToCollectorDtoList(List<auth.PlatformUserEmployeeDTO>? authList) {
    if (authList == null) {
      return null;
    }
    List<PlatformUserDto> platformUserEmployees = [];
    

    for (var platformUserEmployee in authList) {
      var platformUserEmployeeCollector = fromAuthToCollectorDto(platformUserEmployee);
      if (platformUserEmployeeCollector != null) {
        platformUserEmployees.add(platformUserEmployeeCollector);
      }
    }
    return platformUserEmployees;
  }
  
  static PlatformUserDto? fromAuthToCollectorDto(auth.PlatformUserEmployeeDTO? dtoAuth) {
    if (dtoAuth == null) {
      return null;
    }

    return PlatformUserDto(
      id: dtoAuth.id,
      username: dtoAuth.username,
    );
  }

  static List<PlatformUser>? fromDtoToEntityCollectorList (List<PlatformUserDto>? dtoList) {
    if (dtoList == null) {
      return null;
    }
    List<PlatformUser> platformUsers = [];
    

    for (var platformUser in dtoList) {
      var platformUserEntity = fromDtoToEntityCollector(platformUser);
      if (platformUserEntity != null) {
        platformUsers.add(platformUserEntity);
      }
    }
    return platformUsers;
  }
  
  static PlatformUser? fromDtoToEntityCollector(PlatformUserDto? dto) {
    if (dto == null) {
      return null;
    }

    return PlatformUser(
      id: dto.id,
      platformUserName: dto.username,
    );
  }

  static List<PlatformUserDto>? fromEntityToDtoCollectorList(List<PlatformUser>? entityList) {
    if (entityList == null) {
      return null;
    }
    List<PlatformUserDto> platformUsers = [];
    

    for (var platformUser in entityList) {
      var platformUserDto = fromEntityToDtoCollector(platformUser);
      if (platformUserDto != null) {
        platformUsers.add(platformUserDto);
      }
    }
    return platformUsers;
  }
  
  static PlatformUserDto? fromEntityToDtoCollector(PlatformUser? entity) {
    if (entity == null) {
      return null;
    }

    return PlatformUserDto(
      id: entity.id,
      username: entity.platformUserName?? '',
    );
  }

  static List<PlatformUser>? fromClockToCollectorEntityList(List<clock.PlatformUserEmployeeDto>? clockList) {
    if (clockList == null) {
      return null;
    }
    List<PlatformUser> platformUsers = [];
    

    for (var platformUser in clockList) {
      var platformUserCollector = fromClockToCollectorEntity(platformUser);
      if (platformUserCollector != null) {
        platformUsers.add(platformUserCollector);
      }
    }
    return platformUsers;
  }
  
  static PlatformUser? fromClockToCollectorEntity(clock.PlatformUserEmployeeDto? clockDto) {
    if (clockDto == null) {
      return null;
    }

    return PlatformUser(
      id: clockDto.id,
      platformUserName: clockDto.username,
    );
  }
}
