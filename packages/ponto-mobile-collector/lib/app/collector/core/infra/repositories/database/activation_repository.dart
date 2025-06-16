import 'package:intl/intl.dart';
import '../../../../../../ponto_mobile_collector.dart';
import '../../../domain/entities/activation.dart';
import '../../../domain/enums/activation_situation_type.dart';
import '../../../domain/enums/status_device.dart';
import '../../../external/drift/collector_database.dart';

class ActivationRepository implements IActivationRepository {
  CollectorDatabase database;

  ActivationRepository({required this.database});

  @override
  Future<bool> exist({
    required String employeeId,
  }) async {
    final query = database.select(database.activationTable);
    query.where((tbl) => tbl.employeeId.equals(employeeId));
    ActivationTableData? tableData = await query.getSingleOrNull();
    return tableData != null;
  }

  @override
  Future<int> insert({
    required Activation activation,
    required String employeeId,
  }) async {
    ActivationTableData tableData = convertToTable(
      activation: activation,
      employeeId: employeeId,
    );
    return database.into(database.activationTable).insert(tableData);
  }

  @override
  Future<bool> update({
    required Activation activation,
    required String employeeId,
  }) async {
    ActivationTableData tableData = convertToTable(
      activation: activation,
      employeeId: employeeId,
    );
    return database.update(database.activationTable).replace(tableData);
  }

  @override
  Future<bool> save({
    required Activation activation,
    required String employeeId,
  }) async {
    return (await exist(employeeId: employeeId))
        ? await update(activation: activation, employeeId: employeeId)
        : (await insert(activation: activation, employeeId: employeeId)) > 0;
  }

  @override
  Future<Activation?> findByEmployeeId({
    required String employeeId,
  }) async {
    ActivationTableData? tableData =
        await (database.select(database.activationTable)
              ..where((tbl) => tbl.employeeId.equals(employeeId)))
            .getSingleOrNull();
    if (tableData == null) {
      return null;
    } else {
      return convertToDto(tableData: tableData);
    }
  }

  @override
  Future<List<Activation>> getAll() async {
    List<ActivationTableData> tableDatas =
        await database.select(database.activationTable).get();
    List<Activation> activations = [];

    for (ActivationTableData tableData in tableDatas) {
      activations.add(convertToDto(tableData: tableData));
    }

    return Future.value(activations);
  }

  @override
  Future<void> deleteByEmployeeIds({
    required List<String> employeeIds,
  }) async {
    final query = database.delete(database.activationTable);
    query.where((tbl) => tbl.employeeId.isIn(employeeIds));

    await query.go();
  }

  ActivationTableData convertToTable({
    required Activation activation,
    required String employeeId,
  }) {
    ActivationTableData activationData = ActivationTableData(
      deviceSituation: activation.deviceSituation.value,
      employeeSituation: activation.employeeSituation.value,
      requestDateTime:
          DateTime.parse('${activation.requestDate} ${activation.requestTime}'),
      employeeId: employeeId,
    );

    return activationData;
  }

  Activation convertToDto({required ActivationTableData tableData}) {
    return Activation(
      id: tableData.employeeId,
      deviceSituation: StatusDevice.build(tableData.deviceSituation),
      employeeSituation:
          ActivationSituationType.build(tableData.employeeSituation),
      requestDate: DateFormat('yyyy-MM-dd').format(tableData.requestDateTime),
      requestTime: DateFormat('HH:mm:ss').format(tableData.requestDateTime),
    );
  }
}
