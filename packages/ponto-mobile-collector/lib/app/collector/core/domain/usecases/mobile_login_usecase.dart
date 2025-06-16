import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';
import 'package:uuid/uuid.dart';

import '../../../../../ponto_mobile_collector.dart';
import '../../external/mappers/activation_mapper.dart';
import '../../external/mappers/clocking_event_use_mapper.dart';
import '../../external/mappers/configuration_mapper.dart';
import '../../external/mappers/employee_mapper.dart';
import '../../external/mappers/platform_user_mapper.dart';
import '../../external/mappers/reminder_mapper.dart';
import '../entities/activation.dart';
import '../entities/clocking_event_use.dart';
import '../entities/configuration.dart';
import '../entities/mobile_login_usecase_return.dart';
import '../entities/platform_user.dart';
import '../entities/reminder.dart';
import '../enums/network_status.dart';
import '../input_model/activation_dto.dart';
import '../input_model/clocking_event_use_dto.dart';
import '../input_model/configuration_dto.dart';
import '../input_model/employee_dto.dart';
import '../input_model/manager_employee_dto.dart';
import '../input_model/platform_user_dto.dart';
import '../input_model/reminder_dto.dart';
import '../repositories/database/clocking_event_use_repository.dart';
import '../repositories/database/iplatform_user_repository.dart';
import '../repositories/database/ireminder_repository.dart';
import '../repositories/mobile_login_repository.dart';
import 'load_user_permissions_usecase.dart';

abstract class MobileLoginUsecase {
  Future<MobileLoginUsecaseReturn?> call(
    EnvironmentEnum environment,
    Token token,
  );
}

class MobileLoginUsecaseImpl implements MobileLoginUsecase {
  final IPlatformService _platformService;
  final IEmployeeRepository _employeeRepository;
  final IConfigurationRepository _configurationRepository;
  final IActivationRepository _activationRepository;
  final SharedPreferencesService _sharedPreferencesService;
  final IManagerPlatformUserRepository _managerPlatformUserRepository;
  final IPlatformUserRepository _platformUserRepository;
  final ISessionService _sessionService;
  final LoadUserPermissionsUsecase _loadUserPermissionsUsecase;
  final IReminderRepository _reminderRepository;
  final ClockingEventUseRepository _clockingEventUseRepository;
  final MobileLoginRepository _mobileLoginRepository;

  const MobileLoginUsecaseImpl({
    required IPlatformService platformService,
    required IEmployeeRepository employeeRepository,
    required IConfigurationRepository configurationRepository,
    required IActivationRepository activationRepository,
    required SharedPreferencesService sharedPreferencesService,
    required IManagerPlatformUserRepository managerPlatformUserRepository,
    required IPlatformUserRepository platformUserRepository,
    required ISessionService sessionService,
    required LoadUserPermissionsUsecase loadUserPermissionsUsecase,
    required ClockingEventUseRepository clockingEventUseRepository,
    required IReminderRepository reminderRepository,
    required MobileLoginRepository mobileLoginRepository,
  })  : _platformService = platformService,
        _employeeRepository = employeeRepository,
        _configurationRepository = configurationRepository,
        _activationRepository = activationRepository,
        _sharedPreferencesService = sharedPreferencesService,
        _managerPlatformUserRepository = managerPlatformUserRepository,
        _platformUserRepository = platformUserRepository,
        _sessionService = sessionService,
        _loadUserPermissionsUsecase = loadUserPermissionsUsecase,
        _clockingEventUseRepository = clockingEventUseRepository,
        _reminderRepository = reminderRepository,
        _mobileLoginRepository = mobileLoginRepository;

  @override
  Future<MobileLoginUsecaseReturn?> call(
    EnvironmentEnum environment,
    Token token,
  ) async {
    MobileLoginUsecaseReturn? mobileLoginUseReturn = MobileLoginUsecaseReturn();
    mobileLoginUseReturn.noInternetConnection = true;
    mobileLoginUseReturn.noUsername = true;
    if (token.username != null) {
      mobileLoginUseReturn.noUsername = false;
      bool hasConnection = await _platformService.connectivityStatus() ==
          NetworkStatusEnum.active;

      if (hasConnection) {
        mobileLoginUseReturn.noInternetConnection = false;

        mobileLoginUseReturn = await _mobileLoginRepository.call(environment);

        if (mobileLoginUseReturn != null) {
          if (mobileLoginUseReturn.configurationLocal != null) {
            _sessionService.setLogedUser(
              configurationDto: mobileLoginUseReturn.configurationLocal!,
              employeeDto: mobileLoginUseReturn.employeeLocal,
              activationDto: mobileLoginUseReturn.activationLocal,
              username: token.username,
            );
          }

          await _load(
            mobileLoginUseReturn: mobileLoginUseReturn,
            username: token.username!,
          );
          mobileLoginUseReturn.success = true;
        }
      } else {
        mobileLoginUseReturn.noInternetConnection = true;
      }
    }

    return mobileLoginUseReturn;
  }

  Future<void> _load({
    required MobileLoginUsecaseReturn mobileLoginUseReturn,
    required String username,
  }) async {
    ConfigurationDto? configuration =
        mobileLoginUseReturn.configurationLocal;
    EmployeeDto? employee = mobileLoginUseReturn.employeeLocal;
    ActivationDto? activation = mobileLoginUseReturn.activationLocal;

    /// Save Employee in local database.
    if (employee != null) {
      Employee? employeeEntity =
          EmployeeMapper.fromDtoToEntityCollector(employee);
      if (employeeEntity != null) {
        await _employeeRepository.save(employee: employeeEntity);
      }

      await _savePlatformUserManager(
        employee: employee,
        managerId: configuration!.managerId,
      );

      _sharedPreferencesService.setSessionEmployeeId(employeeId: employee.id);
      _sharedPreferencesService.setSessionPlatformUsername(
        platformUserName: username,
      );

      await _loadUserPermissionsUsecase.call(username, TokenType.user);
    }

    /// Save Activation in local database.
    if (activation != null && employee != null) {
      Activation? activationEntity =
          ActivationMapper.fromDtoToEntityCollector(activation);

      await _activationRepository.save(
        activation: activationEntity,
        employeeId: employee.id,
      );
    }

    String? employeeId;

    if (employee == null) {
      employeeId =
          await _configurationRepository.findIdByUsername(username: username);
      employeeId = employeeId ?? const Uuid().v4();
    } else {
      employeeId = employee.id;
    }

    /// Save Configuration in local database.
    if (configuration != null) {
      Configuration? configurationEntity =
          ConfigurationMapper.fromDtoToEntityCollector(configuration);

      await _configurationRepository.save(
        config: configurationEntity,
        employeeId: employeeId,
        username: username,
      );
      await _sharedPreferencesService.setUserLoggedIsManager(
        value: configuration.isManager ?? false,
      );
      await _sharedPreferencesService.setSessionPlatformUsername(
        platformUserName: username,
      );

      if (configuration.clockingEventUses?.isNotEmpty ?? false) {
        await _clockingEventUseRepository.deleteByEmployeeId(
          employeeId: employeeId,
        );
        for (ClockingEventUseDto event in configuration.clockingEventUses!) {
          ClockingEventUse? clockingEventUseEntity =
              ClockingEventUseMapper.fromDtoToEntityCollector(event);
          _clockingEventUseRepository.save(
            clocking: clockingEventUseEntity!,
            employeeId: employeeId,
          );
        }
      }
    }

    if (employee != null) {
      await _reminderRepository.deleteByEmployeeId(employeeId: employeeId);
      for (ReminderDto reminder
          in mobileLoginUseReturn.employeeLocal?.reminders ?? []) {
        reminder.id = employeeId;
        Reminder? reminderEntity = ReminderMapper.fromDtoToEntityCollector(reminder);
        if (reminderEntity != null) {
          await _reminderRepository.save(reminder: reminderEntity);
        }
      }
    }
  }

  Future<void> _savePlatformUserManager({
    required EmployeeDto employee,
    required String? managerId,
  }) async {
    if (managerId != null && employee.platformUsers != null) {
      for (PlatformUserDto platformUser
          in employee.platformUsers!) {
        await _managerPlatformUserRepository.save(
          managerId: managerId,
          platformUserId: platformUser.id!,
        );
      }
    }
    if (employee.managers != null) {
      for (ManagerEmployeeDto manager in employee.managers!) {
        if (manager.platformUsers != null) {
          for (PlatformUserDto platformUser in manager.platformUsers!) {
            await _managerPlatformUserRepository.save(
              managerId: manager.id!,
              platformUserId: platformUser.id!,
            );
            PlatformUser? platformUserEntity =
                PlatformUserMapper.fromDtoToEntityCollector(platformUser);
            if (platformUserEntity != null) {
              await _platformUserRepository.save(
                platformUser: platformUserEntity,
              );
            }
          }
        }
      }
    }
  }
}
