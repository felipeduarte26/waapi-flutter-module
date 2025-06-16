import 'package:drift/drift.dart';

import '../../../domain/entities/privacy_policy_entity.dart';
import '../../../domain/repositories/database/privacy_policy_repository.dart';
import '../../../external/drift/collector_database.dart';

class PrivacyPolicyRepositoryImpl implements PrivacyPolicyRepository {
  CollectorDatabase database;

  PrivacyPolicyRepositoryImpl({
    required this.database,
  });

  @override
  Future<bool> exist({
    required int version,
  }) async {
    final query = database.select(database.privacyPolicyTable);
    query.where((tbl) => tbl.version.equals(version));
    PrivacyPolicyTableData? tableData = await query.getSingleOrNull();
    return tableData != null;
  }

  @override
  Future<PrivacyPolicyEntity?> getLastVersionSaved() async {
    final query = database.select(database.privacyPolicyTable);
    query.orderBy(
      [
        (tbl) => OrderingTerm(
              expression: tbl.dateTimeCreated,
              mode: OrderingMode.desc,
            ),
      ],
    );
    List<PrivacyPolicyTableData?> tableData = await query.get();

    if (tableData.isNotEmpty && tableData.first != null) {
      return convertToEntity(tableData: tableData.first!);
    }
    return null;
  }

  @override
  Future<PrivacyPolicyEntity?> findByVersion({
    required int version,
  }) async {
    final query = database.select(database.privacyPolicyTable);
    query.where((tbl) => tbl.version.equals(version));
    PrivacyPolicyTableData? tableData = await query.getSingleOrNull();
    if (tableData != null) {
      return convertToEntity(tableData: tableData);
    }
    return null;
  }

  @override
  Future<int> insert({
    required PrivacyPolicyEntity privacyPolicy,
  }) async {
    PrivacyPolicyTableData dataTable = convertToTable(
      privacyPolicy: privacyPolicy,
    );

    return database.into(database.privacyPolicyTable).insert(dataTable);
  }

  @override
  Future<bool> update({
    required PrivacyPolicyEntity privacyPolicy,
  }) async {
    PrivacyPolicyTableData dataTable = convertToTable(
      privacyPolicy: privacyPolicy,
    );

    return database.update(database.privacyPolicyTable).replace(dataTable);
  }

  @override
  Future<bool> save({
    required PrivacyPolicyEntity privacyPolicy,
  }) async {
    (await exist(version: privacyPolicy.version))
        ? await update(privacyPolicy: privacyPolicy)
        : await insert(privacyPolicy: privacyPolicy);
    return true;
  }

  @override
  PrivacyPolicyTableData convertToTable({
    required PrivacyPolicyEntity privacyPolicy,
  }) {
    PrivacyPolicyTableData tableData = PrivacyPolicyTableData(
      version: privacyPolicy.version,
      dateTimeEventRead: privacyPolicy.dateTimeEventRead,
      dateTimeCreated: privacyPolicy.dateTimeEventCreated,
      urlVersion: privacyPolicy.urlVersion,
    );

    return tableData;
  }

  @override
  PrivacyPolicyEntity convertToEntity({
    required PrivacyPolicyTableData tableData,
  }) {
    PrivacyPolicyEntity privacyPolicy = PrivacyPolicyEntity(
      version: tableData.version,
      dateTimeEventRead: tableData.dateTimeEventRead,
      dateTimeEventCreated: tableData.dateTimeCreated,
      urlVersion: tableData.urlVersion,
    );
    return privacyPolicy;
  }
}
