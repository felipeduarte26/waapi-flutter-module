import 'dart:developer';

import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart' as clock;
import 'package:intl/intl.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';
import 'package:uuid/uuid.dart';

import '../../../modules/clocking_event/domain/usecase/get_clock_time_usecase.dart';
import '../../infra/utils/enum/execution_mode_enum.dart';
import '../../infra/utils/iutils.dart';
import '../entities/crash_log.dart';
import '../enums/token_type.dart';
import '../input_model/device_info_dto.dart';
import '../input_model/employee_dto.dart';
import '../services/logs/send_logs_service.dart.dart';
import '../services/platform/iplatform_service.dart';
import '../services/session/isession_service.dart';
import 'get_access_token_usecase.dart';
import 'get_execution_mode_usecase.dart';
import 'get_token_usecase.dart';

abstract class SendLogsUsecase {
  Future<void> call({required String exception, String? stackTrace, clock.ImportClockingEventDto? importClockingEvent, DateTime? dateTimeOnDevice});
}

class SendLogsUsecaseImpl implements SendLogsUsecase {
  final IPlatformService _platformService;
  final ISessionService _sessionService;
  final GetTokenUsecase _getTokenUsecase;
  final SendLogsService _sendLogsService;
  final IUtils _utils;
  final GetExecutionModeUsecase _getExecutionModeUsecase;
  final GetAccessTokenUsecase _getAccessTokenUsecase;
  final GetClockDateTimeUsecase _getClockDateTimeUsecase;

  SendLogsUsecaseImpl({
    required IPlatformService platformService,
    required ISessionService sessionService,
    required GetTokenUsecase getTokenUsecase,
    required SendLogsService sendLogsService,
    required IUtils utils,
    required GetExecutionModeUsecase getExecutionModeUsecase,
    required GetAccessTokenUsecase getAccessTokenUsecase,
    required GetClockDateTimeUsecase getClockDateTimeUsecase,
  })  : _platformService = platformService,
        _sessionService = sessionService,
        _getTokenUsecase = getTokenUsecase,
        _sendLogsService = sendLogsService,
        _utils = utils,
        _getExecutionModeUsecase = getExecutionModeUsecase,
        _getAccessTokenUsecase = getAccessTokenUsecase,
        _getClockDateTimeUsecase = getClockDateTimeUsecase;

  @override
  Future<void> call({
    required String exception,
    String? stackTrace,
    clock.ImportClockingEventDto? importClockingEvent,
    DateTime? dateTimeOnDevice,
  }) async {
    try {
      DeviceInfo deviceInfo = await _platformService.getDeviceInfoDto();

      Token? userToken =
          (await _getTokenUsecase.call(tokenType: TokenType.user));
      userToken ??= await _getTokenUsecase.call(tokenType: TokenType.key);

      EmployeeDto? employee;
      ExecutionModeEnum operationMode = await _getExecutionModeUsecase.call();

      if (_sessionService.hasEmployee()) {
        employee = _sessionService.getEmployee();
      }
      String? accessKeyToken = await _getAccessTokenUsecase.call();

      Map<String, dynamic> exceptionAndStack = {
        'key': accessKeyToken,
        'operationMode': operationMode.name,
        'exception': exception.toString(),
        'stackTrace': _createStackTrace(stackTrace, importClockingEvent, dateTimeOnDevice),
      };

      String dateTime =
          DateFormat("yyyy-MM-ddTHH:mm:ss'Z'").format(DateTime.now());

      if (!_utils.isNullOrWhitespace(str: deviceInfo.identifier)) {
        CrashLog crashLog = CrashLog(
          id: const Uuid().v4(),
          employeeExternalId: employee?.arpId,
          employeeId: employee?.id,
          userPlatform: userToken?.username ?? employee?.name,
          deviceId: deviceInfo.identifier,
          createdAt: dateTime,
          log: exceptionAndStack.toString(),
        );
        _sendLogsService.sendLog(crashLog: crashLog);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  String _createStackTrace(String? stackTrace, clock.ImportClockingEventDto? importClockingEvent, DateTime? dateTimeOnDevice) {
    DateTime timeOnServer = _getClockDateTimeUsecase.call();
    StringBuffer sbStackTrace = StringBuffer();

    sbStackTrace.write(stackTrace != null ? stackTrace.toString() : '');
    sbStackTrace.write((importClockingEvent != null ? _addClockingEventOnLog(importClockingEvent: importClockingEvent) : ''));
    sbStackTrace.write(' at ${timeOnServer}, timezone ${timeOnServer.timeZoneName} (on server).');
    sbStackTrace.write((dateTimeOnDevice != null ? ' At ${dateTimeOnDevice}, timezone ${dateTimeOnDevice.timeZoneName} (on device).' : ''));

    return sbStackTrace.toString();
  }

  String _addClockingEventOnLog({
    required clock.ImportClockingEventDto importClockingEvent,
  }) {
    StringBuffer clockingInfo = StringBuffer();
    clockingInfo.write(' ClockingEvent: ${importClockingEvent.clockingEventId}');
    clockingInfo.write(', date: ${importClockingEvent.dateEvent}');
    clockingInfo.write(', time: ${importClockingEvent.timeEvent}');
    clockingInfo.write(', timezone: ${importClockingEvent.timeZone}');

    return clockingInfo.toString();
  }
}
