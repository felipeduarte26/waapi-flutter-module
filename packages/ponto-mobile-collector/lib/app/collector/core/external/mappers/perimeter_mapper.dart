import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart' as clock;
import 'package:mobile_authentication/mobile_authentication_service.dart' as auth;

import '../../domain/entities/perimeter.dart';
import '../../domain/enums/geometric_form_type.dart';
import '../../domain/input_model/location_dto.dart';
import '../../domain/input_model/perimeter_dto.dart';

class PerimeterMapper{
  static List<PerimeterDto>? fromClockToCollectorDtoList(List<clock.PerimeterDto>? clockList) {
    if (clockList == null) {
      return null;
    }
    List<PerimeterDto> perimeters = [];
    

    for (var perimeter in clockList) {
      var perimeterCollector = fromClockToCollectorDto(perimeter);
      if (perimeterCollector != null) {
        perimeters.add(perimeterCollector);
      }
    }
    return perimeters;
  }
  
  static PerimeterDto? fromClockToCollectorDto(clock.PerimeterDto? dtoClock) {
    if (dtoClock == null) {
      return null;
    }

    return PerimeterDto(
      id: dtoClock.id,
      radius: dtoClock.radius,
      startPoint: LocationDto.fromClockToCollectorDto(dtoClock.startPoint)!,
      type: GeometricFormType.build(dtoClock.type.value),
    );
  }

  static List<clock.PerimeterDto>? fromCollectorDtoToClockList(List<PerimeterDto>? dtoList) {
    if (dtoList == null) {
      return null;
    }
    List<clock.PerimeterDto> perimeters = [];
    

    for (var perimeter in dtoList) {
      var perimeterClock = fromCollectorDtoToClock(perimeter);
      if (perimeterClock != null) {
        perimeters.add(perimeterClock);
      }
    }
    return perimeters;
  }
  
  static clock.PerimeterDto? fromCollectorDtoToClock(PerimeterDto? dto) {
    if (dto == null) {
      return null;
    }

    return clock.PerimeterDto(
      id: dto.id ?? '',
      radius: dto.radius,
      startPoint: LocationDto.fromCollectorDtoToClock(dto.startPoint)!,
      type: clock.GeometricFormType.build(dto.type.value),
    );
  }


  static List<Perimeter>? fromDtoToEntitiyListCollector(List<PerimeterDto>? dtoList){
    if(dtoList == null){
      return null;
    }
    List<Perimeter> perimeters = [];
    for (var dto in dtoList) {
      var perimeter = fromDtoToEntityCollector(dto);
      if (perimeter != null) {
        perimeters.add(perimeter);
      }
    }
    return perimeters;
  }
  
  static Perimeter? fromDtoToEntityCollector(PerimeterDto? dto) {
    if (dto == null) {
      return null;
    }

    return Perimeter(
      id: dto.id,
      radius: dto.radius,
      startPoint: dto.startPoint,
      type: dto.type,
    );
  }

  static List<PerimeterDto>? fromEntityToDtoListCollector(List<Perimeter>? entityList){
    if(entityList == null){
      return null;
    }
    List<PerimeterDto> perimeters = [];
    for (var entity in entityList) {
      var perimeter = fromEntityToDtoCollector(entity);
      if (perimeter != null) {
        perimeters.add(perimeter);
      }
    }
    return perimeters;
  }
  
  static PerimeterDto? fromEntityToDtoCollector(Perimeter? entity) {
    if (entity == null) {
      return null;
    }

    return PerimeterDto(
      id: entity.id,
      radius: entity.radius,
      startPoint: entity.startPoint!,
      type: entity.type!,
    );
  }

  static List<PerimeterDto>? fromAuthToCollectorDtoList(List<auth.PerimeterDTO>? clockList) {
    if (clockList == null) {
      return null;
    }
    List<PerimeterDto> perimeters = [];
    

    for (var perimeter in clockList) {
      var perimeterCollector = fromAuthToCollectorDto(perimeter);
      if (perimeterCollector != null) {
        perimeters.add(perimeterCollector);
      }
    }
    return perimeters;
  }
  
  static PerimeterDto? fromAuthToCollectorDto(auth.PerimeterDTO? dtoAuth) {
    if (dtoAuth == null) {
      return null;
    }

    return PerimeterDto(
      id: dtoAuth.id,
      radius: dtoAuth.radius,
      startPoint: LocationDto.fromAuthToCollectorDto(dtoAuth.startPoint)!,
      type: GeometricFormType.build(dtoAuth.type.value),
    );
  }

  static List<Perimeter>? fromClockToCollectorEntityList(List<clock.PerimeterDto>? clockList) {
    if (clockList == null) {
      return null;
    }
    List<Perimeter> perimeters = [];
    for (var perimeter in clockList) {
      var perimeterCollector = fromClockToCollectorEntity(perimeter);
      if (perimeterCollector != null) {
        perimeters.add(perimeterCollector);
      }
    }
    return perimeters;
  }
  
  static Perimeter? fromClockToCollectorEntity(clock.PerimeterDto? dtoClock) {
    if (dtoClock == null) {
      return null;
    }

    return Perimeter(
      id: dtoClock.id,
      radius: dtoClock.radius,
      startPoint: LocationDto.fromClockToCollectorDto(dtoClock.startPoint)!,
      type: GeometricFormType.build(dtoClock.type.toString()),
    );
  }
}
