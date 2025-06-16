import 'package:mobile_authentication/mobile_authentication_service.dart'
    as auth;

import '../../domain/entities/clocking_event_use.dart';
import '../../domain/enums/clocking_event_use_type.dart';
import '../../domain/input_model/clocking_event_use_dto.dart';

class ClockingEventUseMapper {
  static List<ClockingEventUseDto>? fromAuthToCollectorDtoList(
    List<auth.ClockingEventUseDTO>? clockingEventUses,
  ) {
    if (clockingEventUses == null) {
      return [];
    }
    List<ClockingEventUseDto> uses = [];

    for (var use in clockingEventUses) {
      var useEntity = fromAuthToCollectorDto(use);
      if (useEntity != null) {
        uses.add(useEntity);
      }
    }
    return uses;
  }

  static ClockingEventUseDto? fromAuthToCollectorDto(
    auth.ClockingEventUseDTO? dtoAuth,
  ) {
    if (dtoAuth == null) {
      return null;
    }
    return ClockingEventUseDto(
      clockingEventUseType:
          ClockingEventUseType.build(dtoAuth.clockingEventUseType.value),
      code: dtoAuth.code,
      description: dtoAuth.description,
      employeeId: dtoAuth.employeeId,
    );
  }

  static List<ClockingEventUseDto>? fromEntityToDtoCollectorList(
    List<ClockingEventUse>? entityList,
  ) {
    if (entityList == null) {
      return [];
    }
    List<ClockingEventUseDto> uses = [];
    for (var use in entityList) {
      var useEntity = fromEntityToDtoCollector(use);
      if (useEntity != null) {
        uses.add(useEntity);
      }
    }
    return uses;
  }

  static ClockingEventUseDto? fromEntityToDtoCollector(
    ClockingEventUse? entity,
  ) {
    if (entity == null) {
      return null;
    }
    return ClockingEventUseDto(
      clockingEventUseType: entity.clockingEventUseType,
      code: entity.code,
      description: entity.description,
      employeeId: entity.employeeId,
    );
  }

  static List<ClockingEventUse>? fromDtoToEntityCollectorList(
    List<ClockingEventUseDto>? dtoList,
  ) {
    if (dtoList == null) {
      return [];
    }
    List<ClockingEventUse> uses = [];
    for (var use in dtoList) {
      var useEntity = fromDtoToEntityCollector(use);
      if (useEntity != null) {
        uses.add(useEntity);
      }
    }
    return uses;
  }

  static ClockingEventUse? fromDtoToEntityCollector(
    ClockingEventUseDto? dto,
  ) {
    if (dto == null) {
      return null;
    }
    return ClockingEventUse(
      clockingEventUseType: dto.clockingEventUseType,
      code: dto.code,
      description: dto.description,
      employeeId: dto.employeeId,
    );
  }

  static List<ClockingEventUse>? fromAuthToCollectorEntityList(
      List<auth.ClockingEventUseDTO>? clockingEventUses,) {
    if (clockingEventUses == null) {
      return [];
    }
    List<ClockingEventUse> uses = [];
    for (var use in clockingEventUses) {
      var useEntity = fromAuthToCollectorEntity(use);
      if (useEntity != null) {
        uses.add(useEntity);
      }
    }
    return uses;
  }

  static ClockingEventUse? fromAuthToCollectorEntity(
      auth.ClockingEventUseDTO? dtoAtuh,) {
    if (dtoAtuh == null) {
      return null;
    }
    return ClockingEventUse(
      clockingEventUseType:
          ClockingEventUseType.build(dtoAtuh.clockingEventUseType.value),
      code: dtoAtuh.code,
      description: dtoAtuh.description,
      employeeId: dtoAtuh.employeeId,
    );
  }

  static List<auth.ClockingEventUseDTO> fromDtoCollectorToAuthList(List<ClockingEventUseDto> clockingUseList) {
    List<auth.ClockingEventUseDTO> list = [];
    for (var item in clockingUseList) {
      list.add(fromDtoCollectorToAuth(item));
    }
    return list;

  }
  
  static auth.ClockingEventUseDTO fromDtoCollectorToAuth(ClockingEventUseDto dto) {
    return auth.ClockingEventUseDTO(
      clockingEventUseType: auth.ClockingEventUseType.build(
        dto.clockingEventUseType.value,
      ),
      code: dto.code,
      description: dto.description,
      employeeId: dto.employeeId,
    );
  }

  static List<auth.ClockingEventUseDTO>? fromEntityToDtoAuthList(List<ClockingEventUse>? clockingEventUses) {
    if (clockingEventUses == null) {
      return [];
    }
    List<auth.ClockingEventUseDTO> uses = [];
    for (var use in clockingEventUses) {
      var useEntity = fromEntityToDtoAuth(use);
      if (useEntity != null) {
        uses.add(useEntity);
      }
    }
    return uses;
  }
  
  static auth.ClockingEventUseDTO? fromEntityToDtoAuth(ClockingEventUse use) {
    return auth.ClockingEventUseDTO(
      clockingEventUseType: auth.ClockingEventUseType.build(
        use.clockingEventUseType.value,
      ),
      code: use.code,
      description: use.description,
      employeeId: use.employeeId,
    );
  }
}
