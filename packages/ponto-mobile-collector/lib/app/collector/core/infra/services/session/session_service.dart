import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;

import '../../../../../../ponto_mobile_collector.dart';
import '../../../domain/input_model/activation_dto.dart';
import '../../../domain/input_model/configuration_dto.dart';
import '../../../domain/input_model/employee_dto.dart';
import '../../utils/enum/execution_mode_enum.dart';

class SessionService implements ISessionService {
  static SessionService? _instance;

  static String? _companyId;
  static ConfigurationDto? _loginConfiguration;
  static ActivationDto? _loginActivationDTO;
  static EmployeeDto? _employee;
  static String? _username;

  late IUtils _utils;
  late ISharedPreferencesService _sharedPreferencesService;

  static SessionService build({
    required ISharedPreferencesService sharedPreferencesService,
    IUtils? utils,
  }) {
    _instance = SessionService._(
      sharedPreferencesService: sharedPreferencesService,
      utils: utils,
    );

    return _instance!;
  }

  SessionService._({
    required ISharedPreferencesService sharedPreferencesService,
    IUtils? utils,
  }) {
    _utils = utils ?? Utils();
    _sharedPreferencesService = sharedPreferencesService;
  }

  static SessionService get instance {
    return _instance!;
  }

  @override
  void setLogedUser({
    EmployeeDto? employeeDto,
    ActivationDto? activationDto,
    required ConfigurationDto configurationDto,
    String? username,
  }) {
    _employee = employeeDto;
    _loginConfiguration = configurationDto;
    _loginActivationDTO = activationDto;
    _username = username;

    if (employeeDto != null) {
      _sharedPreferencesService.setSessionEmployeeId(
        employeeId: employeeDto.id,
      );
      _companyId = employeeDto.company.id;
    }
  }

  @override
  ConfigurationDto getConfiguration() {
    return _loginConfiguration!;
  }

  @override
  EmployeeDto getEmployee() {
    return _employee!;
  }

  @override
  String getEmployeeId() {
    return _employee!.id;
  }

  @override
  clock.OperationModeEnum getOperationMode() {
    return clock.OperationModeEnum.build(
      _loginConfiguration!.operationMode.value,
    );
  }

  @override
  ExecutionModeEnum getExecutionMode() {
    try {
      clock.OperationModeEnum operationModeEnum = clock.OperationModeEnum.build(
        _loginConfiguration!.operationMode.value,
      );

      switch (operationModeEnum) {
        case clock.OperationModeEnum.single:
          return ExecutionModeEnum.individual;
        case clock.OperationModeEnum.driver:
          return ExecutionModeEnum.driver;
        case clock.OperationModeEnum.multi:
          return ExecutionModeEnum.multiple;
        default:
          return ExecutionModeEnum.multiple;
      }
    } catch (e) {
      return ExecutionModeEnum.multiple;
    }
  }

  @override
  DeviceAuthorizationStatusEnum checkDeviceStatus() {
    if (hasEmployee()) {
      return _utils.checkDeviceStatus(
        statusDevice: _loginActivationDTO!.deviceSituation,
        activationSituationType: _loginActivationDTO!.employeeSituation,
      );
    } else {
      return DeviceAuthorizationStatusEnum.authorized;
    }
  }

  @override
  Duration? getTimeZoneOffset() {
    if (hasEmployee()) {
      if (_loginConfiguration!.allowChangeTime != null &&
          _loginConfiguration!.allowChangeTime!) {
        return null;
      }

      String? timeZone = _loginConfiguration!.timezone.isNotEmpty
          ? _loginConfiguration!.timezone
          : _employee!.company.timeZone;

      return Duration(
        minutes:
            clock.TimeZonePontoMobile.build(timeZone).timZoneOffsetInMinutes,
      );
    }

    return null;
  }

  @override
  bool hasEmployee() {
    return _employee != null;
  }

  @override
  String getCompanyId() {
    return _companyId!;
  }

  @override
  Future<void> clean() async {
    await _sharedPreferencesService.setSessionEmployeeId(
      employeeId: null,
    );

    if (_companyId != null) {
      await _sharedPreferencesService.setFacialRecognitionAuthentication(
        companyId: _companyId!,
        value: false,
      );
    }

    _companyId = null;
    _loginConfiguration = null;
    _loginActivationDTO = null;
    _employee = null;
  }

  @override
  void setFaceRegistered({required String id}) {
    if (_employee != null) {
      _employee?.faceRegistered = id;
    }
  }

  @override
  String? getUserName() {
    return _username;
  }
}
