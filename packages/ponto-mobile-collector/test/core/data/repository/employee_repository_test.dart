import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/company.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/fence.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/perimeter.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/geometric_form_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/location_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/drift/collector_database.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/repositories/database/employee_platform_user_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/repositories/database/manager_employee_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/repositories/database/manager_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/repositories/database/platform_user_repository.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:test/test.dart';

import '../../../mocks/manager_employee_dto_mock.dart';
import '../../../mocks/manager_employee_entity_mock.dart';

class MockCompanyRepository extends Mock implements ICompanyRepository {}

class MockFenceRepository extends Mock implements IFenceRepository {}

class MockEmployeePlatformUserRepository extends Mock
    implements EmployeePlatformUserRepository {}

class MockManagerEmployeeRepositoryRepository extends Mock
    implements ManagerEmployeeRepository {}

class MockPlatformUserRepository extends Mock
    implements PlatformUserRepository {}

class MockManagerRepository extends Mock implements ManagerRepository {}

class MockEmployeeFenceRepository extends Mock
    implements IEmployeeFenceRepository {}

void main() {
  late EmployeeRepository repository;
  late CollectorDatabase database;
  late ICompanyRepository mockCompanyRepository;
  late IEmployeeFenceRepository mockEmployeeFenceRepository;
  late IFenceRepository mockFenceRepository;
  late EmployeePlatformUserRepository employeePlatformUserRepository;
  late ManagerEmployeeRepository managerEmployeeRepository;
  late PlatformUserRepository platformUserRepository;
  late ManagerRepository managerRepository;

  Company company = const Company(
    cnpj: '21997329000149',
    name: 'Company Teste 1',
    timeZone: '+03:00',
    id: 'a3458e7a-581a-4e7b-8d0c-401ba25e18c5',
  );

  LocationDto location = LocationDto(
    dateAndTime: DateTime.now(),
    latitude: 2.0,
    longitude: 3.0,
  );

  Perimeter perimeter = Perimeter(
    id: 'a8cd0d1e-2af3-4d04-9298-a93d0d1ddf3b',
    radius: 3.0,
    startPoint: location,
    type: GeometricFormType.circle,
  );

  Fence fence = Fence(
    id: 'ac062ab1-62eb-4961-bc04-9df781cc49b5',
    name: 'Fence Teste 1',
    perimeters: [perimeter],
  );

  Employee employee1 = Employee(
    company: company,
    cpf: '49737807073',
    employeeType: '',
    id: 'dec52c53-81c0-438a-bdad-051d7cb1ac2f',
    name: 'Employee Teste 1',
    registrationNumber: '1',
    fences: [fence],
    mail: 'employee1@email.com',
    nfcCode: '645834536534',
    arpId: 'arpId',
    faceRegistered: 'dec52c53-81c0438abdad051d7cb1ac2f',
    employeeCode: '123456789',
    managerEmployees: [managerEntityMock],
    enable: true,
  );

  Employee employee2 = Employee(
    company: company,
    cpf: '49737807073',
    employeeType: '',
    id: 'dec52c53-81c0-438a-bdad-051d7cb1ac2f',
    name: 'Employee Teste 1',
    registrationNumber: '1',
    fences: [fence],
    mail: 'employee1@email.com',
    nfcCode: '645834536534',
    arpId: 'arpId',
    faceRegistered: 'dec52c53-81c0438abdad051d7cb1ac2f',
    employeeCode: '123456789',
    managerEmployees: [managerEntityMock],
    enable: false,
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
      mockCompanyRepository = MockCompanyRepository();
      mockEmployeeFenceRepository = MockEmployeeFenceRepository();
      mockFenceRepository = MockFenceRepository();
      employeePlatformUserRepository = MockEmployeePlatformUserRepository();
      managerEmployeeRepository = MockManagerEmployeeRepositoryRepository();
      platformUserRepository = MockPlatformUserRepository();
      managerRepository = MockManagerRepository();

      database = CollectorDatabase(
        database: openConnection(),
      );

      repository = EmployeeRepository(
        database: database,
        employeeFenceRepository: mockEmployeeFenceRepository,
        companyRepository: mockCompanyRepository,
        fenceRepository: mockFenceRepository,
        managerRepository: managerRepository,
        managerEmployeeRepository: managerEmployeeRepository,
        platformUserRepository: platformUserRepository,
        employeePlatformUserRepository: employeePlatformUserRepository,
      );

      when(
        () => mockCompanyRepository.save(company: company),
      ).thenAnswer(
        (invocation) => Future.value(true),
      );

      when(
        () => mockCompanyRepository.findById(id: company.id!),
      ).thenAnswer(
        (invocation) => Future.value(company),
      );

      when(
        () => mockFenceRepository.save(fence: fence),
      ).thenAnswer((invocation) => Future.value(true));

      when(
        () => mockFenceRepository.findAllByEmployeeId(employeeId: employee1.id),
      ).thenAnswer((invocation) => Future.value([fence]));

      when(
        () => mockEmployeeFenceRepository.save(
          employeeId: any(named: 'employeeId'),
          fenceId: any(named: 'fenceId'),
        ),
      ).thenAnswer((invocation) => Future.value(true));

      when(
        () => managerEmployeeRepository.save(
          employeeId: any(named: 'employeeId'),
          managerId: any(named: 'managerId'),
        ),
      ).thenAnswer((invocation) => Future.value(true));

      when(
        () => mockCompanyRepository.save(company: company),
      ).thenAnswer(
        (invocation) => Future.value(true),
      );

      when(
        () => mockCompanyRepository.findById(id: company.id!),
      ).thenAnswer(
        (invocation) => Future.value(company),
      );

      when(
        () => mockFenceRepository.save(fence: fence),
      ).thenAnswer((invocation) => Future.value(true));

      when(
        () => mockFenceRepository.findAllByEmployeeId(employeeId: employee1.id),
      ).thenAnswer((invocation) => Future.value([fence]));

      when(
        () => mockEmployeeFenceRepository.save(
          employeeId: any(named: 'employeeId'),
          fenceId: any(named: 'fenceId'),
        ),
      ).thenAnswer((invocation) => Future.value(true));

      when(
        () => managerRepository.save(managerDto: managerEntityMock),
      ).thenAnswer((invocation) => Future.value(true));

      when(
        () => managerEmployeeRepository.save(
          employeeId: employee1.id,
          managerId: managerMock.id.toString(),
        ),
      ).thenAnswer((invocation) => Future.value(true));
    },
  );

  tearDown(
    () async {
      await database.close();
    },
  );

  group('EmployeeRepository', () {
    test(
      'EmployeeRepository test.',
      () async {
        bool isEmptyDatabase = (await repository.getAll()).isEmpty;
        bool isEmptyFindById =
            (await repository.findById(id: employee1.id)) == null;
        bool successSave = await repository.save(employee: employee1);
        //employee1.name = 'New Employee Name 1';
        bool successUpdate = await repository.save(employee: employee1);
        Employee employeeFromBase = (await repository.findById(
          id: employee1.id,
        ))!;

        Employee employeeFromBaseByEmail =
            (await repository.findByMail(
          mail: employee1.mail!,
        ))!;

        int totalEmployes = (await repository.getAll()).length;

        bool hasFaceRegistered =
            (await repository.findByFaceRegisteredNotEmpty()).isNotEmpty;
        var updateFaceRegisteredByEmployeeId = (await repository
            .updateFaceRegisteredByEmployeeId(employeeId: employee1.id));

        expect(updateFaceRegisteredByEmployeeId, true);
        expect(isEmptyDatabase, true);
        expect(isEmptyFindById, true);
        expect(successSave, true);
        expect(successUpdate, true);
        expect(totalEmployes, 1);
        expect(employeeFromBase.id, employee1.id);
        expect(employeeFromBase.cpf, employee1.cpf);
        expect(employeeFromBase.employeeType, employee1.employeeType);
        expect(employeeFromBase.mail, employee1.mail);
        expect(employeeFromBase.name, employee1.name);
        expect(employeeFromBase.nfcCode, employee1.nfcCode);
        expect(employeeFromBase.employeeCode, employee1.employeeCode);
        expect(
          employeeFromBase.registrationNumber,
          employee1.registrationNumber,
        );
        expect(employeeFromBaseByEmail.mail, employee1.mail);
        expect(employeeFromBaseByEmail.arpId, employee1.arpId);
        expect(hasFaceRegistered, true);

        verify(
          () => mockCompanyRepository.save(company: company),
        ).called(2);

        verify(
          () => mockCompanyRepository.findById(id: company.id!),
        ).called(4);

        verify(
          () => mockFenceRepository.save(fence: fence),
        ).called(2);

        verify(
          () =>
              mockFenceRepository.findAllByEmployeeId(employeeId: employee1.id),
        ).called(4);

        verify(
          () => mockEmployeeFenceRepository.save(
            employeeId: any(named: 'employeeId'),
            fenceId: any(named: 'fenceId'),
          ),
        ).called(2);

        verifyNoMoreInteractions(mockCompanyRepository);
        verifyNoMoreInteractions(mockFenceRepository);
        verifyNoMoreInteractions(mockEmployeeFenceRepository);
      },
    );

    test('findByEmployeeCode test', () async {
      await repository.save(employee: employee1);
      Employee? employeeFromBase = await repository
          .findByEmployeeCodeAndEnable(employeeCode: '123456789');

      expect(employeeFromBase!.employeeCode, employee1.employeeCode);
    });

    test('findByName test', () async {
      await repository.save(employee: employee1);
      var name = 'Employee Teste 1';
      List<Employee>? employeeFromBase =
          await repository.findByName(name: name);

      for (var employee in employeeFromBase!) {
        expect(employee.name, name);
      }
    });

    test('findByNfcCode test', () async {
      await repository.save(employee: employee1);
      var nfcCode = '645834536534';
      Employee? employeeFromBase =
          await repository.findByNfcCodeAndEnable(nfcCode: nfcCode);

      expect(employeeFromBase!.nfcCode, employee1.nfcCode);
    });

    test('findByFaceRegistered employee not found test', () async {
      Employee? employeeFromBase =
          await repository.findByFaceRegistered(
        faceRegistered: 'dec52c53-81c0438abdad051d7cb1ac2f',
      );

      expect(employeeFromBase, null);
    });

    test('findByFaceRegistered configuration not found test', () async {
      await repository.save(employee: employee1);
      Employee? employeeFromBase =
          await repository.findByFaceRegistered(
        faceRegistered: 'dec52c53-81c0438abdad051d7cb1ac2f',
      );

      expect(employeeFromBase, null);
    });

    test('findByFaceRegistered employee found test', () async {
      await repository.save(employee: employee1);

      ConfigurationTableData configTable = ConfigurationTableData(
        employeeId: employee1.id,
        onlyOnline: false,
        takePhoto: false,
        operationMode: 'SINGLE',
        timezone: 'America/Sao_Paulo',
        faceRecognition: true,
      );

      await database.into(database.configurationTable).insert(configTable);

      Employee? employeeFromBase =
          await repository.findByFaceRegistered(
        faceRegistered: 'dec52c53-81c0438abdad051d7cb1ac2f',
      );

      expect(employeeFromBase!.employeeCode, employee1.employeeCode);
    });

    test('deleteAll test', () async {
      int totalInitial = (await repository.getAll()).length;
      await repository.save(employee: employee1);
      int totalAddOne = (await repository.getAll()).length;
      await repository.deleteAll();
      int totalRemoveAll = (await repository.getAll()).length;

      expect(totalInitial, 0);
      expect(totalAddOne, 1);
      expect(totalRemoveAll, 0);
    });

    test(
      'findEmployeesByManager test',
      () async {
        await repository.save(employee: employee1);
        EmployeeManagersTableData tableData = EmployeeManagersTableData(
          employeeId: employee1.id,
          managerId: employee1.managerEmployees!.first.id.toString(),
        );

        database.into(database.employeeManagersTable).insert(tableData);
        var employees = await repository.findEmployeesByManager(
          managerId: employee1.managerEmployees!.first.id.toString(),
        );

        expect(employees.length, 1);
        expect(employees.first.id, employee1.id);
        expect(employees.first.name, employee1.name);
      },
    );

    test(
      'deleteByIds test',
      () async {
        await repository.save(employee: employee2);
        await repository.deleteByIds(ids: []);

        final employees = await repository.getAll();

        expect(employees, isNotEmpty);
      },
    );
  });
}
