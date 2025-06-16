import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/user_permission_check_entity.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/user_permissions_entity.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/token_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/database/iclocking_event_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/database/iemployee_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/check_user_permission_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_employee_manager_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/user_action_enum.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/user_resource_enum.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/domain/entities/employee_item_entity.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/domain/entities/pagination_employee_item_entity.dart';
import 'package:ponto_mobile_collector/app/collector/modules/time_adjustment/domain/usecases/get_employees_by_manager_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/time_adjustment/domain/usecases/get_employees_to_completed_appointments_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/time_adjustment/domain/usecases/verify_user_logged_is_admin_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/time_adjustment/domain/usecases/verify_user_logged_is_manager_usecase.dart';

import '../../../../../mocks/clocking_event_mock.dart';
import '../../../../../mocks/employee_dto_mock.dart';
import '../../../../../mocks/employee_entity_mock.dart';

class MockGetEmployeesToCompletedAppointmentsByManagerUseCase extends Mock
    implements GetEmployeesByManagerUsecase {}

class MockVerifyUserLoggedIsManagerUsecase extends Mock
    implements VerifyUserLoggedIsManagerUsecase {}

class MockEmployeeRepository extends Mock implements IEmployeeRepository {}

class MockClockingEventRepository extends Mock
    implements IClockingEventRepository {}

class MockCheckUserPermissionUsecase extends Mock
    implements CheckUserPermissionUsecase {}

class MockGetEmployeeManagerUsecase extends Mock
    implements GetEmployeeManagerUsecase {}

class MockVerifyUserLoggedIsAdminUsecase extends Mock
    implements VerifyUserLoggedIsAdminUsecase {}

void main() {
  late GetEmployeesToCompletedAppointmentsUsecaseImpl usecase;
  late MockGetEmployeesToCompletedAppointmentsByManagerUseCase
      mockGetEmployeesToCompletedAppointmentsByManagerUseCase;
  late MockVerifyUserLoggedIsManagerUsecase
      mockVerifyUserLoggedIsManagerUsecase;
  late MockEmployeeRepository mockEmployeeRepository;
  late MockClockingEventRepository mockClockingEventRepository;
  late MockCheckUserPermissionUsecase mockCheckUserPermissionUsecase;
  late MockGetEmployeeManagerUsecase mockGetEmployeeManagerUsecase;
  late MockVerifyUserLoggedIsAdminUsecase mockVerifyUserLoggedIsAdminUsecase;

  var action = UserActionEnum.allow.action;
  var resourceManager = UserResourceEnum.manager.resource;
  var resourceAdmin = UserResourceEnum.admin.resource;
  var permissionManager =
      UserPermissionCheckEntity(action: action, resource: resourceManager);
  var permissionAdmin =
      UserPermissionCheckEntity(action: action, resource: resourceAdmin);
  UserPermissionsEntity userPermissionsEntity = const UserPermissionsEntity(
    authorized: true,
    permissions: [],
  );

  TokenType tokenType = TokenType.user;

  final clockingEvents = [
    clockingEventMock,
  ];
  final employeeItem = EmployeeItemEntity(
    name: 'name',
    identifier: 'cpf',
    employeeSelected: false,
    id: '83e1a9c8-11ec-4f8b-8a92-3f22782b4f9f',
  );

  var userIdentifier = 'username@tenant.com.br';

  setUp(() {
    mockGetEmployeesToCompletedAppointmentsByManagerUseCase =
        MockGetEmployeesToCompletedAppointmentsByManagerUseCase();
    mockVerifyUserLoggedIsManagerUsecase =
        MockVerifyUserLoggedIsManagerUsecase();
    mockEmployeeRepository = MockEmployeeRepository();
    mockClockingEventRepository = MockClockingEventRepository();
    mockCheckUserPermissionUsecase = MockCheckUserPermissionUsecase();
    mockGetEmployeeManagerUsecase = MockGetEmployeeManagerUsecase();
    mockVerifyUserLoggedIsAdminUsecase = MockVerifyUserLoggedIsAdminUsecase();

    usecase = GetEmployeesToCompletedAppointmentsUsecaseImpl(
      getEmployeesToCompletedAppointmentsByManagerUseCase:
          mockGetEmployeesToCompletedAppointmentsByManagerUseCase,
      verifyUserLoggedIsManagerUsecase: mockVerifyUserLoggedIsManagerUsecase,
      employeeRepository: mockEmployeeRepository,
      clockingEventRepository: mockClockingEventRepository,
      checkUserPermissionUsecase: mockCheckUserPermissionUsecase,
      getEmployeeManagerUsecase: mockGetEmployeeManagerUsecase,
      verifyUserLoggedIsAdminUsecase: mockVerifyUserLoggedIsAdminUsecase,
    );

    when(
      () => mockVerifyUserLoggedIsManagerUsecase.call(
        username: userIdentifier,
      ),
    ).thenAnswer(
      (invocation) => Future.value(true),
    );

    when(
      () => mockVerifyUserLoggedIsAdminUsecase.call(
        username: userIdentifier,
      ),
    ).thenAnswer(
      (invocation) => Future.value(true),
    );

    when(
      () => mockGetEmployeeManagerUsecase.call(
        username: userIdentifier,
      ),
    ).thenAnswer(
      (invocation) => Future.value(employeeMockDto),
    );
    when(
      () => mockCheckUserPermissionUsecase.call(
        userPermissionCheckEntity: [permissionManager],
        tokenType: tokenType,
      ),
    ).thenAnswer((_) async => userPermissionsEntity);

    when(
      () => mockCheckUserPermissionUsecase.call(
        userPermissionCheckEntity: [permissionAdmin],
        tokenType: tokenType,
      ),
    ).thenAnswer((_) async => userPermissionsEntity);
  });

  group('GetEmployeesToCompletedAppointmentsUsecaseImpl', () {
    test('returns empty pagination when no employees are found', () async {
      when(() => mockClockingEventRepository.getAll())
          .thenAnswer((_) async => []);
      when(
        () => mockVerifyUserLoggedIsAdminUsecase.call(
          username: userIdentifier,
        ),
      ).thenAnswer(
        (invocation) => Future.value(false),
      );
      when(
        () => mockGetEmployeesToCompletedAppointmentsByManagerUseCase.call(
          username: userIdentifier,
          employeeIdsFromClockingEventList: [],
        ),
      ).thenAnswer((_) async => []);

      final result = await usecase.call(
        username: userIdentifier,
      );

      expect(result, isA<PaginationEmployeeItemEntity>());
      expect(result.employees, isEmpty);
    });

    test('returns employees with completed appointments and pagination',
        () async {
      when(
        () => mockCheckUserPermissionUsecase.call(
          userPermissionCheckEntity: [permissionAdmin],
          tokenType: tokenType,
        ),
      ).thenAnswer((_) async => userPermissionsEntity);

      when(() => mockClockingEventRepository.getAll())
          .thenAnswer((_) async => clockingEvents);
      when(
        () => mockEmployeeRepository.findById(
          id: '83e1a9c8-11ec-4f8b-8a92-3f22782b4f9f',
        ),
      ).thenAnswer((_) async => employeeEntityMock);
      when(() => mockEmployeeRepository.findByName(name: 'name'))
          .thenAnswer((_) async => [employeeEntityMock]);
      when(
        () => mockGetEmployeesToCompletedAppointmentsByManagerUseCase.call(
          username: userIdentifier,
          employeeIdsFromClockingEventList: ['83e1a9c8-11ec-4f8b-8a92-3f22782b4f9f'],
        ),
      ).thenAnswer((_) async => [employeeEntityMock]);

      final result = await usecase.call(
        nameEmployee: 'name',
        username: userIdentifier,
      );

      expect(result.employees.first, employeeItem);
      expect(result.employees.first.name, 'name');
    });

    test('handles logged in manager cenario', () async {
      when(() => mockClockingEventRepository.getAll())
          .thenAnswer((_) async => [clockingEventMock]);

      when(
        () => mockEmployeeRepository.findById(
          id: '83e1a9c8-11ec-4f8b-8a92-3f22782b4f9f',
        ),
      ).thenAnswer((_) async => employeeEntityMock);
      when(
        () => mockCheckUserPermissionUsecase.call(
          userPermissionCheckEntity: [permissionManager],
          tokenType: tokenType,
        ),
      ).thenAnswer((_) async => userPermissionsEntity);

      when(
        () => mockCheckUserPermissionUsecase.call(
          userPermissionCheckEntity: [permissionAdmin],
          tokenType: tokenType,
        ),
      ).thenAnswer((_) async => userPermissionsEntity);

      when(
        () => mockGetEmployeesToCompletedAppointmentsByManagerUseCase.call(
          username: userIdentifier,
          employeeIdsFromClockingEventList: ['83e1a9c8-11ec-4f8b-8a92-3f22782b4f9f'],
        ),
      ).thenAnswer((_) async => [employeeEntityMock]);

      final result = await usecase.call(
        username: userIdentifier,
      );

      expect(result.employees.first.name, 'name');
    });

    /*test(
        'isUserLoggedAdmin returns true when '
        'user has admin permission', () async {
      TokenType tokenType = TokenType.user;

      when(
        () => mockCheckUserPermissionUsecase.call(
          userPermissionCheckEntity: any(named: 'userPermissionCheckEntity'),
          tokenType: any(named: 'tokenType'),
        ),
      ).thenAnswer((_) async => userPermissionsEntity);

      final result = await usecase.isUserLoggedAdmin(tokenType: tokenType);

      expect(result, isTrue);
    });

    test(
        'isUserLoggedAdmin returns false when '
        'user does not have admin permission', () async {
      TokenType tokenType = TokenType.user;
      UserPermissionsEntity noAuthorizedUserPermissionsEntity =
          const UserPermissionsEntity(
        authorized: false,
        permissions: [],
      );

      when(
        () => mockCheckUserPermissionUsecase.call(
          userPermissionCheckEntity: any(named: 'userPermissionCheckEntity'),
          tokenType: any(named: 'tokenType'),
        ),
      ).thenAnswer((_) async => noAuthorizedUserPermissionsEntity);

      final result = await mockVerifyUserLoggedIsAdminUsecase.call(
        username: userIdentifier,
      );

      expect(result, isFalse);
    });*/
  });
}
