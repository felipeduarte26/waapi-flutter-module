import 'package:drift/drift.dart';

import 'schema_versions.dart';
import 'tables/activation_table.dart';
import 'tables/application_table.dart';
import 'tables/clocking_event_table.dart';
import 'tables/clocking_event_use_table.dart';
import 'tables/company_table.dart';
import 'tables/configuration_table.dart';
import 'tables/device_configuration_table.dart';
import 'tables/device_table.dart';
import 'tables/employee_fence_table.dart';
import 'tables/employee_menagers_table.dart';
import 'tables/employee_platform_users_table.dart';
import 'tables/employee_table.dart';
import 'tables/fence_perimeter_table.dart';
import 'tables/fence_table.dart';
import 'tables/global_configuration_table.dart';
import 'tables/journey_table.dart';
import 'tables/logs_table.dart';
import 'tables/manager_platform_users_table.dart';
import 'tables/manager_table.dart';
import 'tables/overnight_table.dart';
import 'tables/perimeter_table.dart';
import 'tables/platform_users_table.dart';
import 'tables/privacy_policy_table.dart';
import 'tables/reminder_table.dart';

part '../../../../../generated/app/collector/core/external/drift/collector_database.g.dart';

@DriftDatabase(
  tables: [
    ConfigurationTable,
    ClockingEventTable,
    CompanyTable,
    FenceTable,
    PerimeterTable,
    EmployeeTable,
    EmployeeFenceTable,
    FencePerimeterTable,
    DeviceTable,
    ActivationTable,
    ApplicationTable,
    DeviceConfigurationTable,
    GlobalConfigurationTable,
    ManagerTable,
    PlatformUsersTable,
    EmployeeManagersTable,
    EmployeePlatformUsersTable,
    ManagersPlatformUsersTable,
    LogsTable,
    ClockingEventUseTable,
    ReminderTable,
    OvernightTable,
    JourneyTable,
    PrivacyPolicyTable,
  ],
)
class CollectorDatabase extends _$CollectorDatabase {
  QueryExecutor database;

  CollectorDatabase({required this.database}) : super(database);

  @override
  int get schemaVersion => 21;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: stepByStep(
        from1To2: (m, schema) async {
          await m.addColumn(employeeTable, employeeTable.arpId);
        },
        from2To3: (m, schema) async {
          await m.addColumn(companyTable, companyTable.arpId);

          await m.addColumn(companyTable, companyTable.caepf);

          await m.addColumn(companyTable, companyTable.cnoNumber);

          await m.alterTable(TableMigration(employeeTable));
        },
        from3To4: (m, schema) async {
          await m.addColumn(employeeTable, employeeTable.enable);

          await m.addColumn(
            configurationTable,
            configurationTable.allowChangeTime,
          );

          await m.addColumn(configurationTable, configurationTable.username);
        },
        from4To5: (m, schema) async {
          await m.createTable(applicationTable);
        },
        from5To6: (m, schema) async {
          await m.addColumn(
            configurationTable,
            configurationTable.faceRecognition,
          );
        },
        from6To7: (Migrator m, Schema7 schema) async {
          await m.createTable(deviceConfigurationTable);
        },
        from7To8: (Migrator m, Schema8 schema) async {
          await m.addColumn(employeeTable, employeeTable.faceRegistered);
        },
        from8To9: (Migrator m, Schema9 schema) async {
          await m.addColumn(employeeTable, employeeTable.employeeCode);
        },
        from9To10: (Migrator m, Schema10 schema) async {
          await m.createTable(globalConfigurationTable);
        },
        from10To11: (Migrator m, Schema11 schema) async {
          await m.addColumn(
            deviceConfigurationTable,
            deviceConfigurationTable.allowChangeTime,
          );
          await m.addColumn(
            deviceConfigurationTable,
            deviceConfigurationTable.enableUserPassword,
          );
        },
        from11To12: (Migrator m, Schema12 schema) async {
          await m.addColumn(
            globalConfigurationTable,
            globalConfigurationTable.takePhotoNfc,
          );

          await m.createTable(managerTable);
          await m.createTable(platformUsersTable);
          await m.createTable(employeeManagersTable);
          await m.createTable(employeePlatformUsersTable);
          await m.createTable(managersPlatformUsersTable);
        },
        from12To13: (m, schema) async {
          await m.createTable(logsTable);
        },
        from13To14: (Migrator m, Schema14 schema) async {
          await m.createTable(clockingEventUseTable);
        },
        from14To15: (Migrator m, Schema15 schema) async {
          await m.createTable(reminderTable);
        },
        from15To16: (Migrator m, Schema16 schema) async {
          await m.addColumn(logsTable, logsTable.createdAt);

          await m.alterTable(
            TableMigration(
              logsTable,
              columnTransformer: {
                logsTable.id: const CustomExpression('date_and_time'),
              },
            ),
          );
        },
        from16To17: (m, schema) async {
          await m.createTable(overnightTable);
          await m.createTable(journeyTable);
          await m.addColumn(configurationTable, configurationTable.overnight);
          await m.addColumn(
            configurationTable,
            configurationTable.controlOvernight,
          );
          await m.addColumn(clockingEventTable, clockingEventTable.journeyId);
          await m.addColumn(clockingEventTable, clockingEventTable.isMealBreak);
          await m.addColumn(
            clockingEventTable,
            clockingEventTable.journeyEventName,
          );
          await m.addColumn(
            clockingEventTable,
            clockingEventTable.employeeName,
          );
          await m.addColumn(clockingEventTable, clockingEventTable.companyName);
        },
        from17To18: (Migrator m, Schema18 schema) async {
          await m.createTable(privacyPolicyTable);
        },
        from18To19: (Migrator m, Schema19 schema) async {
          await m.addColumn(
            clockingEventTable,
            clockingEventTable.facialRecognitionStatus,
          );
        },
        from19To20: (Migrator m, Schema20 schema) async {
          await migrateFromUnixTimestampsToText(m);
        },
        from20To21: (Migrator m, Schema21 schema) async {
          await m.addColumn(configurationTable, configurationTable.gps);
          await m.addColumn(
            configurationTable,
            configurationTable.deviceAuthorizationType,
          );
          await m.addColumn(
            configurationTable,
            configurationTable.allowDrivingTime,
          );
          await m.addColumn(
            configurationTable,
            configurationTable.allowGpoOnApp,
          );
          await m.addColumn(
            configurationTable,
            configurationTable.exportNotChecked,
          );
          await m.addColumn(
            configurationTable,
            configurationTable.insightOutOfBound,
          );
          await m.addColumn(
            configurationTable,
            configurationTable.openExternalBrowser,
          );
          await m.addColumn(configurationTable, configurationTable.allowUse);
          await m.addColumn(
            configurationTable,
            configurationTable.externalControlTimezone,
          );
          await m.addColumn(configurationTable, configurationTable.nfcMode);
          await m.addColumn(
            configurationTable,
            configurationTable.takePhotoNfc,
          );
          await m.addColumn(
            configurationTable,
            configurationTable.takePhotoSingle,
          );
          await m.addColumn(
            configurationTable,
            configurationTable.takePhotoDriver,
          );
          await m.addColumn(
            configurationTable,
            configurationTable.takePhotoQrcode,
          );
        },
      ),
    );
  }

  Future<void> migrateFromUnixTimestampsToText(Migrator m) async {
    for (final table in allTables) {
      final dateTimeColumns =
          table.$columns.where((c) => c.type == DriftSqlType.dateTime);

      if (dateTimeColumns.isNotEmpty) {
        await m.alterTable(
          TableMigration(
            table,
            columnTransformer: {
              for (final column in dateTimeColumns)
                column:
                    DateTimeExpressions.fromUnixEpoch(column.dartCast<int>()),
            },
          ),
        );
      }
    }
  }
}
