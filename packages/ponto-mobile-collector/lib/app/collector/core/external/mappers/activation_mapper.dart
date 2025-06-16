import 'package:mobile_authentication/mobile_authentication_service.dart'
    as auth;

import '../../domain/entities/activation.dart';
import '../../domain/enums/activation_situation_type.dart';
import '../../domain/enums/status_device.dart';
import '../../domain/input_model/activation_dto.dart';

class ActivationMapper {
  static ActivationDto? fromAuthToCollectorDto(
    auth.LoginActivationDTO? loginActivationResponse,
  ) {
    if (loginActivationResponse == null) {
      return null;
    }

    return ActivationDto(
      deviceSituation: StatusDevice.build(
          loginActivationResponse.deviceSituation.value,),
      employeeSituation: ActivationSituationType.build(
          loginActivationResponse.employeeSituation.value,),
      requestDate: loginActivationResponse.requestDate,
      requestTime: loginActivationResponse.requestTime,
    );
  }

  static ActivationDto? fromEntityToDtoCollector(
    Activation? entity,
  ) {
    if (entity == null) {
      return null;
    }
    return ActivationDto(
      deviceSituation: entity.deviceSituation,
      employeeSituation: entity.employeeSituation,
      requestDate: entity.requestDate,
      requestTime: entity.requestTime,
    );
  }

  static Activation fromDtoToEntityCollector(
    ActivationDto dto,
  ) {
    return Activation(
      deviceSituation: dto.deviceSituation,
      employeeSituation: dto.employeeSituation,
      requestDate: dto.requestDate,
      requestTime: dto.requestTime,
    );
  }

  static auth.LoginActivationDTO? fromCollectorDtoToAuthDto(
    ActivationDto? dto,
  ) {
    if (dto == null) {
      return null;
    }
    return auth.LoginActivationDTO(
      deviceSituation: auth.StatusDevice.build(dto.deviceSituation.value),
      employeeSituation: auth.ActivationSituationType.build(dto.employeeSituation.value),
      requestDate: dto.requestDate,
      requestTime: dto.requestTime,
    );
  }
}
