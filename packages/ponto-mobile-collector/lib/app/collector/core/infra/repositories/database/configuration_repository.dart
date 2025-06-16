
import '../../../domain/entities/configuration.dart';
import '../../../domain/enums/operation_mode_type.dart';
import '../../../domain/repositories/database/iconfiguration_repository.dart';
import '../../../external/drift/collector_database.dart';

class ConfigurationRepository implements IConfigurationRepository {
  CollectorDatabase database;

  ConfigurationRepository({required this.database});

  @override
  Future<bool> exist({required String employeeId}) async {
    String? tableData = await (database.select(database.configurationTable)
          ..where((tbl) => tbl.employeeId.equals(employeeId)))
        .map((p0) => p0.employeeId)
        .getSingleOrNull();
    return tableData != null;
  }

  @override
  Future<int> insert({
    required Configuration config,
    required String employeeId,
    String? username,
  }) async {
    ConfigurationTableData configTable = convertToTable(
      config: config,
      employeeId: employeeId,
      username: username,
    );

    return database.into(database.configurationTable).insert(configTable);
  }

  @override
  Future<bool> update({
    required Configuration config,
    required String employeeId,
    String? username,
  }) async {
    if (username == null) {
      var old = await findByEmployeeId(employeeId: employeeId);

      if (old != null) {
        username = old.username;
      }
    }

    ConfigurationTableData configTable = convertToTable(
      config: config,
      employeeId: employeeId,
      username: username,
    );

    return database.update(database.configurationTable).replace(configTable);
  }

  @override
  Future<bool> save({
    required Configuration config,
    required String employeeId,
    String? username,
  }) async {
    if (await exist(employeeId: employeeId)) {
      await update(
        config: config,
        employeeId: employeeId,
        username: username,
      );
    } else {
      await insert(
        config: config,
        employeeId: employeeId,
        username: username,
      );
    }

    return true;
  }

  @override
  Future<List<Configuration>> getAll() async {
    return Future.value(
      convertToDtoList(
        tableDatas: await database.select(database.configurationTable).get(),
      ),
    );
  }

  List<Configuration> convertToDtoList({
    required List<ConfigurationTableData> tableDatas,
  }) {
    List<Configuration> configs = [];

    for (ConfigurationTableData tableData in tableDatas) {
      configs.add(converToDto(tableData: tableData));
    }
    return configs;
  }

  @override
  Future<Configuration?> findByEmployeeId({
    required String employeeId,
  }) async {
    final query = database.select(database.configurationTable);
    query.where((tbl) => tbl.employeeId.equals(employeeId));

    ConfigurationTableData? tableData = await query.getSingleOrNull();
    return tableData == null ? null : converToDto(tableData: tableData);
  }

  @override
  Future<Configuration?> findByUsername({
    required String username,
  }) async {
    final query = database.select(database.configurationTable);
    query.where((tbl) => tbl.username.equals(username));

    ConfigurationTableData? tableData = await query.getSingleOrNull();
    return tableData == null ? null : converToDto(tableData: tableData);
  }

  @override
  Future<String?> findIdByUsername({
    required String username,
  }) async {
    final query = database.select(database.configurationTable);
    query.where((tbl) => tbl.username.equals(username));

    ConfigurationTableData? tableData = await query.getSingleOrNull();
    return tableData?.employeeId;
  }

  @override
  Future<void> deleteByEmployeeIds({
    required List<String> employeeIds,
  }) async {
    final query = database.delete(database.configurationTable);
    query.where((tbl) => tbl.employeeId.isIn(employeeIds));

    await query.go();
  }

  @override
  ConfigurationTableData convertToTable({
    required Configuration config,
    required String employeeId,
    String? username,
  }) {
    ConfigurationTableData tableData = ConfigurationTableData(
      employeeId: employeeId,
      onlyOnline: config.onlyOnline,
      operationMode: config.operationMode.value,
      timezone: config.timezone,
      takePhoto: config.takePhoto,
      allowChangeTime: config.allowChangeTime,
      faceRecognition: config.faceRecognition,
      username: username,
      overnight: config.overnight,
      controlOvernight: config.controlOvernight,
      allowDrivingTime: config.allowDrivingTime,
      allowGpoOnApp: config.allowGpoOnApp,
      allowUse: config.allowUse,
      gps: config.gps,
      deviceAuthorizationType: config.deviceAuthorizationType,
      exportNotChecked: config.exportNotChecked,
      openExternalBrowser: config.openExternalBrowser,
      externalControlTimezone: config.externalControlTimezone,
      nfcMode: config.nfcMode,
      takePhotoNfc: config.takePhotoNfc,
      takePhotoDriver: config.takePhotoDriver,
      takePhotoQrcode: config.takePhotoQrcode,
      takePhotoSingle: config.takePhotoSingle,
    );

    return tableData;
  }

  @override
  Configuration converToDto({
    required ConfigurationTableData tableData,
  }) {
    Configuration loginConfigurationDTO =
        Configuration(
      id: tableData.employeeId,
      onlyOnline: tableData.onlyOnline,
      operationMode: OperationModeType.build(tableData.operationMode.toString()),
      takePhoto: tableData.takePhoto,
      timezone: tableData.timezone,
      allowChangeTime: tableData.allowChangeTime,
      faceRecognition: tableData.faceRecognition,
      overnight: tableData.overnight,
      username: tableData.username,
      controlOvernight: tableData.controlOvernight,
      allowDrivingTime: tableData.allowDrivingTime,
      allowGpoOnApp: tableData.allowGpoOnApp,
      allowUse: tableData.allowUse,
      gps: tableData.gps,
      deviceAuthorizationType: tableData.deviceAuthorizationType,
      exportNotChecked: tableData.exportNotChecked,
      openExternalBrowser: tableData.openExternalBrowser,
      externalControlTimezone: tableData.externalControlTimezone,
      nfcMode: tableData.nfcMode,
      takePhotoNfc: tableData.takePhotoNfc,
      takePhotoDriver: tableData.takePhotoDriver,
      takePhotoQrcode: tableData.takePhotoQrcode,
      takePhotoSingle: tableData.takePhotoSingle,
    );

    return loginConfigurationDTO;
  }
}
