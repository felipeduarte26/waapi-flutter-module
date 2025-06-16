import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/configuration.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/employee.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/page_entity.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/page_response_entity.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/operation_mode_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/work_indicator_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/database/iconfiguration_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/database/iemployee_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/iemployee_sync_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/work_indicator_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/sync_employee_by_id_usecase.dart';

import '../../../../../mocks/configuration_entity_mock.dart';
import '../../../../../mocks/employee_entity_mock.dart';
import '../../../../../mocks/multi_employee_sync_mock.dart';

class MockIEmployeeSyncService extends Mock implements IEmployeeSyncService {}

class MockWorkIndicatorService extends Mock implements WorkIndicatorService {}

class MockIEmployeeRepository extends Mock implements IEmployeeRepository {}

class MockConfigurationRepository extends Mock
    implements IConfigurationRepository {}

void main() {
  late SyncEmployeeByIdUsecase syncEmployeeByIdUsecase;
  late IEmployeeSyncService employeeSyncService;
  late WorkIndicatorService workIndicatorService;
  late IEmployeeRepository employeeRepository;
  late IConfigurationRepository configurationRepository;

  const employeeId = '1';
  const syncEmployeeById = WorkIndicatorType.syncEmployeeById;

  var employeeEntity = Employee(
    id: '1',
    name: 'John Doe',
    cpf: '99999999999',
    employeeType: 'employeeType',
    arpId: 'arpId',
    enable: true,
    mail: 'mail@email.com.br',
    nfcCode: 'nfcCode',
    company: companyEntityMock,
  );

  var configurationEntity =  const Configuration(
    onlyOnline: true,
    operationMode: OperationModeType.single,
    timezone: 'America/Sao_Paulo',
    takePhoto: true,
  );

  setUpAll(() {
    registerFallbackValue(employeeEntity);
    registerFallbackValue(configurationEntity);
  });
  setUp(() {
    employeeSyncService = MockIEmployeeSyncService();
    workIndicatorService = MockWorkIndicatorService();
    employeeRepository = MockIEmployeeRepository();
    configurationRepository = MockConfigurationRepository();

    syncEmployeeByIdUsecase = SyncEmployeeByIdUsecaseImpl(
      employeeSyncService: employeeSyncService,
      workIndicatorService: workIndicatorService,
      employeeRepository: employeeRepository,
      configurationRepository: configurationRepository,
    );

    when(
      () => workIndicatorService.addWorkIndicator(
        workIndicatorType: syncEmployeeById,
      ),
    ).thenReturn(true);

    when(
      () => workIndicatorService.removeWorkIndicator(
        workIndicatorType: syncEmployeeById,
      ),
    ).thenReturn(true);

    registerFallbackValue(
      PageEntity(
        page: 0,
        pageSize: 1,
      ),
    );

    when(
      () => employeeSyncService.getEmployees(
        pageEntity: any(named: 'pageEntity'),
        employeeIdFilter: employeeId,
      ),
    ).thenAnswer(
      (_) async => PageResponseEntity(
        content: [multiEmployeeSyncMock],
        pageNumber: 0,
        totalElements: 1,
      ),
    );

    when(
      () => employeeRepository.save(
        employee: employeeEntityMock,
      ),
    ).thenAnswer((_) async => true);

    when(
      () => configurationRepository.save(
        config: configurationEntityMock,
        employeeId: multiEmployeeSyncMock.employee.id,
      ),
    ).thenAnswer((_) async => true);
  });

  group('SyncEmployeeByIdUsecase', () {
    test('call sync successfully test', () async {
      when(
        () => employeeSyncService.getEmployees(
          pageEntity: PageEntity(
            page: 0,
            pageSize: 1,
          ),
          employeeIdFilter: employeeId,
        ),
      ).thenAnswer(
        (_) async => PageResponseEntity(
          content: [multiEmployeeSyncMock],
          pageNumber: 0,
          totalElements: 1,
        ),
      );

      when(()=> configurationRepository.save(config: any(named: 'config'), employeeId: multiEmployeeSyncMock.employee.id)).thenAnswer((_) async => true);

      when(
        () => employeeRepository.save(employee: any(named: 'employee')),
      ).thenAnswer((_) async => true);

      await syncEmployeeByIdUsecase.call(employeeId: employeeId);

      verify(
        () => employeeSyncService.getEmployees(
          pageEntity: any(named: 'pageEntity'),
          employeeIdFilter: employeeId,
        ),
      );

      verify(
        () => employeeRepository.save(
          employee: any(named: 'employee'),
        ),
      );

      verify(
        () => configurationRepository.save(
          config: any(named: 'config'),
          employeeId: multiEmployeeSyncMock.employee.id,
        ),
      );

      verifyNoMoreInteractions(employeeSyncService);
      verifyNoMoreInteractions(employeeRepository);
      verifyNoMoreInteractions(configurationRepository);
    });

    test('employee service return empty test', () async {
      when(
        () => employeeSyncService.getEmployees(
          pageEntity: any(named: 'pageEntity'),
          employeeIdFilter: employeeId,
        ),
      ).thenAnswer(
        (_) async => PageResponseEntity(
          content: [],
          pageNumber: 0,
          totalElements: 0,
        ),
      );

      await syncEmployeeByIdUsecase.call(employeeId: employeeId);

      verify(
        () => employeeSyncService.getEmployees(
          pageEntity: any(named: 'pageEntity'),
          employeeIdFilter: employeeId,
        ),
      );

      verifyNoMoreInteractions(employeeSyncService);
      verifyZeroInteractions(employeeRepository);
      verifyZeroInteractions(configurationRepository);
    });

    test('employee service return exception test', () async {
      when(
        () => employeeSyncService.getEmployees(
          pageEntity: any(named: 'pageEntity'),
          employeeIdFilter: employeeId,
        ),
      ).thenThrow(Exception());

      expect(
        () async => await syncEmployeeByIdUsecase.call(employeeId: employeeId),
        throwsA(isA<Exception>()),
      );

      verify(
        () => employeeSyncService.getEmployees(
          pageEntity: any(named: 'pageEntity'),
          employeeIdFilter: employeeId,
        ),
      );

      verifyNoMoreInteractions(employeeSyncService);
      verifyZeroInteractions(employeeRepository);
      verifyZeroInteractions(configurationRepository);
    });
  });
}
