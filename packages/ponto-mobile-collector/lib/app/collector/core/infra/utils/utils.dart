// ignore_for_file: unrelated_type_equality_checks

import 'dart:io';

import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_authentication/mobile_authentication_service.dart'
    as auth;
import 'package:path_provider/path_provider.dart';

import '../../../../../ponto_mobile_collector.dart';
import '../../domain/enums/activation_situation_type.dart';
import '../../domain/enums/clocking_event_use_enum.dart';
import '../../domain/enums/clocking_event_use_type.dart';
import '../../domain/enums/operation_mode_type.dart';
import '../../domain/enums/status_device.dart';
import '../../domain/input_model/clocking_event_register_type.dart';
import '../../domain/input_model/journey_time_details_dto.dart';
import 'enum/type_journey_time_enum.dart';

class Utils implements IUtils {
  final int _timeConversion = 60;

  @override
  DateTime lastDayOfWeek(DateTime date) {
    final dayOfWeek = date.weekday;
    final difference = Duration(days: 7 - dayOfWeek);
    return date.add(difference);
  }

  @override
  DateTime firstDayOfWeek(DateTime date) {
    final dayOfWeek = date.weekday;
    final difference = Duration(days: dayOfWeek - 1);
    return date.subtract(difference);
  }

  @override
  DateTime firstDayOfTheMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  @override
  DateTime lastDayOfTheMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0);
  }

  @override
  clock.EmployeeDto convertToEmployeeDto({
    required auth.LoginEmployeeDTO employee,
  }) {
    clock.EmployeeDto dto = clock.EmployeeDto(
      id: employee.id,
      name: employee.name,
      employeeType: employee.employeeType!.value,
      registrationNumber: employee.registrationNumber,
      company: convertToCompanyDto(company: employee.company),
      cpf: employee.cpfNumber,
      mail: employee.mail,
      nfcCode: employee.nfcCode,
      fences: convertToFenceDto(
        fences: employee.fences,
      ),
      arpId: employee.arpId,
      enable: employee.enabled,
      faceRegistered: employee.faceRegistered,
      employeeCode: employee.employeeCode,
      managers: convertToManagerEmployeeDto(managers: employee.managers),
      platformUsers: convertListToPlatformUserEmployeeDto(
        platformUsers: employee.platformUsers,
      ),
      reminders:
          convertListToReminderEmployeeDto(reminders: employee.reminders),
    );
    return dto;
  }

  @override
  clock.CompanyDto convertToCompanyDto({
    required auth.CompanyDto company,
  }) {
    clock.CompanyDto dto = clock.CompanyDto(
      id: company.id,
      name: company.name,
      identifier: company.cnpj,
      timeZone: company.timeZone,
      arpId: company.arpId,
      caepf: company.caepf,
      cnoNumber: company.cnoNumber,
    );

    return dto;
  }

  @override
  List<clock.FenceDto>? convertToFenceDto({
    List<auth.FenceDTO>? fences,
  }) {
    if (fences == null) {
      return null;
    }

    List<clock.FenceDto> fencesDto = [];

    for (auth.FenceDTO fence in fences) {
      clock.FenceDto fenceDto = clock.FenceDto(
        id: fence.id ?? '',
        name: fence.name,
        perimeters: convertToPerimeterDto(
          perimeters: fence.perimeters,
        ),
      );
      fencesDto.add(fenceDto);
    }

    return fencesDto;
  }

  @override
  List<clock.ManagerEmployeeDto>? convertToManagerEmployeeDto({
    List<auth.ManagerEmployeeDTO>? managers,
  }) {
    if (managers == null) {
      return null;
    }

    List<clock.ManagerEmployeeDto> managersDto = [];

    for (auth.ManagerEmployeeDTO manager in managers) {
      clock.ManagerEmployeeDto managerDto = clock.ManagerEmployeeDto(
        id: manager.id ?? '',
        mail: manager.mail,
        platformUsers: convertListToPlatformUserEmployeeDto(
          platformUsers: manager.platformUsers,
        ),
        platformUserName: manager.platformUserName,
        employees:
            convertListToManagerEmployeeDto(employees: manager.employees),
      );
      managersDto.add(managerDto);
    }

    return managersDto;
  }

  @override
  List<clock.PerimeterDto> convertToPerimeterDto({
    List<auth.PerimeterDTO>? perimeters,
  }) {
    if (perimeters == null) {
      return [];
    }

    List<clock.PerimeterDto> perimetersDto = [];
    for (auth.PerimeterDTO perimeter in perimeters) {
      clock.PerimeterDto perimeterDto = clock.PerimeterDto(
        id: perimeter.id ?? '',
        radius: perimeter.radius,
        startPoint: clock.LocationDTO(
          latitude: perimeter.startPoint.latitude,
          longitude: perimeter.startPoint.longitude,
          dateAndTime: perimeter.startPoint.dateAndTime,
        ),
        type: clock.GeometricFormType.build(
          perimeter.type.value,
        ),
      );
      perimetersDto.add(perimeterDto);
    }
    return perimetersDto;
  }

  @override
  List<clock.ReminderDto>? convertListToReminderEmployeeDto({
    List<auth.ReminderDTO>? reminders,
  }) {
    if (reminders == null) {
      return null;
    }

    List<clock.ReminderDto> remindersDto = [];
    for (auth.ReminderDTO reminderDto in reminders) {
      DateFormat inputFormat = DateFormat('HH:mm:ss');

      clock.ReminderDto reminderEmployeeDto = clock.ReminderDto(
        id: reminderDto.id,
        period: inputFormat.parse(reminderDto.period),
        enabled: reminderDto.enabled,
        type: clock.ReminderType.build(reminderDto.type.value),
      );
      remindersDto.add(reminderEmployeeDto);
    }
    return remindersDto;
  }

  @override
  Future<String> createPhotoPath({
    required String employeeId,
    required String photoName,
    bool createDirectory = false,
  }) async {
    Directory directory = Directory(
      '${(await getApplicationDocumentsDirectory()).path}/employee_images/$employeeId',
    );

    if (createDirectory) {
      await directory.create(recursive: true);
    }

    return '${directory.path}/$photoName';
  }

  @override
  Future<Directory> getPhotoDirectory({
    required String employeeId,
  }) async {
    Directory directory = Directory(
      '${(await getApplicationDocumentsDirectory()).path}/employee_images/$employeeId',
    );

    return directory;
  }

  @override
  String formatTime({
    required DateTime dateTime,
    String locale = 'pt',
  }) {
    if (locale == 'en') {
      return '${DateFormat('h:mm').format(dateTime)} ${DateFormat('a').format(dateTime)}';
    }

    return DateFormat('HH:mm').format(dateTime);
  }

  @override
  String formatTimeQuantitative({
    required DateTime dateTime,
    String locale = 'pt',
  }) {
    int hour = dateTime.hour;
    int minute = dateTime.minute;

    if (locale == 'en') {
      return '$hour:${minute.toString().padLeft(2, '0')}';
    } else {
      if (minute == 0) {
        return '${hour}h';
      } else {
        return '${hour}h${minute.toString().padLeft(2, '0')}';
      }
    }
  }

  @override
  String getDatePattern({
    required String localeName,
  }) {
    var datePattern = 'MM/dd/yyyy';

    if (localeName case 'pt' || 'es') {
      datePattern = 'dd/MM/yyyy';
    }

    return datePattern;
  }

  @override
  String getTimePattern({
    required String localeName,
  }) {
    var timePattern = 'hh:mm a';

    if (localeName case 'pt' || 'es') {
      timePattern = 'HH:mm';
    }

    return timePattern;
  }

  @override
  String getDateTimePattern({
    required String localeName,
  }) {
    var datePattern = getDatePattern(localeName: localeName);
    var timePattern = getTimePattern(localeName: localeName);

    return '$datePattern $timePattern';
  }

  @override
  String formatCPF({required String cpf}) {
    final digitsOnly = cpf.replaceAll(RegExp(r'\D+'), '');
    final formattedCPF = StringBuffer();

    for (var i = 0; i < digitsOnly.length; i++) {
      formattedCPF.write(digitsOnly[i]);

      if ((i + 1) % 3 == 0 && i < 8) {
        formattedCPF.write('.');
      } else if ((i + 1) % 3 == 0 && i < 11) {
        formattedCPF.write('-');
      }
    }
    return formattedCPF.toString();
  }

  @override
  String maskCPF({required String cpf}) {
    return '***.${cpf.substring(3, 6)}.${cpf.substring(6, 9)}-**';
  }

  @override
  String formatCNPJ({required String cnpj}) {
    final digitsOnly = cnpj.replaceAll(RegExp(r'\D+'), '');
    final formattedCNPJ = StringBuffer();

    for (var i = 0; i < digitsOnly.length; i++) {
      formattedCNPJ.write(digitsOnly[i]);

      if (i == 1 || i == 4) {
        formattedCNPJ.write('.');
      } else if (i == 7) {
        formattedCNPJ.write('/');
      } else if (i == 11) {
        formattedCNPJ.write('-');
      }
    }

    return formattedCNPJ.toString();
  }

  @override
  DeviceAuthorizationStatusEnum checkDeviceStatus({
    required StatusDevice statusDevice,
    required ActivationSituationType activationSituationType,
  }) {
    if (statusDevice == StatusDevice.pending) {
      return DeviceAuthorizationStatusEnum.deviceAuthorizationIsPending;
    } else if (statusDevice == StatusDevice.rejected) {
      return DeviceAuthorizationStatusEnum.deviceAuthorizationWasRejected;
    } else if (activationSituationType ==
        ActivationSituationType.pending) {
      return DeviceAuthorizationStatusEnum.deviceActivationIsPending;
    } else if (activationSituationType ==
        ActivationSituationType.rejected) {
      return DeviceAuthorizationStatusEnum.deviceActivationWasRejected;
    }

    return DeviceAuthorizationStatusEnum.authorized;
  }

  @override
  String getDeviceStatusMessage(
    BuildContext context,
    DeviceAuthorizationStatusEnum status,
  ) {
    switch (status) {
      case DeviceAuthorizationStatusEnum.deviceActivationIsPending:
        return CollectorLocalizations.of(context).deviceActivationIsPending;
      case DeviceAuthorizationStatusEnum.deviceActivationWasRejected:
        return CollectorLocalizations.of(context).deviceActivationWasRejected;
      case DeviceAuthorizationStatusEnum.deviceAuthorizationIsPending:
        return CollectorLocalizations.of(context).deviceAuthorizationIsPending;
      case DeviceAuthorizationStatusEnum.deviceAuthorizationWasRejected:
        return CollectorLocalizations.of(context)
            .deviceAuthorizationWasRejected;
      default:
        return '';
    }
  }

  @override
  OperationModeType getOperationModeEnum({
    required ClockingEventRegisterType registerType,
  }) {
    switch (registerType.runtimeType) {
      case const (ClockingEventRegisterTypeSession):
        return OperationModeType.single;
      case const (ClockingEventRegisterTypeDriver):
        return OperationModeType.driver;
      case const (ClockingEventRegisterTypeFacialRecognition):
        return OperationModeType.faceRecognition;
      case const (ClockingEventRegisterTypeEmailPassword):
        return OperationModeType.multi;
      case const (ClockingEventRegisterTypeNFC):
        return OperationModeType.nfc;
      case const (ClockingEventRegisterTypeQRCode):
        return OperationModeType.qrCode;
      default:
        return OperationModeType.multi;
    }
  }

  @override
  String getTenantFromUsername({required String username}) {
    int indexOf = username.indexOf('@');
    return indexOf != -1 ? username.substring(indexOf + 1) : '';
  }

  @override
  List<clock.PlatformUserEmployeeDto>? convertListToPlatformUserEmployeeDto({
    List<auth.PlatformUserEmployeeDTO>? platformUsers,
  }) {
    if (platformUsers == null) {
      return null;
    }
    List<clock.PlatformUserEmployeeDto> platformUsersDto = [];
    for (auth.PlatformUserEmployeeDTO platformUser in platformUsers) {
      clock.PlatformUserEmployeeDto platformUserEmployeeDto =
          clock.PlatformUserEmployeeDto(
        id: platformUser.id ?? '',
        username: platformUser.username,
      );
      platformUsersDto.add(platformUserEmployeeDto);
    }
    return platformUsersDto;
  }

  @override
  List<clock.EmployeeDto>? convertListToManagerEmployeeDto({
    List<auth.LoginEmployeeDTO>? employees,
  }) {
    if (employees == null) {
      return null;
    }
    List<clock.EmployeeDto> employeesDto = [];
    for (auth.LoginEmployeeDTO employee in employees) {
      clock.EmployeeDto platformUserEmployeeDto =
          convertToEmployeeDto(employee: employee);
      employeesDto.add(platformUserEmployeeDto);
    }
    return employeesDto;
  }

  @override
  String getDateMaskFromLocale(String languageCode) {
    final dateFormat = DateFormat.yMd(languageCode);
    var pattern = dateFormat.pattern;

    const yearPattern = '0000';
    const monthPattern = '00';
    const dayPattern = '00';

    if (pattern != null) {
      pattern = pattern.replaceFirst('y', yearPattern);
      pattern = pattern.replaceFirst('M', monthPattern);
      pattern = pattern.replaceFirst('d', dayPattern);
      pattern = pattern.replaceAll(RegExp(r'[a-zA-Z]'), '');

      return pattern;
    } else {
      return '$dayPattern/$monthPattern/$yearPattern';
    }
  }

  @override
  DateTime getDateTimeFromHlb(int hlbTime) {
    return DateTime.fromMillisecondsSinceEpoch(hlbTime, isUtc: true);
  }

  @override
  bool isNullOrWhitespace({String? str}) {
    return str == null || str.trim().isEmpty;
  }

  @override
  String truncateString(String input, int maxLength) {
    return (input.length > maxLength) ? input.substring(0, maxLength) : input;
  }

  @override
  bool isEven(int index) {
    return index % 2 == 0;
  }

  @override
  DateTime convertStringTimeEventToDateTime(String timeEvent) {
    List<String> parts = timeEvent.split(':');
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);
    int second = parts.length > 2 ? int.parse(parts[2]) : 0;

    DateTime dateTime = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      hour,
      minute,
      second,
    );

    return dateTime;
  }

  @override
  int calculateDifferenceInMinutes(
    String timeEventAfter,
    String timeEventBefore,
  ) {
    DateTime dateTimeAfter = convertStringTimeEventToDateTime(timeEventAfter);
    DateTime dateTimeBefore = convertStringTimeEventToDateTime(timeEventBefore);

    return dateTimeAfter.difference(dateTimeBefore).inMinutes;
  }

  @override
  int calculateDifferenceInSeconds(
    String timeEventAfter,
    String timeEventBefore,
  ) {
    DateTime dateTimeAfter = convertStringTimeEventToDateTime(timeEventAfter);
    DateTime dateTimeBefore = convertStringTimeEventToDateTime(timeEventBefore);

    return dateTimeAfter.difference(dateTimeBefore).inSeconds;
  }

  @override
  int convertDateTimeToMinutes(DateTime dateTime) {
    Duration duration = Duration(
      hours: dateTime.hour,
      minutes: dateTime.minute,
    );

    return duration.inMinutes;
  }

  @override
  int convertDateTimeToSeconds(DateTime dateTime) {
    Duration duration = Duration(
      hours: dateTime.hour,
      minutes: dateTime.minute,
      seconds: dateTime.second,
    );

    return duration.inSeconds;
  }

  @override
  DriversWorkStatusEnum getDriversWorkStatusByClockingEventUse(
    ClockingEventUseEnum clockingEventUse,
  ) {
    switch (clockingEventUse) {
      case ClockingEventUseEnum.clockingEvent ||
            ClockingEventUseEnum.paidBreak:
        return DriversWorkStatusEnum.working;

      case ClockingEventUseEnum.driving:
        return DriversWorkStatusEnum.driving;

      case ClockingEventUseEnum.mandatoryBreak:
        return DriversWorkStatusEnum.mandatoryBreak;

      case ClockingEventUseEnum.waiting:
        return DriversWorkStatusEnum.waiting;
    }
  }

  @override
  ClockingEventUseEnum getClockingEventUseByDriversWorkStatus(
    DriversWorkStatusEnum driversWorkStatus,
  ) {
    switch (driversWorkStatus) {
      case DriversWorkStatusEnum.notStarted ||
            DriversWorkStatusEnum.working ||
            DriversWorkStatusEnum.foodTime:
        return ClockingEventUseEnum.clockingEvent;

      case DriversWorkStatusEnum.driving:
        return ClockingEventUseEnum.driving;

      case DriversWorkStatusEnum.mandatoryBreak:
        return ClockingEventUseEnum.mandatoryBreak;

      case DriversWorkStatusEnum.waiting:
        return ClockingEventUseEnum.waiting;

      case DriversWorkStatusEnum.paidBreak:
        return ClockingEventUseEnum.paidBreak;
    }
  }

  @override
  JourneyTimeDetailsDto? getFirstEventByType({
    required TypeJourneyTimeEnum type,
    required List<JourneyTimeDetailsDto> journeyTimeDetailsList,
  }) {
    return journeyTimeDetailsList.where((e) => e.use == type).firstOrNull;
  }

  @override
  ClockingEventUseEnum toClockingEventUseEnum(
    ClockingEventUseType clockingEventUseType,
  ) {
    switch (clockingEventUseType.value) {
      case 'CLOCKING_EVENT':
        return ClockingEventUseEnum.clockingEvent;
      case 'PAID_BREAK':
        return ClockingEventUseEnum.paidBreak;
      case 'MANDATORY_BREAK':
        return ClockingEventUseEnum.mandatoryBreak;
      case 'DRIVING':
        return ClockingEventUseEnum.driving;
      case 'WAITING':
        return ClockingEventUseEnum.waiting;
      default:
        throw Exception('ClockingEventUse type not found');
    }
  }

  @override
  ClockingEventUseType toClockingEventUseType(
    ClockingEventUseEnum clockingEventUseEnum,
  ) {
    switch (clockingEventUseEnum.value) {
      case 'Clocking Event':
        return ClockingEventUseType.clockingEvent;
      case 'Paid Break':
        return ClockingEventUseType.paidBreak;
      case 'Mandatory Break':
        return ClockingEventUseType.mandatoryBreak;
      case 'Driving':
        return ClockingEventUseType.driving;
      case 'Waiting':
        return ClockingEventUseType.waiting;
      default:
        throw Exception('ClockingEventUse type not found');
    }
  }

  @override
  String getHourMinuteSecondFromDuration(
    Duration duration,
  ) {
    String twoDigits(int num) => num.toString().padLeft(2, '0');

    final (
      hour,
      minute,
      second,
    ) = (
      twoDigits(duration.inHours),
      twoDigits(duration.inMinutes.remainder(_timeConversion)),
      twoDigits(duration.inSeconds.remainder(_timeConversion)),
    );

    return '$hour:$minute:$second';
  }

  @override
  bool isTablet(
    BuildContext context,
  ) {
    final shortestSide = MediaQuery.of(context).size.shortestSide;
    return shortestSide >= 450;
  }
}
