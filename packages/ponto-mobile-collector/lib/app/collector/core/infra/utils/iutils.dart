import 'dart:io';

import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
import 'package:flutter/material.dart';
import 'package:mobile_authentication/mobile_authentication_service.dart'
    as auth;

import '../../../../../ponto_mobile_collector.dart';
import '../../domain/enums/activation_situation_type.dart';
import '../../domain/enums/clocking_event_use_enum.dart';
import '../../domain/enums/clocking_event_use_type.dart';
import '../../domain/enums/operation_mode_type.dart';
import '../../domain/enums/status_device.dart';
import '../../domain/input_model/clocking_event_register_type.dart';
import '../../domain/input_model/journey_time_details_dto.dart';
import 'enum/type_journey_time_enum.dart';

abstract class IUtils {
  DateTime lastDayOfWeek(DateTime date);

  DateTime firstDayOfWeek(DateTime date);

  DateTime firstDayOfTheMonth(DateTime date);

  DateTime lastDayOfTheMonth(DateTime date);

  clock.EmployeeDto convertToEmployeeDto({
    required auth.LoginEmployeeDTO employee,
  });

  clock.CompanyDto convertToCompanyDto({
    required auth.CompanyDto company,
  });

  List<clock.FenceDto>? convertToFenceDto({
    List<auth.FenceDTO>? fences,
  });

  List<clock.ManagerEmployeeDto>? convertToManagerEmployeeDto({
    List<auth.ManagerEmployeeDTO>? managers,
  });

  List<clock.EmployeeDto>? convertListToManagerEmployeeDto({
    List<auth.LoginEmployeeDTO>? employees,
  });

  List<clock.PlatformUserEmployeeDto>? convertListToPlatformUserEmployeeDto({
    List<auth.PlatformUserEmployeeDTO>? platformUsers,
  });

  List<clock.PerimeterDto> convertToPerimeterDto({
    List<auth.PerimeterDTO>? perimeters,
  });

  List<clock.ReminderDto>? convertListToReminderEmployeeDto({
    List<auth.ReminderDTO>? reminders,
  });

  Future<Directory> getPhotoDirectory({
    required String employeeId,
  });

  Future<String> createPhotoPath({
    required String employeeId,
    required String photoName,
    bool createDirectory = false,
  });

  String formatTime({
    required DateTime dateTime,
    String locale = 'pt',
  });

  String formatTimeQuantitative({
    required DateTime dateTime,
    String locale = 'pt',
  });

  String getDatePattern({
    required String localeName,
  });

  String getTimePattern({
    required String localeName,
  });

  String getDateTimePattern({
    required String localeName,
  });

  String formatCPF({required String cpf});

  /// Receive cpf in format '99999999999', return in format '***.999.999-**'
  String maskCPF({required String cpf});

  String formatCNPJ({required String cnpj});

  DeviceAuthorizationStatusEnum checkDeviceStatus({
    required StatusDevice statusDevice,
    required ActivationSituationType activationSituationType,
  });

  String getDeviceStatusMessage(
    BuildContext context,
    DeviceAuthorizationStatusEnum status,
  );

  OperationModeType getOperationModeEnum({
    required ClockingEventRegisterType registerType,
  });

  String getTenantFromUsername({required String username});

  String getDateMaskFromLocale(String languageCode);

  DateTime getDateTimeFromHlb(int hlbTime);

  bool isEven(int index);

  DateTime convertStringTimeEventToDateTime(String timeEvent);

  int calculateDifferenceInMinutes(
    String timeEventAfter,
    String timeEventBefore,
  );

  int calculateDifferenceInSeconds(
    String timeEventAfter,
    String timeEventBefore,
  );

  int convertDateTimeToMinutes(DateTime dateTime);

  int convertDateTimeToSeconds(DateTime dateTime);

  DriversWorkStatusEnum getDriversWorkStatusByClockingEventUse(
    ClockingEventUseEnum clockingEventUse,
  );

  ClockingEventUseEnum getClockingEventUseByDriversWorkStatus(
    DriversWorkStatusEnum driversWorkStatus,
  );

  JourneyTimeDetailsDto? getFirstEventByType({
    required TypeJourneyTimeEnum type,
    required List<JourneyTimeDetailsDto> journeyTimeDetailsList,
  });

  bool isNullOrWhitespace({String? str});

  String truncateString(String input, int maxLength);

  ClockingEventUseEnum toClockingEventUseEnum(
    ClockingEventUseType clockingEventUseType,
  );

  ClockingEventUseType toClockingEventUseType(
    ClockingEventUseEnum clockingEventUseEnum,
  );

  String getHourMinuteSecondFromDuration(
    Duration duration,
  );

  bool isTablet(
    BuildContext context,
  );
}
