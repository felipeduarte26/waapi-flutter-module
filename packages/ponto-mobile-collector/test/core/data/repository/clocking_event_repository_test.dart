import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:intl/intl.dart';
import 'package:mobile_authentication/mobile_authentication_service.dart' as auth;
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/drift/collector_database.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/mappers/clocking_event_mapper.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/ordering_mode_enum.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:test/test.dart';

class MockCompanyRepository extends Mock implements ICompanyRepository {}

class MockEmployeeRepository extends Mock implements IEmployeeRepository {}

void main() {
  late CollectorDatabase database;
  late IClockingEventRepository repository;
  late ICompanyRepository companyRepository;
  late IEmployeeRepository employeeRepository;

  DateTime today = DateTime.now();

  clock.DeviceDto device = clock.DeviceDto(
    dateTimeAutomatic: true,
    developerMode: clock.DeveloperModeEnum.active,
    gpsOperationMode: clock.GPSoperationModeEnum.active,
    imei: 'TPB4.220624.004',
    name: 'Device Name',
    timeZoneAutomatic: true,
  );

  clock.LocationDTO location = clock.LocationDTO(
    dateAndTime: DateTime.now(),
    latitude: 166584123,
    longitude: 987943153,
  );

  clock.ImportClockingEventDto clockingEvent1 = clock.ImportClockingEventDto(
    appVersion: '1',
    companyIdentifier: '81647957000126',
    cpf: '23902293012',
    dateEvent: DateFormat('yyyy-MM-dd').format(today),
    employeeId: '023c3456-bc93-4cf3-bdf3-5b9e6196c67d',
    platform: 'android',
    signature:
        '944064039e9043e8740b9f3a9ce41d78814db49b4bf64a5ead640d052e3babdb',
    signatureVersion: 2,
    timeEvent: '11:21:33',
    timeZone: '+03:00',
    use: 1,
    appointmentImage: 'appointmentImage',
    clientOriginInfo: 'clientOriginInfo',
    clockingEventId: 'd4c4689f-a464-4693-8039-af86e34db764',
    device: device,
    fenceState: clock.FenceStatusEnum.into,
    geolocation: location,
    geolocationIsMock: false,
    isSynchronized: false,
    locationStatus: clock.LocationStatusEnum.location,
    mode: clock.OperationModeEnum.single,
    online: true,
    origin: clock.ClockingEventOriginEnum.mobile,
    photoNotCaptured: 'photoNotCaptured',
    facialRecognitionStatus: 'facialRecognitionStatus',
  );

  clock.ImportClockingEventDto clockingEvent2 = clock.ImportClockingEventDto(
    appVersion: '1',
    companyIdentifier: '81647957000126',
    cpf: '23902293012',
    dateEvent: DateFormat('yyyy-MM-dd')
        .format(today.subtract(const Duration(days: 96))),
    employeeId: '023c3456-bc93-4cf3-bdf3-5b9e6196c67d',
    platform: 'android',
    signature:
        '944064039e9043e8740b9f3a9ce41d78814db49b4bf64a5ead640d052e3babdb',
    signatureVersion: 2,
    timeEvent: '11:21:33',
    timeZone: '+03:00',
    use: 1,
    appointmentImage: 'appointmentImage',
    clientOriginInfo: 'clientOriginInfo',
    clockingEventId: '6a532f46-4aad-48be-acd7-d17d75e24a32',
    device: device,
    fenceState: clock.FenceStatusEnum.into,
    geolocation: location,
    geolocationIsMock: false,
    isSynchronized: false,
    locationStatus: clock.LocationStatusEnum.location,
    mode: clock.OperationModeEnum.single,
    online: true,
    origin: clock.ClockingEventOriginEnum.mobile,
    photoNotCaptured: 'photoNotCaptured',
  );

  clock.ImportClockingEventDto clockingEvent3 = clock.ImportClockingEventDto(
    appVersion: '1',
    companyIdentifier: '81647957000126',
    cpf: '23902293012',
    dateEvent: DateFormat('yyyy-MM-dd')
        .format(today.subtract(const Duration(days: 100))),
    employeeId: '2a7378d8-1913-4b74-9efb-f11ccf2b8c28',
    platform: 'android',
    signature:
        '944064039e9043e8740b9f3a9ce41d78814db49b4bf64a5ead640d052e3babdb',
    signatureVersion: 2,
    timeEvent: '11:21:33',
    timeZone: '+03:00',
    use: 1,
    appointmentImage: 'appointmentImage',
    clientOriginInfo: 'clientOriginInfo',
    clockingEventId: '7edc9df4-1a2d-4037-b485-603064ae7453',
    device: device,
    fenceState: clock.FenceStatusEnum.into,
    geolocation: location,
    geolocationIsMock: false,
    isSynchronized: true,
    locationStatus: clock.LocationStatusEnum.location,
    mode: clock.OperationModeEnum.single,
    online: true,
    origin: clock.ClockingEventOriginEnum.mobile,
    photoNotCaptured: 'photoNotCaptured',
  );

  clock.ImportClockingEventDto clockingEvent4 = clock.ImportClockingEventDto(
    appVersion: '1',
    companyIdentifier: '81647957000126',
    cpf: '23902293012',
    dateEvent: DateFormat('yyyy-MM-dd')
        .format(today.subtract(const Duration(days: 100))),
    employeeId: '2a7378d8-1913-4b74-9efb-f11ccf2b8c28',
    platform: 'android',
    signature:
        '944064039e9043e8740b9f3a9ce41d78814db49b4bf64a5ead640d052e3babdb',
    signatureVersion: 2,
    timeEvent: '11:21:33',
    timeZone: '+03:00',
    use: 1,
    appointmentImage: 'appointmentImage',
    clientOriginInfo: 'clientOriginInfo',
    clockingEventId: 'f1aa9db0-2e91-4658-a541-5610fcf6517b',
    device: device,
    fenceState: clock.FenceStatusEnum.into,
    geolocation: location,
    geolocationIsMock: false,
    isSynchronized: false,
    locationStatus: clock.LocationStatusEnum.location,
    mode: clock.OperationModeEnum.single,
    online: true,
    origin: clock.ClockingEventOriginEnum.mobile,
    photoNotCaptured: 'photoNotCaptured',
  );

  clock.ImportClockingEventDto clockingEvent5 = clock.ImportClockingEventDto(
    appVersion: '1',
    companyIdentifier: '81647957000126',
    cpf: '23902293012',
    dateEvent: DateFormat('yyyy-MM-dd')
        .format(today.subtract(const Duration(days: 102))),
    employeeId: '4b3cb309-496f-4e0f-8056-b1cc535ca4b8',
    platform: 'android',
    signature:
        '944064039e9043e8740b9f3a9ce41d78814db49b4bf64a5ead640d052e3babdb',
    signatureVersion: 2,
    timeEvent: '11:21:33',
    timeZone: '+03:00',
    use: 1,
    appointmentImage: 'appointmentImage',
    clientOriginInfo: 'clientOriginInfo',
    clockingEventId: 'f1aa9db0-2e91-4658-a541-5610fcf6517b',
    device: device,
    fenceState: clock.FenceStatusEnum.into,
    geolocation: location,
    geolocationIsMock: false,
    isSynchronized: false,
    locationStatus: clock.LocationStatusEnum.location,
    mode: clock.OperationModeEnum.single,
    online: true,
    origin: clock.ClockingEventOriginEnum.mobile,
    photoNotCaptured: 'photoNotCaptured',
  );

  LazyDatabase openConnection() {
    return LazyDatabase(
      () async {
        return NativeDatabase.memory(logStatements: false);
      },
    );
  }

  setUp(
    () {
      database = CollectorDatabase(
        database: openConnection(),
      );
      companyRepository = MockCompanyRepository();
      employeeRepository = MockEmployeeRepository();


      repository = ClockingEventRepository(database: database,
      companyRepository: companyRepository,
      employeeRepository: employeeRepository,);
    },
  );

  tearDown(
    () async {
      await database.close();
    },
  );

  group(
    'ClockingEventRepository',
    () {
      test(
        'save test',
        () async {
          bool isEmpty = (await repository.getAll()).isEmpty;

          bool successSave1 = await repository.save(
            clockingEvent: clockingEvent1,
            isMealBreak: false,
          );
          bool successSave2 = await repository.save(
            clockingEvent: clockingEvent2,
            isMealBreak: false,
          );
          bool successSave3 = await repository.save(
            clockingEvent: clockingEvent3,
            isMealBreak: false,
          );
          clockingEvent1.isSynchronized = true;
          bool successUpdate = await repository.save(
            clockingEvent: clockingEvent1,
            isMealBreak: false,
          );

          expect(isEmpty, true);
          expect(successSave1, true);
          expect(successSave2, true);
          expect(successSave3, true);
          expect(successUpdate, true);
        },
      );

      test(
        'findByid test',
        () async {
          await repository.save(
            clockingEvent: clockingEvent1,
            isMealBreak: false,
          );

          ClockingEvent clockingEventDto =
              (await repository.findById(
            clockingEventId: clockingEvent1.clockingEventId,
            employeeId: clockingEvent1.employeeId,
          ))!;

          var importClockingEventDto = ClockingEventMapper.fromEntityToClock(clockingEventDto);

          expect(importClockingEventDto.appVersion, clockingEvent1.appVersion);
          expect(
            importClockingEventDto.appointmentImage,
            clockingEvent1.appointmentImage,
          );
          expect(
            importClockingEventDto.clientOriginInfo,
            clockingEvent1.clientOriginInfo,
          );
          expect(
            importClockingEventDto.companyIdentifier,
            clockingEvent1.companyIdentifier,
          );
          expect(importClockingEventDto.cpf, clockingEvent1.cpf);
          expect(importClockingEventDto.dateEvent, clockingEvent1.dateEvent);
          expect(importClockingEventDto.employeeId, clockingEvent1.employeeId);
          expect(importClockingEventDto.fenceState, clockingEvent1.fenceState);
          expect(
            importClockingEventDto.isSynchronized,
            clockingEvent1.isSynchronized,
          );
          expect(
            importClockingEventDto.locationStatus,
            clockingEvent1.locationStatus,
          );
          expect(importClockingEventDto.mode, clockingEvent1.mode);
          expect(importClockingEventDto.online, clockingEvent1.online);
          expect(importClockingEventDto.origin, clockingEvent1.origin);
          expect(
            importClockingEventDto.photoNotCaptured,
            clockingEvent1.photoNotCaptured,
          );
          expect(importClockingEventDto.platform, clockingEvent1.platform);

          expect(
            importClockingEventDto.device!.dateTimeAutomatic,
            clockingEvent1.device!.dateTimeAutomatic,
          );

          expect(
            importClockingEventDto.device!.developerMode,
            clockingEvent1.device!.developerMode,
          );

          expect(
            importClockingEventDto.device!.gpsOperationMode,
            clockingEvent1.device!.gpsOperationMode,
          );

          expect(
            importClockingEventDto.device!.imei,
            clockingEvent1.device!.imei,
          );

          expect(
            importClockingEventDto.device!.name,
            clockingEvent1.device!.name,
          );

          expect(
            importClockingEventDto.device!.timeZoneAutomatic,
            clockingEvent1.device!.timeZoneAutomatic,
          );
        },
      );

      test(
        'findAllUnsyncedByEmployeeId test',
        () async {
          await repository.save(
            clockingEvent: clockingEvent2,
            isMealBreak: false,
          );
          await repository.save(
            clockingEvent: clockingEvent3,
            isMealBreak: false,
          );

          List<ClockingEvent> clockFindAllUnsyncedByEmployeeId =
              await repository.findAllUnsyncedByEmployeeId(
            employeeId: clockingEvent2.employeeId,
          );

          expect(clockFindAllUnsyncedByEmployeeId.length, 1);
          expect(
            clockFindAllUnsyncedByEmployeeId.first.id,
            clockingEvent2.clockingEventId,
          );
        },
      );

      test(
        'confirmSynchronization test',
        () async {
          await repository.confirmSynchronization(
            clockingEventsImportedId: [],
          );

          await repository.save(
            clockingEvent: clockingEvent3,
            isMealBreak: false,
          );

          String clockingEventsImportedId =
              '2c0adbed-7e9e-4f91-87e8-388fecc1dff0';

          await repository.confirmSynchronization(
            clockingEventsImportedId: [clockingEventsImportedId],
          );

          final query = database.select(database.clockingEventTable);
          query.where(
            (tbl) => tbl.clockingEventId.equals(
              clockingEventsImportedId,
            ),
          );

          expect(
            (await repository.findById(
              clockingEventId: clockingEvent3.clockingEventId,
              employeeId: clockingEvent3.employeeId,
            ))!
                .isSynchronized,
            true,
          );
        },
      );

      test(
        'findAllUnsyncedByEmployeeId test.',
        () async {
          clockingEvent1.isSynchronized = false;
          await repository.save(
            clockingEvent: clockingEvent1,
            isMealBreak: false,
          );
          await repository.save(
            clockingEvent: clockingEvent2,
            isMealBreak: false,
          );
          await repository.save(
            clockingEvent: clockingEvent3,
            isMealBreak: false,
          );

          List<ClockingEvent> findAllUnsyncedByEmployeeId =
              await repository.findAllUnsyncedByEmployeeId(
            employeeId: clockingEvent2.employeeId,
          );

          expect(findAllUnsyncedByEmployeeId.length, 2);

          expect(
            findAllUnsyncedByEmployeeId[0].id,
            clockingEvent1.clockingEventId,
          );

          expect(
            findAllUnsyncedByEmployeeId[1].id,
            clockingEvent2.clockingEventId,
          );
        },
      );

      test(
        'findAllUnsynced test.',
        () async {
          clockingEvent1.isSynchronized = false;
          await repository.save(
            clockingEvent: clockingEvent1,
            isMealBreak: false,
          );
          await repository.save(
            clockingEvent: clockingEvent2,
            isMealBreak: false,
          );
          await repository.save(
            clockingEvent: clockingEvent3,
            isMealBreak: false,
          );
          await repository.save(
            clockingEvent: clockingEvent4,
            isMealBreak: false,
          );

          List<ClockingEvent> findAllUnsynced =
              await repository.findAllUnsynced();

          expect(findAllUnsynced.length, 3);

          expect(
            findAllUnsynced[0].id,
            clockingEvent1.clockingEventId,
          );

          expect(
            findAllUnsynced[1].id,
            clockingEvent2.clockingEventId,
          );

          expect(
            findAllUnsynced[2].id,
            clockingEvent4.clockingEventId,
          );
        },
      );

      test(
        'findByDate test.',
        () async {
          await repository.save(
            clockingEvent: clockingEvent1,
            isMealBreak: false,
          );
          await repository.save(
            clockingEvent: clockingEvent2,
            isMealBreak: false,
          );
          await repository.save(
            clockingEvent: clockingEvent3,
            isMealBreak: false,
          );

          List<ClockingEvent> findByDate =
              await repository.findByDate(
            date: today,
            employeeId: clockingEvent2.employeeId,
          );

          expect(findByDate.length, 1);

          expect(
            findByDate[0].id,
            clockingEvent1.clockingEventId,
          );

          findByDate =
              await repository.findByDate(
            date: today,
            employeeId: clockingEvent2.employeeId,
            filterByUse: auth.ClockingEventUseType.driving,
          );

          expect(findByDate.length, 0);
        },
      );

      test(
        'findByEmployeeAndPeriod test.',
        () async {
          await repository.save(
            clockingEvent: clockingEvent1,
            isMealBreak: false,
          );
          await repository.save(
            clockingEvent: clockingEvent2,
            isMealBreak: false,
          );
          await repository.save(
            clockingEvent: clockingEvent3,
            isMealBreak: false,
          );

          List<ClockingEvent> findByDate =
              await repository.findByEmployeeAndPeriod(
            endDate: today.add(const Duration(days: 1)),
            initDate: today.subtract(const Duration(days: 98)),
            orderingMode: OrderingModeEnum.asc,
            employeeId: clockingEvent2.employeeId,
          );

          expect(findByDate.length, 2);

          expect(
            findByDate[0].id,
            clockingEvent2.clockingEventId,
          );

          expect(
            findByDate[1].id,
            clockingEvent1.clockingEventId,
          );
        },
      );

      test(
        'findByPeriod test.',
        () async {
          await repository.save(
            clockingEvent: clockingEvent1,
            isMealBreak: false,
          );
          await repository.save(
            clockingEvent: clockingEvent2,
            isMealBreak: false,
          );
          await repository.save(
            clockingEvent: clockingEvent3,
            isMealBreak: false,
          );

          List<ClockingEvent> findByDate =
              await repository.findByPeriod(
            endDate: today.add(const Duration(days: 1)),
            initDate: today.subtract(const Duration(days: 101)),
            orderingMode: OrderingModeEnum.asc,
          );

          expect(findByDate.length, 3);

          expect(
            findByDate[1].id,
            clockingEvent2.clockingEventId,
          );

          expect(
            findByDate[2].id,
            clockingEvent1.clockingEventId,
          );

          expect(
            findByDate[0].id,
            clockingEvent3.clockingEventId,
          );
        },
      );

      test(
        'deleteRecordsOlderThen60Days test.',
        () async {
          await repository.save(
            clockingEvent: clockingEvent1,
            isMealBreak: false,
          );
          await repository.save(
            clockingEvent: clockingEvent2,
            isMealBreak: false,
          );
          await repository.save(
            clockingEvent: clockingEvent3,
            isMealBreak: false,
          );

          int deleteRecordsOlderThen60Days =
              await repository.deleteRecordsOlderThen60Days(
            referenceDate: today,
          );

          expect(deleteRecordsOlderThen60Days, 1);
          expect(
            (await repository.findById(
              clockingEventId: clockingEvent1.clockingEventId,
              employeeId: clockingEvent1.employeeId,
            ))!
                .id,
            clockingEvent1.clockingEventId,
          );

          expect(
            (await repository.findById(
              clockingEventId: clockingEvent2.clockingEventId,
              employeeId: clockingEvent2.employeeId,
            ))!
                .id,
            clockingEvent2.clockingEventId,
          );
        },
      );

      test(
        'findLastClockingEventByEmployeeId test.',
        () async {
          ClockingEvent? importClockingEventEmptyDto =
              await repository.findLastClockingEventByEmployeeId(
            employeeId: clockingEvent1.employeeId,
          );

          expect(importClockingEventEmptyDto, null);

          await repository.save(
            clockingEvent: clockingEvent1,
            isMealBreak: false,
          );
          await repository.save(
            clockingEvent: clockingEvent2,
            isMealBreak: false,
          );
          await repository.save(
            clockingEvent: clockingEvent3,
            isMealBreak: false,
          );

          ClockingEvent importClockingEventDto =
              (await repository.findLastClockingEventByEmployeeId(
            employeeId: clockingEvent1.employeeId,
          ))!;

          expect(importClockingEventDto.employeeId, clockingEvent1.employeeId);
          expect(
            importClockingEventDto.id,
            clockingEvent1.clockingEventId,
          );
          expect(importClockingEventDto.dateEvent, clockingEvent1.dateEvent);
          expect(importClockingEventDto.timeEvent, clockingEvent1.timeEvent);
        },
      );

      test(
        'findByEmployeesInAndPeriod test.',
        () async {
          await repository.save(
            clockingEvent: clockingEvent1,
            isMealBreak: false,
          );
          await repository.save(
            clockingEvent: clockingEvent2,
            isMealBreak: false,
          );
          await repository.save(
            clockingEvent: clockingEvent3,
            isMealBreak: false,
          );
          await repository.save(
            clockingEvent: clockingEvent4,
            isMealBreak: false,
          );
          await repository.save(
            clockingEvent: clockingEvent5,
            isMealBreak: false,
          );

          List<ClockingEvent> findByDate =
              await repository.findByEmployeesInAndPeriod(
            endDate: today.add(const Duration(days: 1)),
            initDate: today.subtract(const Duration(days: 103)),
            orderingMode: OrderingModeEnum.asc,
            employeesIds: [
              '023c3456-bc93-4cf3-bdf3-5b9e6196c67d',
              '4b3cb309-496f-4e0f-8056-b1cc535ca4b8',
            ],
          );

          expect(findByDate.length, 3);

          expect(
            findByDate[2].id,
            clockingEvent1.clockingEventId,
          );

          expect(
            findByDate[1].id,
            clockingEvent2.clockingEventId,
          );

          expect(
            findByDate[0].id,
            clockingEvent5.clockingEventId,
          );
        },
      );

      test(
        'findFirstByDate test.',
            () async {
          await repository.save(
            clockingEvent: clockingEvent1,
            isMealBreak: false,
          );
          await repository.save(
            clockingEvent: clockingEvent2,
            isMealBreak: false,
          );
          await repository.save(
            clockingEvent: clockingEvent3,
            isMealBreak: false,
          );
          await repository.save(
            clockingEvent: clockingEvent4,
            isMealBreak: false,
          );
          await repository.save(
            clockingEvent: clockingEvent5,
            isMealBreak: false,
          );

          List<ClockingEvent> findByDate =
          await repository.findFirstByDate(
            date: today,
          );

          expect(findByDate.length, 1);

          expect(
            findByDate[0].id,
            clockingEvent1.clockingEventId,
          );
        },
      );
    },
  );
}
