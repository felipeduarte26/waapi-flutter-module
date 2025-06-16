import 'dart:developer';

import '../../../modules/clocking_event/domain/usecase/init_clock_usecase.dart';
import '../../infra/repositories/database/device_configuration_repository.dart';
import '../../infra/repositories/database/global_configuration_repository.dart';
import '../entities/global_device_configuration_entity.dart';
import '../enums/token_type.dart';
import '../input_model/device_info_dto.dart';
import '../repositories/database/idevice_repository.dart';
import '../repositories/get_global_device_configuration_repository.dart';
import '../services/firebase/log_service.dart';
import '../services/platform/iplatform_service.dart';
import 'get_access_token_usecase.dart';

abstract class GetGlobalDeviceConfigurationUsecase {
  Future<GlobalDeviceConfigurationEntity?> call();
}

class GetGlobalDeviceConfigurationUsecaseImpl
    implements GetGlobalDeviceConfigurationUsecase {
  final GetGlobalDeviceConfigurationRepository
      _getGlobalDeviceConfigurationRepository;
  final DeviceConfigurationRepository _deviceConfigurationRepository;
  final GlobalConfigurationRepository _globalConfigurationRepository;
  final IPlatformService _platformService;
  final IDeviceRepository _deviceRepository;
  final GetAccessTokenUsecase _getAccessTokenUsecase;
  final InitClockUsecase _initClockUsecase;
  final LogService _logService;

  GetGlobalDeviceConfigurationUsecaseImpl({
    required GetGlobalDeviceConfigurationRepository
        getGlobalDeviceConfigurationRepository,
    required DeviceConfigurationRepository deviceConfigurationRepository,
    required GlobalConfigurationRepository globalConfigurationRepository,
    required IPlatformService platformService,
    required IDeviceRepository deviceRepository,
    required GetAccessTokenUsecase getAccessTokenUsecase,
    required InitClockUsecase initClockUsecase,
    required LogService logService,
  })  : _getGlobalDeviceConfigurationRepository =
            getGlobalDeviceConfigurationRepository,
        _deviceConfigurationRepository = deviceConfigurationRepository,
        _globalConfigurationRepository = globalConfigurationRepository,
        _platformService = platformService,
        _deviceRepository = deviceRepository,
        _getAccessTokenUsecase = getAccessTokenUsecase,
        _initClockUsecase = initClockUsecase,
        _logService = logService;

  @override
  Future<GlobalDeviceConfigurationEntity?> call() async {
    String? keyToken =
        await _getAccessTokenUsecase.call(tokenType: TokenType.key);

    if (keyToken == null || keyToken.isEmpty) {
      log('GetGlobalDeviceConfigurationUsecase: Key token is empty');
      _logService.saveLocalLog(
        exception: 'GetGlobalDeviceConfigurationUsecase',
        stackTrace: 'Key token is empty at ${DateTime.now()}',
      );
      return null;
    }

    DeviceInfo deviceInfo = await _platformService.getDeviceInfoDto();

    GlobalDeviceConfigurationEntity? globalDeviceConfigurationEntity =
        await _getGlobalDeviceConfigurationRepository.call(
      identifier: deviceInfo.identifier,
    );

    if (globalDeviceConfigurationEntity != null) {
      /// Get device identifier
      if (globalDeviceConfigurationEntity.deviceConfiguration != null) {
        globalDeviceConfigurationEntity.deviceConfiguration!.id =
            deviceInfo.identifier;

        log('GetGlobalDeviceConfigurationUsecase: device identifier: ${deviceInfo.identifier}');
        _logService.saveLocalLog(
          exception: 'GetGlobalDeviceConfigurationUsecase',
          stackTrace:
              'device identifier: ${deviceInfo.identifier} at ${DateTime.now()}',
        );
      }

      /// Save Device Configurations
      if (globalDeviceConfigurationEntity.deviceConfiguration != null) {
        await _deviceConfigurationRepository.save(
          configuration: globalDeviceConfigurationEntity.deviceConfiguration!,
        );

        log('GetGlobalDeviceConfigurationUsecase: device configuration saved');
        _logService.saveLocalLog(
          exception: 'GetGlobalDeviceConfigurationUsecase',
          stackTrace:
              'device identifier: ${deviceInfo.identifier} at ${DateTime.now()}',
        );
      }

      /// Save Global Configurations
      if (globalDeviceConfigurationEntity.globalConfigurationEntity != null) {
        await _globalConfigurationRepository.saveEntity(
          globalConfigurationEntity:
              globalDeviceConfigurationEntity.globalConfigurationEntity!,
        );

        log('GetGlobalDeviceConfigurationUsecase: global configuration saved');
        _logService.saveLocalLog(
          exception: 'GetGlobalDeviceConfigurationUsecase',
          stackTrace: 'global configuration saved at ${DateTime.now()}',
        );
      }

      /// Sabe device informatio
      if (globalDeviceConfigurationEntity.device != null) {
        await _deviceRepository.saveEntity(
          device: globalDeviceConfigurationEntity.device!,
        );

        log('GetGlobalDeviceConfigurationUsecase: device information saved');
        _logService.saveLocalLog(
          exception: 'GetGlobalDeviceConfigurationUsecase',
          stackTrace: 'device information saved at ${DateTime.now()}',
        );
      }

      await _initClockUsecase.call();
    } else {
      /// Start clock without configuration
      await _initClockUsecase.call();
    }

    return globalDeviceConfigurationEntity;
  }
}
