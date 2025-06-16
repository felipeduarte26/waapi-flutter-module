
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_authentication/mobile_authentication_service.dart'
    as auth;
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/activation_situation_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/clocking_event_use_enum.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/clocking_event_use_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/operation_mode_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/status_device.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/clocking_event_register_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/journey_time_details_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/type_journey_time_enum.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_design_system/senior_design_system.dart';

import '../../mocks/login_employee_dto_mock.dart';
import '../../mocks/manager_employee_dto_mock.dart';
import '../../mocks/platform_user_employee_dto_mock.dart';
import '../../mocks/reminder_dto_mock.dart';

void main() {
  Widget getWidget(String locale, Widget widget) {
    return MaterialApp(
      home: Localizations(
        delegates: CollectorLocalizations.localizationsDelegates,
        locale: Locale(locale),
        child: SeniorDesignSystem(
          theme: SENIOR_LIGHT_THEME,
          child: widget,
        ),
      ),
    );
  }

  final company = auth.CompanyDto(
    cnpj: 'cnpj',
    dataOrigin: auth.DataOriginType.manual,
    id: 'id',
    name: 'name',
    timeZone: 'timeZone',
    arpId: 'arpId',
    caepf: 'caepf',
    cnoNumber: 'cnoNumber',
  );

  final employee = auth.LoginEmployeeDTO(
    cpfNumber: 'cpfNumber',
    id: 'id',
    mail: 'mail',
    name: 'name',
    registrationNumber: 'registrationNumber',
    company: company,
    employeeType: auth.EmployeeType.companyEmployee,
    arpId: 'arpId',
  );

  test(
    'Utils getTenantFromUsername test.',
    () {
      final IUtils utils = Utils();

      expect(
        utils.getTenantFromUsername(username: 'user@tenant.com.br'),
        'tenant.com.br',
      );
    },
  );

  test(
    'Utils lastDayOfWeek test.',
    () {
      final IUtils utils = Utils();

      final date = DateTime.parse('2023-05-17 10:30');
      final lastDay = utils.lastDayOfWeek(date);

      expect(lastDay.year, 2023);
      expect(lastDay.month, 5);
      expect(lastDay.day, 21);
    },
  );

  test(
    'Utils firstDayOfWeek test.',
    () {
      final IUtils utils = Utils();

      final date = DateTime.parse('2023-05-17 10:30');
      final lastDay = utils.firstDayOfWeek(date);

      expect(lastDay.year, 2023);
      expect(lastDay.month, 5);
      expect(lastDay.day, 15);
    },
  );

  test(
    'checks if routine firstDayOfTheMonth returns first day of the month correctly',
    () {
      final IUtils utils = Utils();

      final date = DateTime.parse('2023-05-17 10:30');
      final lastDay = utils.firstDayOfTheMonth(date);

      expect(lastDay.year, 2023);
      expect(lastDay.month, 5);
      expect(lastDay.day, 1);
    },
  );

  test(
    'checks if routine lastDayOfTheMonth returns last day of the month correctly',
    () {
      final IUtils utils = Utils();

      final date = DateTime.parse('2023-05-17 10:30');
      final lastDay = utils.lastDayOfTheMonth(date);

      expect(lastDay.year, 2023);
      expect(lastDay.month, 5);
      expect(lastDay.day, 31);
    },
  );

  test(
    'Utils convertToEmployeeDto test.',
    () {
      final IUtils utils = Utils();

      final employeeDto = utils.convertToEmployeeDto(
        employee: employee,
      );

      expect(employeeDto.id, employee.id);
      expect(employeeDto.name, employee.name);
      expect(employeeDto.employeeType, employee.employeeType!.value);
      expect(employeeDto.cpf, employee.cpfNumber);
      expect(employeeDto.registrationNumber, employee.registrationNumber);
      expect(employeeDto.company, isNotNull);
      expect(employeeDto.company!.id, company.id);
      expect(employeeDto.arpId, employee.arpId);
      expect(employeeDto.employeeCode, employee.employeeCode);
    },
  );

  test(
    'Utils convertToCompanyDto test.',
    () {
      final IUtils utils = Utils();

      final companyDto = utils.convertToCompanyDto(
        company: company,
      );

      expect(companyDto.id, company.id);
      expect(companyDto.name, company.name);
      expect(companyDto.identifier, company.cnpj);
      expect(companyDto.timeZone, company.timeZone);
      expect(companyDto.arpId, company.arpId);
      expect(companyDto.caepf, company.caepf);
      expect(companyDto.cnoNumber, company.cnoNumber);
    },
  );

  /*test(
    'Utils convertToFenceDto test.',
    () {
      final IUtils utils = Utils();

      final now = DateTime.now();
      final perimeter = PerimeterDto(
        radius: 10,
        type: GeometricFormType.circle,
        startPoint: LocationDto(
          latitude: 2,
          longitude: 3,
          dateAndTime: now,
        ),
      );

      final fences = [
        FenceDto(
          name: 'fence1',
          perimeters: [perimeter],
        ),
      ];

      final fencesDto = utils.convertToFenceDto(
        fences: fences,
      );

      expect(fencesDto != null, true);
      expect(fencesDto!.isNotEmpty, true);
      expect(fencesDto.first.name, 'fence1');
      expect(fencesDto.first.perimeters!.isNotEmpty, true);
      expect(fencesDto.first.perimeters!.first.radius, 10);
      expect(
        fencesDto.first.perimeters!.first.type,
        GeometricFormType.circle,
      );
      expect(fencesDto.first.perimeters!.first.startPoint.latitude, 2);
      expect(fencesDto.first.perimeters!.first.startPoint.longitude, 3);
      expect(fencesDto.first.perimeters!.first.startPoint.dateAndTime, now);
      expect(utils.convertToFenceDto(), null);
      expect(utils.convertToPerimeterDto().isEmpty, true);
    },
  );*/

  test(
    'Utils formatCNPJ test.',
    () {
      final IUtils utils = Utils();

      expect(utils.formatCNPJ(cnpj: '51496725000153'), '51.496.725/0001-53');
    },
  );

  test(
    'Utils formatCPF test.',
    () {
      final IUtils utils = Utils();

      expect(utils.formatCPF(cpf: '10137153066'), '101.371.530-66');
    },
  );

  test(
    'Utils maskCPF test.',
    () {
      final IUtils utils = Utils();

      expect(utils.maskCPF(cpf: '12345678900'), '***.456.789-**');
    },
  );

  test(
    'Utils checkDeviceStatus test.',
    () {
      final IUtils utils = Utils();

      expect(
        utils.checkDeviceStatus(
          statusDevice: StatusDevice.pending,
          activationSituationType: ActivationSituationType.pending,
        ),
        DeviceAuthorizationStatusEnum.deviceAuthorizationIsPending,
      );

      expect(
        utils.checkDeviceStatus(
          statusDevice: StatusDevice.rejected,
          activationSituationType: ActivationSituationType.pending,
        ),
        DeviceAuthorizationStatusEnum.deviceAuthorizationWasRejected,
      );

      expect(
        utils.checkDeviceStatus(
          statusDevice: StatusDevice.authorized,
          activationSituationType: ActivationSituationType.pending,
        ),
        DeviceAuthorizationStatusEnum.deviceActivationIsPending,
      );

      expect(
        utils.checkDeviceStatus(
          statusDevice: StatusDevice.authorized,
          activationSituationType: ActivationSituationType.rejected,
        ),
        DeviceAuthorizationStatusEnum.deviceActivationWasRejected,
      );

      expect(
        utils.checkDeviceStatus(
          statusDevice: StatusDevice.authorized,
          activationSituationType: ActivationSituationType.authorized,
        ),
        DeviceAuthorizationStatusEnum.authorized,
      );
    },
  );

  testWidgets(
    'test Device Status Message',
    (WidgetTester tester) async {
      final IUtils utils = Utils();

      final widget = Scaffold(
        body: Builder(
          builder: (BuildContext context) {
            return Column(
              children: [
                Text(
                  utils.getDeviceStatusMessage(
                    context,
                    DeviceAuthorizationStatusEnum.deviceActivationIsPending,
                  ),
                ),
                Text(
                  utils.getDeviceStatusMessage(
                    context,
                    DeviceAuthorizationStatusEnum.deviceActivationWasRejected,
                  ),
                ),
                Text(
                  utils.getDeviceStatusMessage(
                    context,
                    DeviceAuthorizationStatusEnum.deviceAuthorizationIsPending,
                  ),
                ),
                Text(
                  utils.getDeviceStatusMessage(
                    context,
                    DeviceAuthorizationStatusEnum
                        .deviceAuthorizationWasRejected,
                  ),
                ),
              ],
            );
          },
        ),
      );

      await tester.pumpWidget(getWidget('pt', widget));

      expect(
        find.text(
          'A função de Ponto não está ativada para este dispositivo devido à autorização pendente do RH.',
        ),
        findsOneWidget,
      );
      expect(
        find.text(
          'A função de Ponto não está ativada para este dispositivo devido à autorização rejeitada pelo RH.',
        ),
        findsOneWidget,
      );
      expect(
        find.text(
          'A função de Ponto não está ativada para este dispositivo devido à ativação pendente do RH.',
        ),
        findsOneWidget,
      );
      expect(
        find.text(
          'A função de Ponto não está ativada para este dispositivo devido à ativação rejeitada pelo RH.',
        ),
        findsOneWidget,
      );
    },
  );

  test(
    'getOperationModeEnum test.',
    () {
      final IUtils utils = Utils();
      expect(
        utils.getOperationModeEnum(
          registerType: ClockingEventRegisterTypeSession(),
        ),
        OperationModeType.single,
      );

      expect(
        utils.getOperationModeEnum(
          registerType: ClockingEventRegisterTypeDriver(
            journeyId: 'journeyId',
            clockingEventUse: ClockingEventUseType.clockingEvent,
            isMealBreak: false,
            journeyEventName: 'StartJourneyEvent',
          ),
        ),
        OperationModeType.driver,
      );

      expect(
        utils.getOperationModeEnum(
          registerType: ClockingEventRegisterTypeFacialRecognition(
            employeeId: 'employeeId',
          ),
        ),
        OperationModeType.faceRecognition,
      );

      expect(
        utils.getOperationModeEnum(
          registerType: ClockingEventRegisterTypeEmailPassword(
            employeeId: 'employeeId',
          ),
        ),
        OperationModeType.multi,
      );

      expect(
        utils.getOperationModeEnum(
          registerType: ClockingEventRegisterTypeNFC(
            employeeId: 'employeeId',
          ),
        ),
        OperationModeType.nfc,
      );

      expect(
        utils.getOperationModeEnum(
          registerType: ClockingEventRegisterTypeQRCode(
            employeeId: 'employeeId',
          ),
        ),
        OperationModeType.qrCode,
      );
    },
  );

  test(
    'convertToManagerEmployeeDto test.',
    () {
      final IUtils utils = Utils();

      final managersIn = [managerEmployeeDtoMock];
      final managersOut =
          utils.convertToManagerEmployeeDto(managers: managersIn);

      expect(managersIn.first.id, managersOut!.first.id);
      expect(managersIn.first.mail, managersOut.first.mail);
      expect(
        managersIn.first.platformUserName,
        managersOut.first.platformUserName,
      );
      expect(managersIn.first.employees, managersOut.first.employees);
      expect(managersIn.first.platformUsers, managersOut.first.platformUsers);
    },
  );

  test(
    'convertListToManagerEmployeeDto test.',
    () {
      final IUtils utils = Utils();

      final employeesIn = [
        loginEmployeeDtoMockwithManagersAndPlatformUsers,
      ];
      final employeesOut =
          utils.convertListToManagerEmployeeDto(employees: employeesIn);

      expect(employeesIn.first.id, employeesOut!.first.id);
      expect(employeesIn.first.mail, employeesOut.first.mail);
      expect(employeesIn.first.name, employeesOut.first.name);
      expect(employeesIn.first.arpId, employeesOut.first.arpId);
      expect(employeesIn.first.cpfNumber, employeesOut.first.cpf);
      expect(employeesIn.first.employeeCode, employeesOut.first.employeeCode);
      expect(employeesIn.first.enabled, employeesOut.first.enable);
    },
  );

  test('convertListToPlatformUserEmployeeDto test.', () {
    final IUtils utils = Utils();

    final platformUsersIn = [
      platformUserEmployeeDtoMock,
    ];
    final platformUsersOut = utils.convertListToPlatformUserEmployeeDto(
      platformUsers: platformUsersIn,
    );

    expect(platformUsersIn.first.id, platformUsersOut!.first.id);
    expect(platformUsersIn.first.username, platformUsersOut.first.username);
  });

  test('getDateTimeFromHlb test.', () {
    final IUtils utils = Utils();

    const date = 1722522960000; // 01/08/2024 11:36:00
    final dateTime = utils.getDateTimeFromHlb(date);

    expect(
      dateTime,
      DateTime.fromMillisecondsSinceEpoch(date, isUtc: true),
    );
  });

  group('isNullOrWhitespace', () {
    test('should return true when the string is null', () {
      final result = Utils().isNullOrWhitespace(str: null);

      expect(result, true);
    });

    test('should return true when the string is empty', () {
      final result = Utils().isNullOrWhitespace(str: '');

      expect(result, true);
    });

    test('should return true when the string contains only whitespace', () {
      final result = Utils().isNullOrWhitespace(str: '   ');

      expect(result, true);
    });

    test(
        'should return false when the string contains non-whitespace characters',
        () {
      final result = Utils().isNullOrWhitespace(str: 'test');

      expect(result, false);
    });
  });

  group('TruncateStringServiceImpl', () {
    final IUtils utils = Utils();
    test('should truncate string if input length is greater than maxLength',
        () {
      const input = 'This is a long string';
      const maxLength = 10;

      final result = utils.truncateString(input, maxLength);

      expect(result, 'This is a ');
    });

    test(
        'should return the same string if input length is less than or equal to maxLength',
        () {
      const input = 'Short';
      const maxLength = 10;

      final result = utils.truncateString(input, maxLength);

      expect(result, input);
    });
  });

  test(
    'convertListToReminderEmployeeDto test.',
    () {
      final IUtils utils = Utils();

      final remindersIn = [
        reminderDTO,
      ];
      final remindersOut =
          utils.convertListToReminderEmployeeDto(reminders: remindersIn);
      final period =
          '0${remindersOut!.first.period.hour}:${remindersOut.first.period.minute}:0${remindersOut.first.period.second}';

      expect(remindersIn.first.id, remindersOut.first.id);
      expect(remindersIn.first.period, period);
      expect(remindersIn.first.enabled, remindersOut.first.enabled);
      expect(remindersIn.first.type.value, remindersOut.first.type.value);
    },
  );

  test(
    'Utils formatTimeQuantitative test.',
    () {
      final IUtils utils = Utils();

      final fifteenMinutes = DateTime(2024, 9, 18, 0, 15);
      final oneHour = DateTime(2024, 9, 18, 1, 0);
      final oneHourThirtyMinutes = DateTime(2024, 9, 18, 1, 30);
      final tenHours = DateTime(2024, 9, 18, 10, 0);
      final tenHoursThirtyMinutes = DateTime(2024, 9, 18, 10, 30);

      expect(utils.formatTimeQuantitative(dateTime: fifteenMinutes), '0h15');
      expect(utils.formatTimeQuantitative(dateTime: oneHour), '1h');
      expect(
        utils.formatTimeQuantitative(dateTime: oneHourThirtyMinutes),
        '1h30',
      );
      expect(utils.formatTimeQuantitative(dateTime: tenHours), '10h');
      expect(
        utils.formatTimeQuantitative(dateTime: tenHoursThirtyMinutes),
        '10h30',
      );

      expect(
        utils.formatTimeQuantitative(dateTime: fifteenMinutes, locale: 'es'),
        '0h15',
      );
      expect(
        utils.formatTimeQuantitative(dateTime: oneHour, locale: 'es'),
        '1h',
      );
      expect(
        utils.formatTimeQuantitative(
          dateTime: oneHourThirtyMinutes,
          locale: 'es',
        ),
        '1h30',
      );
      expect(
        utils.formatTimeQuantitative(dateTime: tenHours, locale: 'es'),
        '10h',
      );
      expect(
        utils.formatTimeQuantitative(
          dateTime: tenHoursThirtyMinutes,
          locale: 'es',
        ),
        '10h30',
      );

      expect(
        utils.formatTimeQuantitative(dateTime: fifteenMinutes, locale: 'en'),
        '0:15',
      );
      expect(
        utils.formatTimeQuantitative(dateTime: oneHour, locale: 'en'),
        '1:00',
      );
      expect(
        utils.formatTimeQuantitative(
          dateTime: oneHourThirtyMinutes,
          locale: 'en',
        ),
        '1:30',
      );
      expect(
        utils.formatTimeQuantitative(dateTime: tenHours, locale: 'en'),
        '10:00',
      );
      expect(
        utils.formatTimeQuantitative(
          dateTime: tenHoursThirtyMinutes,
          locale: 'en',
        ),
        '10:30',
      );
    },
  );

  // test(
  //   'Utils createPhotoPath test.',
  //   () async {
  //     final IUtils utils = Utils();

  //     const employeeId = '123';
  //     const photoName = 'photo.jpg';

  //     final path = await utils.createPhotoPath(
  //       employeeId: employeeId,
  //       photoName: photoName,
  //       createDirectory: true,
  //     );

  //     expect(path, contains(employeeId));
  //     expect(path, contains(photoName));
  //   },
  // );

  // test(
  //   'Utils getPhotoDirectory test.',
  //   () async {
  //     final IUtils utils = Utils();

  //     const employeeId = '123';

  //     final directory = await utils.getPhotoDirectory(employeeId: employeeId);

  //     expect(directory.path, contains(employeeId));
  //   },
  // );

  test(
    'Utils formatTime test.',
    () {
      final IUtils utils = Utils();

      final dateTime = DateTime(2023, 5, 17, 10, 30);

      expect(utils.formatTime(dateTime: dateTime), '10:30');
      expect(utils.formatTime(dateTime: dateTime, locale: 'en'), '10:30 AM');
    },
  );

  test(
    'Utils getDatePattern test.',
    () {
      final IUtils utils = Utils();

      expect(utils.getDatePattern(localeName: 'en'), 'MM/dd/yyyy');
      expect(utils.getDatePattern(localeName: 'pt'), 'dd/MM/yyyy');
      expect(utils.getDatePattern(localeName: 'es'), 'dd/MM/yyyy');
    },
  );

  test(
    'Utils getTimePattern test.',
    () {
      final IUtils utils = Utils();

      expect(utils.getTimePattern(localeName: 'en'), 'hh:mm a');
      expect(utils.getTimePattern(localeName: 'pt'), 'HH:mm');
      expect(utils.getTimePattern(localeName: 'es'), 'HH:mm');
    },
  );

  test(
    'Utils getDateTimePattern test.',
    () {
      final IUtils utils = Utils();

      expect(utils.getDateTimePattern(localeName: 'en'), 'MM/dd/yyyy hh:mm a');
      expect(utils.getDateTimePattern(localeName: 'pt'), 'dd/MM/yyyy HH:mm');
      expect(utils.getDateTimePattern(localeName: 'es'), 'dd/MM/yyyy HH:mm');
    },
  );

  test(
    'Utils isEven test.',
    () {
      final IUtils utils = Utils();

      expect(utils.isEven(2), true);
      expect(utils.isEven(1), false);
    },
  );

  test(
    'Utils convertStringTimeEventToDateTime test.',
    () {
      final IUtils utils = Utils();

      final convertStringTimeEventToDateTime =
          utils.convertStringTimeEventToDateTime('10:30:15');

      expect(convertStringTimeEventToDateTime, isNotNull);
      expect(convertStringTimeEventToDateTime.hour, 10);
      expect(convertStringTimeEventToDateTime.minute, 30);
      expect(convertStringTimeEventToDateTime.second, 15);
      expect(convertStringTimeEventToDateTime.year, DateTime.now().year);
      expect(convertStringTimeEventToDateTime.month, DateTime.now().month);
      expect(convertStringTimeEventToDateTime.day, DateTime.now().day);
    },
  );

  test(
    'Utils calculateDifferenceInMinutes test.',
    () {
      final IUtils utils = Utils();

      final calculateDifferenceInMinutes =
          utils.calculateDifferenceInMinutes('10:30:00', '10:00:00');

      expect(calculateDifferenceInMinutes, 30);
    },
  );

  test(
    'Utils calculateDifferenceInSeconds test.',
    () {
      final IUtils utils = Utils();

      final calculateDifferenceInSeconds =
          utils.calculateDifferenceInSeconds('10:00:30', '10:00:00');

      expect(calculateDifferenceInSeconds, 30);
    },
  );

  test(
    'Utils convertDateTimeToMinutes test.',
    () {
      final IUtils utils = Utils();

      final convertDateTimeToMinutes =
          utils.convertDateTimeToMinutes(DateTime(2023, 5, 17, 10, 30));

      expect(convertDateTimeToMinutes, 630);
    },
  );

  test(
    'Utils convertDateTimeToSeconds test.',
    () {
      final IUtils utils = Utils();

      final convertDateTimeToSeconds =
          utils.convertDateTimeToSeconds(DateTime(2023, 5, 17, 10, 30));

      expect(convertDateTimeToSeconds, 37800);
    },
  );

  test(
    'Utils getDriversWorkStatusByClockingEventUse test.',
    () {
      final IUtils utils = Utils();

      final driversWorkStatusEnum1 =
          utils.getDriversWorkStatusByClockingEventUse(
        ClockingEventUseEnum.clockingEvent,
      );
      final driversWorkStatusEnum2 =
          utils.getDriversWorkStatusByClockingEventUse(
        ClockingEventUseEnum.paidBreak,
      );
      final driversWorkStatusEnum3 =
          utils.getDriversWorkStatusByClockingEventUse(
        ClockingEventUseEnum.driving,
      );
      final driversWorkStatusEnum4 =
          utils.getDriversWorkStatusByClockingEventUse(
        ClockingEventUseEnum.mandatoryBreak,
      );
      final driversWorkStatusEnum5 =
          utils.getDriversWorkStatusByClockingEventUse(
        ClockingEventUseEnum.waiting,
      );

      expect(driversWorkStatusEnum1, DriversWorkStatusEnum.working);
      expect(driversWorkStatusEnum2, DriversWorkStatusEnum.working);
      expect(driversWorkStatusEnum3, DriversWorkStatusEnum.driving);
      expect(driversWorkStatusEnum4, DriversWorkStatusEnum.mandatoryBreak);
      expect(driversWorkStatusEnum5, DriversWorkStatusEnum.waiting);
    },
  );

  test(
    'Utils getClockingEventUseByDriversWorkStatus test.',
    () {
      final IUtils utils = Utils();

      final clockingEventUseEnum1 =
          utils.getClockingEventUseByDriversWorkStatus(
        DriversWorkStatusEnum.notStarted,
      );
      final clockingEventUseEnum2 =
          utils.getClockingEventUseByDriversWorkStatus(
        DriversWorkStatusEnum.working,
      );
      final clockingEventUseEnum3 =
          utils.getClockingEventUseByDriversWorkStatus(
        DriversWorkStatusEnum.foodTime,
      );
      final clockingEventUseEnum4 =
          utils.getClockingEventUseByDriversWorkStatus(
        DriversWorkStatusEnum.driving,
      );
      final clockingEventUseEnum5 =
          utils.getClockingEventUseByDriversWorkStatus(
        DriversWorkStatusEnum.mandatoryBreak,
      );
      final clockingEventUseEnum6 =
          utils.getClockingEventUseByDriversWorkStatus(
        DriversWorkStatusEnum.waiting,
      );
      final clockingEventUseEnum7 =
          utils.getClockingEventUseByDriversWorkStatus(
        DriversWorkStatusEnum.paidBreak,
      );

      expect(clockingEventUseEnum1, ClockingEventUseEnum.clockingEvent);
      expect(clockingEventUseEnum2, ClockingEventUseEnum.clockingEvent);
      expect(clockingEventUseEnum3, ClockingEventUseEnum.clockingEvent);
      expect(clockingEventUseEnum4, ClockingEventUseEnum.driving);
      expect(clockingEventUseEnum5, ClockingEventUseEnum.mandatoryBreak);
      expect(clockingEventUseEnum6, ClockingEventUseEnum.waiting);
      expect(clockingEventUseEnum7, ClockingEventUseEnum.paidBreak);
    },
  );

  test(
    'Utils getFirstEventByType test.',
    () {
      final IUtils utils = Utils();

      final List<JourneyTimeDetailsDto> journeyTimeDetailsList = [
        JourneyTimeDetailsDto(
          time: DateTime.now(),
          use: TypeJourneyTimeEnum.clockingEvent,
        ),
        JourneyTimeDetailsDto(
          time: DateTime.now(),
          use: TypeJourneyTimeEnum.paidBreak,
        ),
        JourneyTimeDetailsDto(
          time: DateTime.now(),
          use: TypeJourneyTimeEnum.mandatoryBreak,
        ),
        JourneyTimeDetailsDto(
          time: DateTime.now(),
          use: TypeJourneyTimeEnum.driving,
        ),
        JourneyTimeDetailsDto(
          time: DateTime.now(),
          use: TypeJourneyTimeEnum.waiting,
        ),
        JourneyTimeDetailsDto(
          time: DateTime.now(),
          use: TypeJourneyTimeEnum.working,
        ),
        JourneyTimeDetailsDto(
          time: DateTime.now(),
          use: TypeJourneyTimeEnum.mealBreak,
        ),
      ];

      final journeyTimeDetails1 = utils.getFirstEventByType(
        type: TypeJourneyTimeEnum.clockingEvent,
        journeyTimeDetailsList: journeyTimeDetailsList,
      );
      final journeyTimeDetails2 = utils.getFirstEventByType(
        type: TypeJourneyTimeEnum.paidBreak,
        journeyTimeDetailsList: journeyTimeDetailsList,
      );
      final journeyTimeDetails3 = utils.getFirstEventByType(
        type: TypeJourneyTimeEnum.mandatoryBreak,
        journeyTimeDetailsList: journeyTimeDetailsList,
      );
      final journeyTimeDetails4 = utils.getFirstEventByType(
        type: TypeJourneyTimeEnum.driving,
        journeyTimeDetailsList: journeyTimeDetailsList,
      );
      final journeyTimeDetails5 = utils.getFirstEventByType(
        type: TypeJourneyTimeEnum.waiting,
        journeyTimeDetailsList: journeyTimeDetailsList,
      );
      final journeyTimeDetails6 = utils.getFirstEventByType(
        type: TypeJourneyTimeEnum.working,
        journeyTimeDetailsList: journeyTimeDetailsList,
      );
      final journeyTimeDetails7 = utils.getFirstEventByType(
        type: TypeJourneyTimeEnum.mealBreak,
        journeyTimeDetailsList: journeyTimeDetailsList,
      );

      expect(journeyTimeDetails1, journeyTimeDetailsList[0]);
      expect(journeyTimeDetails2, journeyTimeDetailsList[1]);
      expect(journeyTimeDetails3, journeyTimeDetailsList[2]);
      expect(journeyTimeDetails4, journeyTimeDetailsList[3]);
      expect(journeyTimeDetails5, journeyTimeDetailsList[4]);
      expect(journeyTimeDetails6, journeyTimeDetailsList[5]);
      expect(journeyTimeDetails7, journeyTimeDetailsList[6]);
    },
  );

  test(
    'Utils toClockingEventUseEnum test.',
    () {
      final IUtils utils = Utils();

      final clockingEventUseEnum1 = utils.toClockingEventUseEnum(
        ClockingEventUseType.clockingEvent,
      );
      final clockingEventUseEnum2 = utils.toClockingEventUseEnum(
        ClockingEventUseType.paidBreak,
      );
      final clockingEventUseEnum3 = utils.toClockingEventUseEnum(
        ClockingEventUseType.mandatoryBreak,
      );
      final clockingEventUseEnum4 = utils.toClockingEventUseEnum(
        ClockingEventUseType.driving,
      );
      final clockingEventUseEnum5 = utils.toClockingEventUseEnum(
        ClockingEventUseType.waiting,
      );

      expect(clockingEventUseEnum1, ClockingEventUseEnum.clockingEvent);
      expect(clockingEventUseEnum2, ClockingEventUseEnum.paidBreak);
      expect(clockingEventUseEnum3, ClockingEventUseEnum.mandatoryBreak);
      expect(clockingEventUseEnum4, ClockingEventUseEnum.driving);
      expect(clockingEventUseEnum5, ClockingEventUseEnum.waiting);
    },
  );

  test(
    'Utils toClockingEventUseType test.',
    () {
      final IUtils utils = Utils();

      final clockingEventUseType1 = utils.toClockingEventUseType(
        ClockingEventUseEnum.clockingEvent,
      );
      final clockingEventUseType2 = utils.toClockingEventUseType(
        ClockingEventUseEnum.paidBreak,
      );
      final clockingEventUseType3 = utils.toClockingEventUseType(
        ClockingEventUseEnum.mandatoryBreak,
      );
      final clockingEventUseType4 = utils.toClockingEventUseType(
        ClockingEventUseEnum.driving,
      );
      final clockingEventUseType5 = utils.toClockingEventUseType(
        ClockingEventUseEnum.waiting,
      );

      expect(clockingEventUseType1, ClockingEventUseType.clockingEvent);
      expect(clockingEventUseType2, ClockingEventUseType.paidBreak);
      expect(clockingEventUseType3, ClockingEventUseType.mandatoryBreak);
      expect(clockingEventUseType4, ClockingEventUseType.driving);
      expect(clockingEventUseType5, ClockingEventUseType.waiting);
    },
  );

  test(
    'Utils getHourMinuteSecondFromDuration test.',
    () {
      final IUtils utils = Utils();

      final hourMinuteSecondFromDuration =
          utils.getHourMinuteSecondFromDuration(
        const Duration(
          hours: 1,
          minutes: 15,
          seconds: 30,
        ),
      );

      expect(hourMinuteSecondFromDuration, '01:15:30');
    },
  );
}
