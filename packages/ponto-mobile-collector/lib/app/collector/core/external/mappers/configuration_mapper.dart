import 'package:mobile_authentication/mobile_authentication_service.dart' as auth;

import '../../domain/entities/configuration.dart';
import '../../domain/enums/operation_mode_type.dart';
import '../../domain/input_model/configuration_dto.dart';
import 'clocking_event_use_mapper.dart';

class ConfigurationMapper {
  static ConfigurationDto? fromAuthToCollectorDto(
    auth.LoginConfigurationDTO? loginConfigurationResponse,
  ) {
    if (loginConfigurationResponse == null) {
      return null;
    }
    return ConfigurationDto(
      allowChangeTime: loginConfigurationResponse.allowChangeTime,
      clockingEventUses:
          ClockingEventUseMapper.fromAuthToCollectorDtoList(loginConfigurationResponse.clockingEventUses),
      id: loginConfigurationResponse.id,
      onlyOnline: loginConfigurationResponse.onlyOnline,
      operationMode: OperationModeType.build(loginConfigurationResponse.operationMode.value),
      timezone: loginConfigurationResponse.timezone,
      takePhoto: loginConfigurationResponse.takePhoto,
      faceRecognition: loginConfigurationResponse.faceRecognition,
      faceRecognitionSingle: loginConfigurationResponse.faceRecognitionSingle,
      faceRecognitionMulti: loginConfigurationResponse.faceRecognitionMulti,
      username: loginConfigurationResponse.username,
      isManager: loginConfigurationResponse.isManager,
      managerId: loginConfigurationResponse.managerId,
      overnight: loginConfigurationResponse.overnight,
      controlOvernight: loginConfigurationResponse.controlOvernight,
      gps: loginConfigurationResponse.gps,
      allowDrivingTime: loginConfigurationResponse.allowDrivingTime,
      allowGpoOnApp: loginConfigurationResponse.allowGpoOnApp,
      allowUse: loginConfigurationResponse.allowUse,
      deviceAuthorizationType:
          loginConfigurationResponse.deviceAuthorizationType,
      exportNotChecked: loginConfigurationResponse.exportNotChecked,
      externalControlTimezone:
          loginConfigurationResponse.externalControlTimezone,
      nfcMode: loginConfigurationResponse.nfcMode,
      openExternalBrowser: loginConfigurationResponse.openExternalBrowser,
      takePhotoDriver: loginConfigurationResponse.takePhotoDriver,
      takePhotoNfc: loginConfigurationResponse.takePhotoNfc,
      takePhotoQrcode: loginConfigurationResponse.takePhotoQrcode,
      takePhotoSingle: loginConfigurationResponse.takePhotoSingle,
    );
  }

static Configuration? fromAuthToEntityCollector(auth.LoginConfigurationDTO? authDto){
    if (authDto == null) {
      return null;
    }
    return Configuration(
      allowChangeTime: authDto.allowChangeTime,
      clockingEventUses: ClockingEventUseMapper.fromAuthToCollectorEntityList(authDto.clockingEventUses),
      id: authDto.id,
      onlyOnline: authDto.onlyOnline,
      operationMode: OperationModeType.build(authDto.operationMode.value),
      timezone: authDto.timezone,
      takePhoto: authDto.takePhoto,
      faceRecognition: authDto.faceRecognition,
      faceRecognitionSingle: authDto.faceRecognitionSingle,
      faceRecognitionMulti: authDto.faceRecognitionMulti,
      username: authDto.username,
      isManager: authDto.isManager,
      managerId: authDto.managerId,
      overnight: authDto.overnight,
      controlOvernight: authDto.controlOvernight,
      gps: authDto.gps,
      allowDrivingTime: authDto.allowDrivingTime,
      allowGpoOnApp: authDto.allowGpoOnApp,
      allowUse: authDto.allowUse,
      deviceAuthorizationType: authDto.deviceAuthorizationType,
      exportNotChecked: authDto.exportNotChecked,
      externalControlTimezone: authDto.externalControlTimezone,
      nfcMode: authDto.nfcMode,
      openExternalBrowser: authDto.openExternalBrowser,
      takePhotoDriver: authDto.takePhotoDriver,
      takePhotoNfc: authDto.takePhotoNfc,
      takePhotoQrcode: authDto.takePhotoQrcode,
      takePhotoSingle: authDto.takePhotoSingle,
    );

}
  static ConfigurationDto? fromEntityToDtoCollector (
    Configuration? entity,
  ) {
    if (entity == null) {
      return null;
    }
    return ConfigurationDto(
      allowChangeTime: entity.allowChangeTime,
      clockingEventUses: ClockingEventUseMapper.fromEntityToDtoCollectorList(entity.clockingEventUses),
      id: entity.id,
      onlyOnline: entity.onlyOnline,
      operationMode: entity.operationMode,
      timezone: entity.timezone,
      takePhoto: entity.takePhoto,
      faceRecognition: entity.faceRecognition,
      faceRecognitionSingle: entity.faceRecognitionSingle,
      faceRecognitionMulti: entity.faceRecognitionMulti,
      username: entity.username,
      isManager: entity.isManager,
      managerId: entity.managerId,
      overnight: entity.overnight,
      controlOvernight: entity.controlOvernight,
      gps: entity.gps,
      allowDrivingTime: entity.allowDrivingTime,
      allowGpoOnApp: entity.allowGpoOnApp,
      allowUse: entity.allowUse,
      deviceAuthorizationType: entity.deviceAuthorizationType,
      exportNotChecked: entity.exportNotChecked,
      externalControlTimezone: entity.externalControlTimezone,
      nfcMode: entity.nfcMode,
      openExternalBrowser: entity.openExternalBrowser,
      takePhotoDriver: entity.takePhotoDriver,
      takePhotoNfc: entity.takePhotoNfc,
      takePhotoQrcode: entity.takePhotoQrcode,
      takePhotoSingle: entity.takePhotoSingle,
    );
  }

  static Configuration fromDtoToEntityCollector (
    ConfigurationDto dto,
  ) {
    return Configuration(
      allowChangeTime: dto.allowChangeTime,
      clockingEventUses: ClockingEventUseMapper.fromDtoToEntityCollectorList(dto.clockingEventUses),
      id: dto.id,
      onlyOnline: dto.onlyOnline,
      operationMode: dto.operationMode,
      timezone: dto.timezone,
      takePhoto: dto.takePhoto,
      faceRecognition: dto.faceRecognition,
      faceRecognitionSingle: dto.faceRecognitionSingle,
      faceRecognitionMulti: dto.faceRecognitionMulti,
      username: dto.username,
      isManager: dto.isManager,
      managerId: dto.managerId,
      overnight: dto.overnight,
      controlOvernight: dto.controlOvernight,
      gps: dto.gps,
      allowDrivingTime: dto.allowDrivingTime,
      allowGpoOnApp: dto.allowGpoOnApp,
      allowUse: dto.allowUse,
      deviceAuthorizationType: dto.deviceAuthorizationType,
      exportNotChecked: dto.exportNotChecked,
      externalControlTimezone: dto.externalControlTimezone,
      nfcMode: dto.nfcMode,
      openExternalBrowser: dto.openExternalBrowser,
      takePhotoDriver: dto.takePhotoDriver,
      takePhotoNfc: dto.takePhotoNfc,
      takePhotoQrcode: dto.takePhotoQrcode,
      takePhotoSingle: dto.takePhotoSingle,
    );
  }

  static auth.LoginConfigurationDTO? fromEntityToDtoAuth(Configuration? configuration) {
    if (configuration == null) {
      return null;
    }
    return auth.LoginConfigurationDTO(
      allowChangeTime: configuration.allowChangeTime,
      clockingEventUses: ClockingEventUseMapper.fromEntityToDtoAuthList(configuration.clockingEventUses),
      id: configuration.id,
      onlyOnline: configuration.onlyOnline,
      operationMode: auth.OperationModeType.build(configuration.operationMode.value),
      timezone: configuration.timezone,
      takePhoto: configuration.takePhoto,
      faceRecognition: configuration.faceRecognition,
      faceRecognitionSingle: configuration.faceRecognitionSingle,
      faceRecognitionMulti: configuration.faceRecognitionMulti,
      username: configuration.username,
      isManager: configuration.isManager,
      managerId: configuration.managerId,
      overnight: configuration.overnight,
      controlOvernight: configuration.controlOvernight,
      gps: configuration.gps,
      allowDrivingTime: configuration.allowDrivingTime,
      allowGpoOnApp: configuration.allowGpoOnApp,
      allowUse: configuration.allowUse,
      deviceAuthorizationType: configuration.deviceAuthorizationType,
      exportNotChecked: configuration.exportNotChecked,
      externalControlTimezone: configuration.externalControlTimezone,
      nfcMode: configuration.nfcMode,
      openExternalBrowser: configuration.openExternalBrowser,
      takePhotoDriver: configuration.takePhotoDriver,
      takePhotoNfc: configuration.takePhotoNfc,
      takePhotoQrcode: configuration.takePhotoQrcode,
      takePhotoSingle: configuration.takePhotoSingle,
    );
  }
}
