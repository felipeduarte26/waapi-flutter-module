import 'package:drift/drift.dart';

import '../../../../../../ponto_mobile_collector.dart';
import '../../../domain/entities/company.dart';
import '../../../domain/entities/fence.dart';
import '../../../domain/entities/manager_employee.dart';
import '../../../domain/entities/perimeter.dart';
import '../../../domain/entities/platform_user.dart';
import '../../../domain/entities/reminder.dart';
import '../../../domain/repositories/database/iemployee_platform_user_repository.dart';
import '../../../domain/repositories/database/imanager_employee_repository.dart';
import '../../../domain/repositories/database/imanager_repository.dart';
import '../../../domain/repositories/database/iplatform_user_repository.dart';
import '../../../domain/repositories/database/ireminder_repository.dart';
import '../../../external/drift/collector_database.dart';

class EmployeeRepository implements IEmployeeRepository {
  CollectorDatabase database;
  final ICompanyRepository companyRepository;
  final IFenceRepository fenceRepository;
  final IManagerRepository managerRepository;
  final IManagerEmployeeRepository managerEmployeeRepository;
  final IEmployeeFenceRepository employeeFenceRepository;
  final IPlatformUserRepository platformUserRepository;
  final IEmployeePlatformUserRepository employeePlatformUserRepository;
  final IReminderRepository reminderRepository;
  final IPerimeterRepository perimeterRepository;
  final IManagerPlatformUserRepository managerPlatformUserRepository;
  final IConfigurationRepository configurationRepository;
  final IFencePerimeterRepository fencePerimeterRepository;

  EmployeeRepository({
    required this.database,
    required this.companyRepository,
    required this.employeeFenceRepository,
    required this.fenceRepository,
    required this.managerRepository,
    required this.managerEmployeeRepository,
    required this.platformUserRepository,
    required this.employeePlatformUserRepository,
    required this.reminderRepository,
    required this.perimeterRepository,
    required this.managerPlatformUserRepository,
    required this.configurationRepository,
    required this.fencePerimeterRepository,
  });

  @override
  Future<bool> exist({
    String? employeeId,
  }) async {
    if (employeeId == null) {
      return false;
    }
    final query = database.select(database.employeeTable);
    query.where((tbl) => tbl.id.equals(employeeId));
    EmployeeTableData? tableData = await query.getSingleOrNull();
    return tableData != null;
  }

  @override
  Future<int> insert({
    required Employee employee,
  }) async {
    EmployeeTableData dataTable = convertToTable(
      employee: employee,
    );

    return database.into(database.employeeTable).insert(dataTable);
  }

  @override
  Future<bool> update({
    required Employee employee,
  }) async {
    EmployeeTableData dataTable = convertToTable(
      employee: employee,
    );

    return database.update(database.employeeTable).replace(dataTable);
  }

  @override
  Future<bool> save({
    required Employee employee,
  }) async {
    // Save employee
    (await exist(employeeId: employee.id))
        ? await update(employee: employee)
        : await insert(employee: employee);

    // Save company
    await companyRepository.save(
      company: employee.company,
    );

    // Save Fences
    if (employee.fences != null && employee.fences!.isNotEmpty) {
      for (Fence fence in employee.fences!) {
        await fenceRepository.save(fence: fence);
        await employeeFenceRepository.save(
          employeeId: employee.id,
          fenceId: fence.id ?? '',
        );
      }
    }

    // Save Managers
    if (employee.managerEmployees != null &&
        employee.managerEmployees!.isNotEmpty) {
      for (ManagerEmployee manager in employee.managerEmployees!) {
        await managerRepository.save(
          managerDto: manager,
        );
        await managerEmployeeRepository.save(
          employeeId: employee.id,
          managerId: manager.id.toString(),
        );
      }
    }

    // Save Reminders
    if (employee.reminders != null && employee.reminders!.isNotEmpty) {
      for (Reminder reminder in employee.reminders!) {
        await reminderRepository.save(reminder: reminder);
      }
    }

    // Save PlatformUsers
    if (employee.platformUsers != null && employee.platformUsers!.isNotEmpty) {
      for (PlatformUser user in employee.platformUsers!) {
        await platformUserRepository.save(platformUser: user);

        await employeePlatformUserRepository.save(
          employeeId: employee.id,
          platformUserId: user.id!,
        );
      }
    }

    return true;
  }

  @override
  Future<Employee?> findById({
    required String id,
  }) async {
    EmployeeTableData? tableData =
        await (database.select(database.employeeTable)
              ..where((tbl) => tbl.id.equals(id)))
            .getSingleOrNull();

    return await loadComplementAndConvertToEmployee(tableData);
  }

  @override
  Future<List<Employee>?> findByIds({
    required List<String> ids,
  }) async {
    List<EmployeeTableData>? tableData =
        await (database.select(database.employeeTable)
              ..where((tbl) => tbl.id.isIn(ids)))
            .get();
    List<Employee>? employees = [];

    for (EmployeeTableData item in tableData) {
      var employee = await loadComplementAndConvertToEmployee(item);
      if (employee != null) {
        employees.add(employee);
      }
    }
    return employees;
  }

  @override
  Future<Employee?> findByIdAndEnabled({
    required String id,
  }) async {
    EmployeeTableData? tableData =
        await (database.select(database.employeeTable)
              ..where((tbl) => tbl.id.equals(id) & tbl.enable.equals(true)))
            .getSingleOrNull();

    return await loadComplementAndConvertToEmployee(tableData);
  }

  @override
  Future<Employee?> findByMail({
    required String mail,
  }) async {
    EmployeeTableData? tableData =
        await (database.select(database.employeeTable)
              ..where((tbl) => tbl.mail.equals(mail)))
            .getSingleOrNull();

    return loadComplementAndConvertToEmployee(tableData);
  }

  @override
  Future<Employee?> findByCpf({
    required String cpf,
  }) async {
    EmployeeTableData? tableData =
        await (database.select(database.employeeTable)
              ..where((tbl) => tbl.cpfNumber.equals(cpf)))
            .getSingleOrNull();

    return loadComplementAndConvertToEmployee(tableData);
  }

  @override
  Future<List<Employee>?> findByName({
    required String name,
  }) async {
    var future = await (database.select(database.employeeTable)
          ..where((tbl) => tbl.name.contains('%$name%')))
        .get();
    List<Employee> employees = [];
    for (EmployeeTableData tableData in future) {
      employees.add((await loadComplementAndConvertToEmployee(tableData))!);
    }
    return employees;
  }

  @override
  Future<Employee?> findByEmployeeCodeAndEnable({
    required String employeeCode,
  }) async {
    final query = database.select(database.employeeTable);
    query.where((tbl) => tbl.employeeCode.equals(employeeCode));
    query.where((tbl) => tbl.enable.equals(true));
    EmployeeTableData? tableData = await query.getSingleOrNull();
    return loadComplementAndConvertToEmployee(tableData);
  }

  @override
  Future<Employee?> findByNfcCodeAndEnable({
    required String nfcCode,
  }) async {
    final query = database.select(database.employeeTable);
    query.where((tbl) => tbl.nfcCode.equals(nfcCode));
    query.where((tbl) => tbl.enable.equals(true));
    EmployeeTableData? tableData = await query.getSingleOrNull();
    return loadComplementAndConvertToEmployee(tableData);
  }

  @override
  Future<void> deleteAll() async {
    await database.delete(database.employeeTable).go();
    await database.delete(database.employeePlatformUsersTable).go();
    await database.delete(database.platformUsersTable).go();
    await database.delete(database.employeeFenceTable).go();
    await database.delete(database.fenceTable).go();
    await database.delete(database.fencePerimeterTable).go();
    await database.delete(database.employeeManagersTable).go();
    await database.delete(database.managerTable).go();
    await database.delete(database.managersPlatformUsersTable).go();
  }

  @override
  Future<List<Employee>> getAll() async {
    List<EmployeeTableData> tableData = await database
        .select(
          database.employeeTable,
        )
        .get();

    List<Employee> employees = [];
    for (EmployeeTableData tableData in tableData) {
      employees.add((await loadComplementAndConvertToEmployee(tableData))!);
    }

    return employees;
  }

  @override
  Future<List<EmployeeTableData>> getAllEnabled() async {
    final query = database.select(database.employeeTable);
    query.where((tbl) => tbl.enable.equals(true));

    return await query.get();
  }

  @override
  Future<List<EmployeeTableData>> getAllDisabled() async {
    final query = database.select(database.employeeTable);
    query.where((tbl) => tbl.enable.equals(false));

    return await query.get();
  }

  @override
  Future<void> deleteByIds({
    required List<String> ids,
  }) async {
    final query = database.delete(database.employeeTable);
    query.where((tbl) => tbl.id.isIn(ids));

    await query.go();
  }

  @override
  EmployeeTableData convertToTable({
    required Employee employee,
  }) {
    EmployeeTableData tableData = EmployeeTableData(
      companyId: employee.company.id ??
          '', // TO DO: verificar se está correto para id nullable
      cpfNumber: employee.cpf,
      employeeType: employee.employeeType.toString(),
      id: employee.id,
      name: employee.name!,
      registrationNumber: employee.registrationNumber,
      mail: employee.mail,
      nfcCode: employee.nfcCode,
      arpId: employee.arpId,
      enable: employee.enable,
      faceRegistered: employee.faceRegistered,
      employeeCode: employee.employeeCode,
    );

    return tableData;
  }

  @override
  Future<List<Employee?>> findByFaceRegisteredNotEmpty() async {
    var future = await (database.select(database.employeeTable)
          ..where((tbl) => tbl.faceRegistered.isNotNull()))
        .get();

    return Future.wait(
      future.map((e) async {
        return loadComplementAndConvertToEmployee(e);
      }),
    );
  }

  @override
  Future<bool> updateFaceRegisteredByEmployeeId({
    required String employeeId,
  }) async {
    var updateStatement = database.update(database.employeeTable)
      ..where((tbl) => tbl.id.equals(employeeId));
    var write = await updateStatement.write(
      EmployeeTableCompanion(
        faceRegistered: Value(employeeId.replaceAll('-', '')),
      ),
    );
    return write > 0;
  }

  /// Find employee by Enable and faceRegistered e Face Enabled.
  @override
  Future<Employee?> findByFaceRegistered({
    required String faceRegistered,
  }) async {
    final queryEmployee = database.select(database.employeeTable);
    queryEmployee.where((tbl) => tbl.faceRegistered.equals(faceRegistered));
    queryEmployee.where((tbl) => tbl.enable.equals(true));
    EmployeeTableData? tableData = await queryEmployee.getSingleOrNull();

    if (tableData == null) {
      return null;
    }

    final queryConfigurarion = database.select(database.configurationTable);
    queryConfigurarion.where((tbl) => tbl.employeeId.equals(tableData.id));
    queryConfigurarion.where((tbl) => tbl.faceRecognition.equals(true));
    ConfigurationTableData? configurationTableData =
        await queryConfigurarion.getSingleOrNull();

    if (configurationTableData == null) {
      return null;
    }

    return loadComplementAndConvertToEmployee(tableData);
  }

  @override
  Future<List<Employee>> findEmployeesByManager({
    required String managerId,
  }) async {
    List<Employee> employees = [];
    List<EmployeeManagersTableData> managerEmployees =
        await (database.select(database.employeeManagersTable)
              ..where((tbl) => tbl.managerId.equals(managerId)))
            .get();

    var employeesByManager = managerEmployees.map((e) => e.employeeId).toList();
    Employee? employee;
    for (var employeeId in employeesByManager) {
      var employeeById = await findById(
        id: employeeId,
      );
      if (employeeById != null) {
        employee = employeeById;
      }

      if (employee != null) {
        employees.add(employee);
      }
    }
    return employees;
  }

  @override
  Future<Employee?> findFirst() async {
    var simpleSelectStatement = database.select(database.employeeTable)
      ..limit(1);
    var employee = await simpleSelectStatement.getSingleOrNull();
    return loadComplementAndConvertToEmployee(employee);
  }

  @override
  Future<int> disableAll() async {
    var update = database.update(database.employeeTable);

    return await update.write(
      const EmployeeTableCompanion(
        enable: Value(false),
      ),
    );
  }

  Future<Employee?> loadComplementAndConvertToEmployee(
    EmployeeTableData? tableData,
  ) async {
    if (tableData == null) {
      return null;
    }

    Company company = (await companyRepository.findById(
      id: tableData.companyId,
    ))!;

    List<Fence>? fences = await fenceRepository.findAllByEmployeeId(
      employeeId: tableData.id,
    );

    return convertToEmployee(
      tableData: tableData,
      company: company,
      fences: fences,
    );
  }

  @override
  Future<bool> saveEmployeeBatch({
    required List<Employee> employees,
  }) async {
    List<EmployeeTableData> employeesTableData = [];
    List<CompanyTableData> companiesTableData = [];
    List<ConfigurationTableData> configurationTableData = [];
    List<FenceTableData> fencesTableData = [];
    List<PerimeterTableData> perimetersTableData = [];
    List<ManagerTableData> managersTableData = [];
    List<PlatformUsersTableData> platformUsersTableData = [];
    List<ReminderTableData> reminderTableData = [];
    List<EmployeeManagersTableData> employeeManagersRelations = [];
    List<EmployeeFenceTableData> employeeFenceRelations = [];
    List<ManagersPlatformUsersTableData> managersPlatformUsersRelations = [];
    List<EmployeePlatformUsersTableData> employeePlatformUsersRelations = [];
    List<FencePerimeterTableData> fencePerimeterRelations = [];

    try {
      for (Employee employee in employees) {
        employeesTableData.add(convertToTable(employee: employee));
        companiesTableData.add(companyRepository.convertToTable(company: employee.company));

        if (employee.configuration != null) {
          configurationTableData.add(
            configurationRepository.convertToTable(
              config: employee.configuration!,
              employeeId: employee.id,
            ),
          );
        }

        for (final Fence fence in employee.fences ?? []) {
          fencesTableData.add(fenceRepository.convertToTable(fence: fence));
          employeeFenceRelations.add(
            employeeFenceRepository.convertToTable(
              employeeId: employee.id,
              fenceId: fence.id!,
            ),
          );
          for (final Perimeter perimeter in fence.perimeters ?? []) {
            perimetersTableData.add(
              perimeterRepository.convertToTable(perimeter: perimeter),
            );
            fencePerimeterRelations.add(
              fencePerimeterRepository.convertToTable(
                fenceId: fence.id!,
                perimeterId: perimeter.id!,
              ),
            );
          }
        }

        for (final ManagerEmployee manager in employee.managerEmployees ?? []) {
          managersTableData.add(
            managerRepository.convertToTable(manager: manager),
          );
          employeeManagersRelations.add(
            managerEmployeeRepository.convertToTable(
              employeeId: employee.id,
              managerId: manager.id!,
            ),
          );

          for (final PlatformUser user in manager.platformUsers ?? []) {
            platformUsersTableData.add(
              platformUserRepository.convertToTable(platformUser: user),
            );
            managersPlatformUsersRelations.add(
              managerPlatformUserRepository.convertToTable(
                managerId: manager.id!,
                platforUserId: user.id!,
              ),
            );
          }
        }

        for(final Reminder reminder in employee.reminders ?? []) {
          reminderTableData.add(
            reminderRepository.convertToTable(
              reminder: reminder,
            ),
          );
        }

        for (final PlatformUser user in employee.platformUsers ?? []) {
          platformUsersTableData.add(
            platformUserRepository.convertToTable(platformUser: user),
          );
          employeePlatformUsersRelations.add(
            employeePlatformUserRepository.convertToTable(
              employeeId: employee.id,
              platformUserId: user.id!,
            ),
          );
        }
      }

      await database.batch((batch) {
        _insertIfNotEmpty(
          batch: batch,
          data: employeesTableData,
          table: database.employeeTable,
          toCompanion: (e) => e.toCompanion(true),
        );
        _insertIfNotEmpty(
          batch: batch,
          data: companiesTableData,
          table: database.companyTable,
          toCompanion: (e) => e.toCompanion(true),
        );
        _insertIfNotEmpty(
          batch: batch,
          data: configurationTableData,
          table: database.configurationTable,
          toCompanion: (e) => e.toCompanion(true),
        );
        _insertIfNotEmpty(
          batch: batch,
          data: fencesTableData,
          table: database.fenceTable,
          toCompanion: (e) => e.toCompanion(true),
        );
        _insertIfNotEmpty(
          batch: batch,
          data: perimetersTableData,
          table: database.perimeterTable,
          toCompanion: (e) => e.toCompanion(true),
        );
        _insertIfNotEmpty(
          batch: batch,
          data: managersTableData,
          table: database.managerTable,
          toCompanion: (e) => e.toCompanion(true),
        );
        _insertIfNotEmpty(
          batch: batch,
          data: reminderTableData,
          table: database.reminderTable,
          toCompanion: (e) => e.toCompanion(true),
        );
        _insertIfNotEmpty(
          batch: batch,
          data: platformUsersTableData,
          table: database.platformUsersTable,
          toCompanion: (e) => e.toCompanion(true),
        );
        _insertIfNotEmpty(
          batch: batch,
          data: employeeManagersRelations,
          table: database.employeeManagersTable,
          toCompanion: (e) => e.toCompanion(true),
        );
        _insertIfNotEmpty(
          batch: batch,
          data: employeeFenceRelations,
          table: database.employeeFenceTable,
          toCompanion: (e) => e.toCompanion(true),
        );
        _insertIfNotEmpty(
          batch: batch,
          data: managersPlatformUsersRelations,
          table: database.managersPlatformUsersTable,
          toCompanion: (e) => e.toCompanion(true),
        );
        _insertIfNotEmpty(
          batch: batch,
          data: employeePlatformUsersRelations,
          table: database.employeePlatformUsersTable,
          toCompanion: (e) => e.toCompanion(true),
        );
        _insertIfNotEmpty(
          batch: batch,
          data: fencePerimeterRelations,
          table: database.fencePerimeterTable,
          toCompanion: (e) => e.toCompanion(true),
        );
      });
    } catch (e) {
      print('Error saving batch: $e');
      return false;
    }

    return true;
  }

  @override
  Employee convertToEmployee({
    required EmployeeTableData tableData,
    required Company company,
    required List<Fence> fences,
  }) {
    Employee employee = Employee(
      company: company,
      cpf: tableData.cpfNumber,
      id: tableData.id,
      mail: tableData.mail,
      name: tableData.name,
      registrationNumber: tableData.registrationNumber,
      employeeType: tableData.employeeType.toString(),
      nfcCode: tableData.nfcCode,
      fences: fences,
      arpId: tableData.arpId,
      enable: tableData.enable,
      faceRegistered: tableData.faceRegistered,
      employeeCode: tableData.employeeCode,
    );

    return employee;
  }

  void _insertIfNotEmpty<T>({
    required Batch batch,
    required List<T> data,
    required TableInfo<Table, dynamic> table,
    required Insertable Function(T) toCompanion,
  }) {
    if (data.isNotEmpty) {
      batch.insertAllOnConflictUpdate(
        table,
        data.map(toCompanion),
      );
    }
  }
}
