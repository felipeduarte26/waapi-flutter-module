import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart' as clock;
import 'package:mobile_authentication/mobile_authentication_service.dart' as auth;
import '../../domain/entities/fence.dart';
import '../../domain/input_model/fence_dto.dart';
import 'perimeter_mapper.dart';

class FenceMapper {

  static List<FenceDto>? fromClockToCollectorDtoList(List<clock.FenceDto>? clockList) {
    if (clockList == null) {
      return null;
    }
    List<FenceDto> dtoList = [];
    

    for (var fence in clockList) {
      var fenceCollector = fromClockToCollectorDto(fence);
      if (fenceCollector != null) {
        dtoList.add(fenceCollector);
      }
    }
    return dtoList;
  }

  static FenceDto? fromClockToCollectorDto(clock.FenceDto? dtoClockFence) {
    if (dtoClockFence == null) {
      return null;
    }

    return FenceDto(
      id: dtoClockFence.id,
      name: dtoClockFence.name,
      perimeters: PerimeterMapper.fromClockToCollectorDtoList(dtoClockFence.perimeters),
    );
  }

  static List<clock.FenceDto>? fromCollectorDtoToClockList(List<FenceDto>? dtoList) {
    if (dtoList == null) {
      return null;
    }
    List<clock.FenceDto> fences = [];
    

    for (var fence in dtoList) {
      var fenceClock = fromCollectorDtoToClock(fence);
      if (fenceClock != null) {
        fences.add(fenceClock);
      }
    }
    return fences;
  }
  
  static clock.FenceDto? fromCollectorDtoToClock(FenceDto? dto) {
    if (dto == null) {
      return null;
    }

    return clock.FenceDto(
      id: dto.id ?? '',
      name: dto.name,
      perimeters: PerimeterMapper.fromCollectorDtoToClockList(dto.perimeters),
    );
  }

  static List<Fence>? fromDtoToEntityCollectorList(List<FenceDto>? dtoList) {
    if (dtoList == null) {
      return null;
    }
    List<Fence> entityList = [];    

    for (var fence in dtoList) {
      var fenceEntity = fromDtoToEntityCollector(fence);
      if (fenceEntity != null) {
        entityList.add(fenceEntity);
      }
    }
    return entityList;
  }
  
  static Fence? fromDtoToEntityCollector(FenceDto? dto) {
    if (dto == null) {
      return null;
    }

    return Fence(
      id: dto.id,
      name: dto.name,
      perimeters: PerimeterMapper.fromDtoToEntitiyListCollector(dto.perimeters),
    );
  }

  static List<FenceDto>? fromEntityToDtoCollectorList(List<Fence>? entityList) {
    if (entityList == null) {
      return null;
    }
    List<FenceDto> fences = [];
    

    for (var fence in entityList) {
      var fenceDto = fromEntityToDtoCollector(fence);
      if (fenceDto != null) {
        fences.add(fenceDto);
      }
    }
    return fences;
  }
  
  static FenceDto? fromEntityToDtoCollector(Fence? entity) {
    if (entity == null) {
      return null;
    }

    return FenceDto(
      id: entity.id,
      name: entity.name,
      perimeters: PerimeterMapper.fromEntityToDtoListCollector(entity.perimeters),
    );
  }

  static List<FenceDto>? fromAuthToCollectorDtoList(List<auth.FenceDTO>? authList) {
    if (authList == null) {
      return null;
    }
    List<FenceDto> fences = [];
    

    for (var fence in authList) {
      var fenceDto = fromAuthToCollectorDto(fence);
      if (fenceDto != null) {
        fences.add(fenceDto);
      }
    }
    return fences;
  }
  
  static FenceDto? fromAuthToCollectorDto(auth.FenceDTO? dto) {
    if (dto == null) {
      return null;
    }

    return FenceDto(
      id: dto.id,
      name: dto.name,
      perimeters: PerimeterMapper.fromAuthToCollectorDtoList(dto.perimeters),
    );
  }

  static List<Fence>? fromClockToCollectorEntityList(List<clock.FenceDto>? clockList) {
    if (clockList == null) {
      return null;
    }
    List<Fence> fences = [];
    

    for (var fence in clockList) {
      var fenceEntity = fromClockToCollectorEntity(fence);
      if (fenceEntity != null) {
        fences.add(fenceEntity);
      }
    }
    return fences;
  }
  
  static Fence? fromClockToCollectorEntity(clock.FenceDto dtoClock) {
    return Fence(
      id: dtoClock.id,
      name: dtoClock.name,
      perimeters: PerimeterMapper.fromClockToCollectorEntityList(dtoClock.perimeters),
    );
  }
}
