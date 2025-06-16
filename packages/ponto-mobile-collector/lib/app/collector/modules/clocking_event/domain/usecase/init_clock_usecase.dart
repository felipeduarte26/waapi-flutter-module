import 'dart:developer';

import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;

import '../../../../../../ponto_mobile_collector.dart';
import '../../../../core/domain/entities/configuration.dart';
import '../../../../core/domain/entities/device_configuration.dart';
import '../../../../core/domain/input_model/configuration_dto.dart';
import '../../../../core/domain/input_model/device_info_dto.dart';
import '../../../../core/domain/input_model/employee_dto.dart';
import '../../../../core/domain/usecases/get_access_token_usecase.dart';
import '../../../../core/domain/usecases/get_execution_mode_usecase.dart';
import '../../../../core/external/mappers/configuration_mapper.dart';
import '../../../../core/infra/utils/enum/execution_mode_enum.dart';

/// Initializes the watch according to the usage mode and current device configuration.
abstract class IInitClockUsecase {
  Future<void> call({DateTime? initialDateTimeUTC});
}

class InitClockUsecase implements IInitClockUsecase {
  final clock.IInternalClockService _internalClockService;
  final ISessionService _sessionService;
  final GetAccessTokenUsecase _getAccessTokenUsecase;
  final GetExecutionModeUsecase _getExecutionModeUsecase;
  final DeviceConfigurationRepository _deviceConfigurationRepository;
  final IPlatformService _platformService;
  final ConfigurationRepository _configurationRepository;

  const InitClockUsecase({
    required clock.IInternalClockService internalClockService,
    required ISessionService sessionService,
    required GetAccessTokenUsecase getAccessTokenUsecase,
    required GetExecutionModeUsecase getExecutionModeUsecase,
    required DeviceConfigurationRepository deviceConfigurationRepository,
    required IPlatformService platformService,
    required ConfigurationRepository configurationRepository,
  })  : _internalClockService = internalClockService,
        _sessionService = sessionService,
        _getAccessTokenUsecase = getAccessTokenUsecase,
        _getExecutionModeUsecase = getExecutionModeUsecase,
        _deviceConfigurationRepository = deviceConfigurationRepository,
        _platformService = platformService,
        _configurationRepository = configurationRepository;

  @override
  Future<void> call({DateTime? initialDateTimeUTC}) async {
    ExecutionModeEnum executionModeEnum = await _getExecutionModeUsecase.call();
    String? acessToken;
    TokenType tokenType =
        executionModeEnum.isIndividualOrDriver() ? TokenType.user : TokenType.key;
    acessToken = await _getAccessTokenUsecase.call(tokenType: tokenType);

    Duration? timeZoneOffset;
    bool requestServerDateTime = acessToken != null && acessToken.isNotEmpty;

    if (executionModeEnum.isIndividualOrDriver()) {
      EmployeeDto employee = _sessionService.getEmployee();

      Configuration? configEntity = 
          await _configurationRepository.findByEmployeeId(employeeId: employee.id);
      
      ConfigurationDto? configurationRepository = ConfigurationMapper.fromEntityToDtoCollector(configEntity);
      
      if (configurationRepository != null) {
        requestServerDateTime = configurationRepository.allowChangeTime == true ? false : true;
      }

      timeZoneOffset = _sessionService.getTimeZoneOffset();
    } else {
      DeviceInfo deviceInfo = await _platformService.getDeviceInfoDto();
      DeviceConfiguration? deviceConfiguration =
          await _deviceConfigurationRepository.findByIdentifier(
        identifier: deviceInfo.identifier,
      );

      if (deviceConfiguration != null) {
        if (deviceConfiguration.allowChangeTime) {
          timeZoneOffset = null;
          initialDateTimeUTC = null;
          requestServerDateTime = false;
        } else {
          if (deviceConfiguration.timeZone.isNotEmpty) {
            try {
              timeZoneOffset = Duration(
                minutes: clock.TimeZonePontoMobile.build(
                  deviceConfiguration.timeZone,
                ).timZoneOffsetInMinutes,
              );
            } catch (e) {
              log('InitClockUsecase: $e');
            }
          }
        }
      }
    }

    return await _internalClockService.initClock(
      timeZoneOffset: timeZoneOffset,
      requestServerDateTime: requestServerDateTime,
      initialDateTimeUTC: initialDateTimeUTC,
    );
  }
}
