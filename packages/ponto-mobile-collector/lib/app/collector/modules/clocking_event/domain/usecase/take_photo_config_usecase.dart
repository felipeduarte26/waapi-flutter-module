import '../../../../../../ponto_mobile_collector.dart';
import '../../../../core/domain/entities/configuration.dart';
import '../../../../core/domain/entities/global_configuration_entity.dart';
import '../../../../core/domain/input_model/clocking_event_register_type.dart';
import '../../../../core/domain/input_model/configuration_dto.dart';
import '../../../../core/domain/repositories/database/iglobal_configuration_repository.dart';
import '../../../../core/domain/usecases/get_execution_mode_usecase.dart';
import '../../../../core/external/mappers/configuration_mapper.dart';
import '../../../../core/infra/utils/enum/execution_mode_enum.dart';

abstract class ITakePhotoConfigUsecase {
  Future<bool> call({ClockingEventRegisterType? clockingEventRegisterType});
}

class TakePhotoConfigUsecase implements ITakePhotoConfigUsecase {
  final ISessionService _sessionService;
  final GetExecutionModeUsecase _getExecutionModeUsecase;
  final IGlobalConfigurationRepository _globalConfigurationRepository;
  final IConfigurationRepository _configurationRepository;
  const TakePhotoConfigUsecase({
    required ISessionService sessionService,
    required GetExecutionModeUsecase getExecutionModeUsecase,
    required IGlobalConfigurationRepository globalConfigurationRepository,
    required IConfigurationRepository configurationRepository,
  })  : _sessionService = sessionService,
        _getExecutionModeUsecase = getExecutionModeUsecase,
        _globalConfigurationRepository = globalConfigurationRepository,
        _configurationRepository = configurationRepository;

  @override
  Future<bool> call({
    ClockingEventRegisterType? clockingEventRegisterType,
  }) async {
    ExecutionModeEnum executionModeEnum = await _getExecutionModeUsecase.call();

    if (executionModeEnum.isIndividualOrDriver()) {
      return _sessionService.getConfiguration().takePhoto;
    } else {
      List<GlobalConfigurationEntity> deviceConfigurations =
          await _globalConfigurationRepository.getAll();
      GlobalConfigurationEntity? globalConfigurationEntity;

      /// If there is a configuration for the device, it will be used
      if (deviceConfigurations.isNotEmpty) {
        globalConfigurationEntity = deviceConfigurations.first;

        if (clockingEventRegisterType != null) {
          if (clockingEventRegisterType is ClockingEventRegisterTypeNFC) {
            return globalConfigurationEntity.takePhotoNfc ?? false;
          }

          if (clockingEventRegisterType is ClockingEventRegisterTypeQRCode) {
            return globalConfigurationEntity.takePhotoQrcode ?? false;
          }

          if (clockingEventRegisterType
              is ClockingEventRegisterTypeEmailPassword) {
            return globalConfigurationEntity.takePhotoMulti ?? false;
          }
        }
      } else {
        /// If there is no configuration for the device, it will be used
        if (clockingEventRegisterType
            is ClockingEventRegisterTypeEmailPassword) {
          Configuration? configEntity = 
              await _configurationRepository.findByEmployeeId(
            employeeId: clockingEventRegisterType.employeeId,
          );
          ConfigurationDto? loginConfigurationDTO = ConfigurationMapper.fromEntityToDtoCollector(configEntity);

          if (loginConfigurationDTO != null) {
            return loginConfigurationDTO.takePhoto;
          }
        }
      }

      return false;
    }
  }
}
