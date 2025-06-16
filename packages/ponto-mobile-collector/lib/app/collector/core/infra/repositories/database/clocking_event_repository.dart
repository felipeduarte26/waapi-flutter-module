import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
import 'package:drift/drift.dart';
import 'package:intl/intl.dart';
import 'package:mobile_authentication/mobile_authentication_service.dart'
    as auth;

import '../../../../../../ponto_mobile_collector.dart';
import '../../../domain/entities/company.dart';
import '../../../domain/entities/device.dart';
import '../../../domain/enums/developer_mode.dart';
import '../../../domain/enums/gps_operation_mode.dart';
import '../../../domain/enums/location_status.dart';
import '../../../domain/input_model/location_dto.dart';
import '../../../external/drift/collector_database.dart';
import '../../utils/enum/ordering_mode_enum.dart';

class ClockingEventRepository implements IClockingEventRepository {
  CollectorDatabase database;
  ICompanyRepository companyRepository;
  IEmployeeRepository employeeRepository;

  ClockingEventRepository({
    required this.database,
    required this.companyRepository,
    required this.employeeRepository,
  });

  @override
  Future<bool> exist({
    required String clockingEventId,
  }) async {
    final query = database.select(database.clockingEventTable);
    query.where((tbl) => tbl.clockingEventId.equals(clockingEventId));
    ClockingEventTableData? tableData = await query.getSingleOrNull();
    return tableData != null;
  }

  @override
  Future<int> insert({
    required clock.ImportClockingEventDto clockingEvent,
    String? journeyId,
    required bool isMealBreak,
    String? journeyEventName,
  }) async {
    ClockingEventTableData tableData = convertToTable(
      dto: clockingEvent,
      journeyId: journeyId,
      journeyEventName: journeyEventName,
      isMealBreak: isMealBreak,
    );
    return database.into(database.clockingEventTable).insert(tableData);
  }

  @override
  Future<bool> update({
    required clock.ImportClockingEventDto clockingEvent,
    String? journeyId,
    required bool isMealBreak,
    String? journeyEventName,
  }) async {
    ClockingEventTableData tableData = convertToTable(
      dto: clockingEvent,
      journeyId: journeyId,
      journeyEventName: journeyEventName,
      isMealBreak: isMealBreak,
    );
    return database.update(database.clockingEventTable).replace(tableData);
  }

  @override
  Future<List<ClockingEvent>> getAll() async {
    List<ClockingEventTableData> datas =
        await database.select(database.clockingEventTable).get();
    return convertToClockingEventList(data: datas);
  }

  @override
  Future<bool> save({
    required clock.ImportClockingEventDto clockingEvent,
    String? journeyId,
    String? journeyEventName,
    required bool isMealBreak,
  }) async {
    return (await exist(clockingEventId: clockingEvent.clockingEventId))
        ? await update(
            clockingEvent: clockingEvent,
            journeyId: journeyId,
            isMealBreak: isMealBreak,
            journeyEventName: journeyEventName,
          )
        : (await insert(
              clockingEvent: clockingEvent,
              journeyId: journeyId,
              isMealBreak: isMealBreak,
              journeyEventName: journeyEventName,
            )) >
            0;
  }

  @override
  Future<ClockingEvent?> findById({
    required String clockingEventId,
    required String employeeId,
  }) async {
    ClockingEventTableData? tableData;

    final query = database.select(database.clockingEventTable);
    query.where((tbl) => tbl.clockingEventId.isValue(clockingEventId));
    query.where((tbl) => tbl.employeeId.isValue(employeeId));
    tableData = await query.getSingleOrNull();

    if (tableData == null) {
      return null;
    }
    return convertToEntity(
      tableData: tableData,
    );
  }

  @override
  Future<void> confirmSynchronization({
    required List<String> clockingEventsImportedId,
  }) async {
    if (clockingEventsImportedId.isEmpty) {
      return Future.value();
    }

    for (String clockingEventImportedId in clockingEventsImportedId) {
      final query = database.update(database.clockingEventTable);
      query.where(
        (tbl) => tbl.clockingEventId.isValue(clockingEventImportedId),
      );
      await query.write(
        const ClockingEventTableCompanion(
          isSynchronized: Value(true),
        ),
      );
    }
  }

  @override
  Future<List<ClockingEvent>> findAllUnsyncedByEmployeeId({
    required String employeeId,
    int limit = 100,
  }) async {
    final query = database.select(database.clockingEventTable);
    query.where((tbl) => tbl.isSynchronized.isValue(false));
    query.where((tbl) => tbl.employeeId.isValue(employeeId));
    query.where((tbl) => tbl.employeeId.isValue(employeeId));
    query.limit(limit);

    List<ClockingEventTableData> datas = await query.get();
    return convertToClockingEventList(data: datas);
  }

  @override
  Future<List<ClockingEvent>> findByDate({
    required DateTime date,
    required String employeeId,
    auth.ClockingEventUseType? filterByUse,
  }) async {
    late List<ClockingEventTableData> datas;

    final String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    final query = database.select(database.clockingEventTable);
    query.where((tbl) => tbl.dateEvent.equals(formattedDate));
    query.where((tbl) => tbl.employeeId.isValue(employeeId));

    if (filterByUse != null) {
      final joinedQuery = query.join([
        innerJoin(
          database.clockingEventUseTable,
          database.clockingEventUseTable.code
              .cast<int>()
              .equalsExp(database.clockingEventTable.use),
        ),
      ]);
      joinedQuery.where(
        database.clockingEventUseTable.employeeId.isValue(employeeId),
      );
      joinedQuery.where(
        database.clockingEventUseTable.clockingEventUseType
            .isValue(filterByUse.value),
      );

      final results = await joinedQuery.get();
      datas = results
          .map((row) => row.readTable(database.clockingEventTable))
          .toList();
    } else {
      datas = await query.get();
    }

    return convertToClockingEventList(data: datas);
  }

  @override
  Future<List<ClockingEvent>> findFirstByDate({
    required DateTime date,
  }) async {
    final String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    final query = database.select(database.clockingEventTable).join([
      leftOuterJoin(
        database.employeeTable,
        database.employeeTable.id
            .equalsExp(database.clockingEventTable.employeeId),
      ),
    ]);

    query.where(
      database.clockingEventTable.dateEvent.equals(formattedDate),
    );

    var typedList = await query.get();

    var clockingEventsWithEmployee = typedList.map((row) {
      return ClockingEventWithEmployee(
        clockingEventTableData: row.readTable(database.clockingEventTable),
        employeeTableData: row.readTableOrNull(database.employeeTable),
      );
    }).toList();

    return convertToDtoListWithEmployee(data: clockingEventsWithEmployee);
  }

  @override
  Future<List<ClockingEvent>> findByEmployeeAndPeriod({
    required DateTime initDate,
    required DateTime endDate,
    required String employeeId,
    OrderingModeEnum orderingMode = OrderingModeEnum.asc,
  }) async {
    final DateTime localInitDate =
        DateTime(initDate.year, initDate.month, initDate.day, 0, 0, 0);
    final DateTime localEndDate =
        DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59);

    final query = database.select(database.clockingEventTable);

    query.where(
      (tbl) => tbl.dateTimeEvent.isBiggerOrEqualValue(
        localInitDate,
      ),
    );

    query.where(
      (tbl) => tbl.dateTimeEvent.isSmallerOrEqualValue(
        localEndDate,
      ),
    );

    query.where((tbl) => tbl.employeeId.isValue(employeeId));

    query.orderBy(
      [
        (tbl) => OrderingTerm(
              expression: tbl.dateTimeEvent,
              mode: orderingMode == OrderingModeEnum.asc
                  ? OrderingMode.asc
                  : OrderingMode.desc,
            ),
      ],
    );

    List<ClockingEventTableData> datas = await query.get();

    return convertToClockingEventList(data: datas);
  }

  @override
  Future<List<ClockingEvent>> findByPeriod({
    required DateTime initDate,
    required DateTime endDate,
    OrderingModeEnum orderingMode = OrderingModeEnum.asc,
  }) async {
    final DateTime localInitDate =
        DateTime(initDate.year, initDate.month, initDate.day, 0, 0, 0);
    final DateTime localEndDate =
        DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59);

    final query = database.select(database.clockingEventTable).join([
      leftOuterJoin(
        database.employeeTable,
        database.employeeTable.id
            .equalsExp(database.clockingEventTable.employeeId),
      ),
    ]);

    query.where(
      database.clockingEventTable.dateTimeEvent.isBiggerOrEqualValue(
        localInitDate,
      ),
    );

    query.where(
      database.clockingEventTable.dateTimeEvent.isSmallerOrEqualValue(
        localEndDate,
      ),
    );

    query.orderBy(
      [
        OrderingTerm(
          expression: database.clockingEventTable.dateTimeEvent,
          mode: orderingMode == OrderingModeEnum.asc
              ? OrderingMode.asc
              : OrderingMode.desc,
        ),
      ],
    );

    var typedList = await query.get();

    var clockingEventsWithEmployee = typedList.map((row) {
      return ClockingEventWithEmployee(
        clockingEventTableData: row.readTable(database.clockingEventTable),
        employeeTableData: row.readTableOrNull(database.employeeTable),
      );
    }).toList();

    return convertToDtoListWithEmployee(data: clockingEventsWithEmployee);
  }

  @override
  Future<int> deleteRecordsOlderThen60Days({
    required DateTime referenceDate,
  }) async {
    final query = database.delete(database.clockingEventTable);
    DateTime finalDate = referenceDate.subtract(const Duration(days: 60));
    query.where((tbl) => tbl.isSynchronized.isValue(true));
    query.where((tbl) => tbl.dateTimeEvent.isSmallerThanValue(finalDate));
    return Future.value(query.go());
  }

  @override
  Future<ClockingEvent?> findLastClockingEventByEmployeeId({
    required String employeeId,
  }) async {
    final query = database.select(database.clockingEventTable);
    query.where((tbl) => tbl.employeeId.isValue(employeeId));
    query.orderBy(
      [
        (tbl) => OrderingTerm(
              expression: tbl.dateTimeEvent,
              mode: OrderingMode.desc,
            ),
      ],
    );
    query.limit(1);
    List<ClockingEventTableData> events = await query.get();

    if (events.isEmpty) {
      return Future.value();
    }
    var clockingEventList = await convertToClockingEventList(data: events);

    return clockingEventList.first;
  }

  @override
  ClockingEventTableData convertToTable({
    required clock.ImportClockingEventDto dto,
    String? journeyId,
    String? journeyEventName,
    bool? isMealBreak,
  }) {
    assert(
      !(dto.mode == clock.OperationModeEnum.driver &&
          (journeyId == null || journeyId.isEmpty)),
      'JourneyId is required when mode is driver',
    );

    return ClockingEventTableData(
      dateTimeEvent: dto.getDateTimeEvent(),
      dateEvent: dto.dateEvent,
      timeEvent: dto.timeEvent,
      timeZone: dto.timeZone,
      companyIdentifier: dto.companyIdentifier,
      pis: dto.pis,
      cpf: dto.cpf,
      appVersion: dto.appVersion,
      platform: dto.platform,
      developerModeDevice: dto.device?.developerMode?.value,
      nameDevice: dto.device?.name,
      identifierDevice: dto.device?.imei,
      gpsOperationModeDevice: dto.device?.gpsOperationMode?.value,
      timeZoneAutomaticDevice: dto.device?.timeZoneAutomatic,
      dateTimeAutomaticDevice: dto.device?.dateTimeAutomatic,
      latitudeLocation: dto.geolocation?.latitude,
      longitudeLocation: dto.geolocation?.longitude,
      geolocationIsMock: dto.geolocationIsMock,
      dateAndTimeLocation: dto.geolocation?.dateAndTime,
      employeeId: dto.employeeId,
      fenceState: dto.fenceState?.id,
      use: dto.use,
      journeyId: journeyId,
      clockingEventId: dto.clockingEventId,
      mode: dto.mode!.id,
      online: dto.online ?? false,
      signature: dto.signature,
      signatureVersion: dto.signatureVersion,
      origin: dto.origin!.value,
      clientOriginInfo: dto.clientOriginInfo,
      appointmentImage: dto.appointmentImage,
      photoNotCaptured: dto.photoNotCaptured,
      locationStatus: dto.locationStatus?.id,
      isSynchronized: dto.isSynchronized,
      isMealBreak: isMealBreak ?? false,
      employeeName: dto.employeeDto?.name ?? '',
      companyName: dto.companyDto?.name ?? '',
      journeyEventName: journeyEventName,
      facialRecognitionStatus: dto.facialRecognitionStatus,
    );
  }

  @override
  Future<ClockingEvent> convertToEntity({
    required ClockingEventTableData tableData,
    EmployeeTableData? employeeTableData,
  }) async {
    Device? device;

    if (tableData.identifierDevice != null) {
      device = Device(
        identifier: tableData.identifierDevice!,
        name: tableData.nameDevice!,
        developerMode:
            DeveloperModeEnum.build(tableData.developerModeDevice!),
        gpsOperationMode:
            GPSoperationModeEnum.build(tableData.gpsOperationModeDevice!),
        dateTimeAutomatic: tableData.dateTimeAutomaticDevice!,
        timeZoneAutomatic: tableData.timeZoneAutomaticDevice!,
      );
    }

    LocationDto? location;
    if (tableData.longitudeLocation != null) {
      location = LocationDto(
        latitude: tableData.latitudeLocation!,
        longitude: tableData.longitudeLocation!,
        dateAndTime: tableData.dateAndTimeLocation!.toUtc(),
      );
    }

    ClockingEvent clockingEvent = ClockingEvent(
      appVersion: tableData.appVersion,
      companyIdentifier: tableData.companyIdentifier,
      cpf: tableData.cpf,
      dateEvent: tableData.dateEvent,
      platform: tableData.platform,
      signature: tableData.signature,
      signatureVersion: tableData.signatureVersion,
      timeEvent: tableData.timeEvent,
      timeZone: tableData.timeZone,
      use: tableData.use.toString(),
      appointmentImage: tableData.appointmentImage,
      clientOriginInfo: tableData.clientOriginInfo,
      id: tableData.clockingEventId,
      device: device,
      fenceState: tableData.fenceState,
      location: location,
      locationStatus: tableData.locationStatus == tableData.locationStatus
          ? LocationStatusEnum.build(tableData.locationStatus.toString())
          : null,
      mode: tableData.mode.toString(),
      online: tableData.online,
      origin: tableData.origin,
      photoNotCaptured: tableData.photoNotCaptured,      
      isSynchronized: tableData.isSynchronized,
      journeyEventName: tableData.journeyEventName,
      isMealBreak: tableData.isMealBreak,
      facialRecognitionStatus: tableData.facialRecognitionStatus,
      employeeName: tableData.employeeName,
      companyName: tableData.companyName,
      employeeId: tableData.employeeId,
    );

    return clockingEvent;
  }

  @override
  Future<List<ClockingEvent>> convertToClockingEventList({
    required List<ClockingEventTableData> data,
  }) async {
    List<ClockingEvent> dtoList = [];
    if (data.isNotEmpty) {
      for (ClockingEventTableData tableData in data) {
        ClockingEvent clockingEvent = await convertToEntity(tableData: tableData);
        dtoList.add(clockingEvent);
      }
    }

    return dtoList;
  }

  Future<List<ClockingEvent>> convertToDtoListWithEmployee({
    required List<ClockingEventWithEmployee> data,
  }) async {
    List<ClockingEvent> clockingEventList = [];
    if (data.isNotEmpty) {
      for (var tableData in data) {
        ClockingEvent clockingEvent = await convertToEntity(
          tableData: tableData.clockingEventTableData,
          employeeTableData: tableData.employeeTableData,
        );
        clockingEventList.add(clockingEvent);
      }
    }

    return clockingEventList;
  }

  @override
  Future<List<ClockingEvent>> findAllUnsynced({
    int? limit = 100,
  }) async {
    final query = database.select(database.clockingEventTable);
    query.where((tbl) => tbl.isSynchronized.isValue(false));

    if (limit != null) query.limit(limit);

    List<ClockingEventTableData> datas = await query.get();
    return convertToClockingEventList(data: datas);
  }

  @override
  Future<List<ClockingEvent>> findByEmployeesInAndPeriod({
    required DateTime initDate,
    required DateTime endDate,
    required List<String> employeesIds,
    required OrderingModeEnum orderingMode,
  }) async {
    final DateTime localInitDate =
        DateTime(initDate.year, initDate.month, initDate.day, 0, 0, 0);
    final DateTime localEndDate =
        DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59);

    final query = database.select(database.clockingEventTable).join([
      leftOuterJoin(
        database.employeeTable,
        database.employeeTable.id
            .equalsExp(database.clockingEventTable.employeeId),
      ),
    ]);

    query.where(
      database.clockingEventTable.dateTimeEvent.isBiggerOrEqualValue(
        localInitDate,
      ),
    );

    query.where(
      database.clockingEventTable.dateTimeEvent.isSmallerOrEqualValue(
        localEndDate,
      ),
    );

    query.where(database.clockingEventTable.employeeId.isIn(employeesIds));

    query.orderBy(
      [
        OrderingTerm(
          expression: database.clockingEventTable.dateTimeEvent,
          mode: orderingMode == OrderingModeEnum.asc
              ? OrderingMode.asc
              : OrderingMode.desc,
        ),
      ],
    );

    var typedList = await query.get();

    var clockingEventsWithEmployee = typedList.map((row) {
      return ClockingEventWithEmployee(
        clockingEventTableData: row.readTable(database.clockingEventTable),
        employeeTableData: row.readTableOrNull(database.employeeTable),
      );
    }).toList();

    return convertToDtoListWithEmployee(data: clockingEventsWithEmployee);
  }

  @override
  Future<List<ClockingEvent>> findAllByJourneyId({
    required String journeyId,
  }) async {
    final query = database.select(database.clockingEventTable);
    query.where((tbl) => tbl.journeyId.isValue(journeyId));

    List<ClockingEventTableData> datas = await query.get();
    return convertToClockingEventList(data: datas);
  }

  @override
  Future<List<ClockingEvent>> findAllClockingEventByJourneyId({
    required String journeyId,
  }) async {
    final query = database.select(database.clockingEventTable);
    query.where((tbl) => tbl.journeyId.isValue(journeyId));

    List<ClockingEventTableData> events = await query.get();
    return convertToClockingEventList(data: events);
  }

  @override
  Future<void> deleteAllSynced() async {
    final query = database.delete(database.clockingEventTable);
    query.where((tbl) => tbl.isSynchronized.isValue(true));
    await query.go();
  }

  @override
  Future<List<ClockingEvent>> findAll() async {
   var clockingEvents =
        await (database.select(database.clockingEventTable)).get();
    return convertToClockingEventList(data: clockingEvents);
  }
  
  @override
  Future<List<ClockingEventTableData>> deleteByEmployeeIds({
    required List<String> employeeIds,
  }) async {
    final query = database.delete(database.clockingEventTable);
    query.where((tbl) => tbl.isSynchronized.isValue(true));
    query.where((tbl) => tbl.employeeId.isIn(employeeIds));

    return await query.goAndReturn();
  }

 
  Future<Company?> findCompanyById(String companyId) async {
    return await companyRepository.findById(id: companyId);
  }
}

class ClockingEventWithEmployee {
  final ClockingEventTableData clockingEventTableData;
  final EmployeeTableData? employeeTableData;

  ClockingEventWithEmployee({
    required this.clockingEventTableData,
    this.employeeTableData,
  });
}
