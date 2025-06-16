import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/user_permission_check_entity.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/user_permissions_entity.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/check_conection_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/check_user_permission_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/user_action_enum.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/user_resource_enum.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/domain/usecases/get_employees_to_facial_registration_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/presenter/cubit/employee_search/employee_search_cubit.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/presenter/cubit/employee_search/employee_search_state.dart';

import '../../../../../../mocks/pagination_employee_item_entity_mock.dart';

class MockGetEmployeesToFacialRegistrationUsecase extends Mock
    implements GetEmployeesToFacialRegistrationUsecase {}

class MockCheckUserPermissionUsecase extends Mock
    implements CheckUserPermissionUsecase {}

class MockHasConnectivityUsecase extends Mock
    implements IHasConnectivityUsecase {}

void main() {
  late GetEmployeesToFacialRegistrationUsecase
      getEmployeesToFacialRegistrationUsecase;
  late CheckUserPermissionUsecase checkUserPermissionUsecase;
  late IHasConnectivityUsecase hasConnectivityUsecase;
  late EmployeeSearchCubit employeeSearchCubit;

  UserPermissionsEntity userPermissionsEntity = const UserPermissionsEntity(
    authorized: true,
    permissions: [],
  );

  UserPermissionsEntity userPermissionsFalseEntity = const UserPermissionsEntity(
    authorized: false,
    permissions: [],
  );

  UserPermissionCheckEntity userPermissionCheckEntity =
      UserPermissionCheckEntity(
    action: UserActionEnum.allow.action,
    resource: UserResourceEnum.facialAuth.resource,
  );

  setUp(() {
    getEmployeesToFacialRegistrationUsecase =
        MockGetEmployeesToFacialRegistrationUsecase();
    checkUserPermissionUsecase = MockCheckUserPermissionUsecase();
    hasConnectivityUsecase = MockHasConnectivityUsecase();

    when(() => hasConnectivityUsecase.call()).thenAnswer((_) async => true);

    when(
      () => checkUserPermissionUsecase.call(
        userPermissionCheckEntity: [userPermissionCheckEntity],
      ),
    ).thenAnswer((_) async => userPermissionsEntity);

    employeeSearchCubit = EmployeeSearchCubit(
      getEmployeesToFacialRegistrationUsecase:
          getEmployeesToFacialRegistrationUsecase,
      checkUserPermissionUsecase: checkUserPermissionUsecase,
      hasConnectivityUsecase: hasConnectivityUsecase,
    );
  });

  group('EmployeeSearchCubit', () {
    blocTest(
      'emits [EmployeeSearchInProgress], [EmployeeSearchSuccess]'
      ' when search is call test',
      setUp: () {
        when(
          () => getEmployeesToFacialRegistrationUsecase.call(),
        ).thenAnswer(
          (_) async => paginationEmployeeItemEntityMock,
        );
      },
      build: () => employeeSearchCubit,
      act: (cubit) => cubit.search(),
      expect: () => [
        isA<EmployeeSearchInProgress>(),
        isA<EmployeeSearchSuccess>(),
      ],
    );

    blocTest(
      'emits [EmployeeSearchInProgress], [EmployeeSearchFailure] '
      ' when search is call test',
      setUp: () {
        when(
          () => getEmployeesToFacialRegistrationUsecase.call(),
        ).thenThrow(Exception('Unexpected Exception'));
      },
      build: () => employeeSearchCubit,
      act: (cubit) => cubit.search(),
      expect: () => [
        isA<EmployeeSearchInProgress>(),
        isA<EmployeeSearchFailure>(),
      ],
    );

    blocTest(
      'emits [EmployeeSearchInitial], [EmployeeSearchOffline] '
      ' when init is call test',
      setUp: () {
        when(() => hasConnectivityUsecase.call())
            .thenAnswer((_) async => false);
      },
      build: () => employeeSearchCubit,
      act: (cubit) => cubit.init(),
      expect: () => [
        isA<EmployeeSearchInitial>(),
        isA<EmployeeSearchOffline>(),
      ],
    );

    blocTest(
      'emits [EmployeeSearchInitial], [EmployeeSearchNotPermission] '
      ' when init is call test',
      setUp: () {
        when(
          () => checkUserPermissionUsecase.call(
            userPermissionCheckEntity: [
              userPermissionCheckEntity,
            ],
          ),
        ).thenAnswer((_) async => userPermissionsFalseEntity);
      },
      build: () => employeeSearchCubit,
      act: (cubit) => cubit.init(),
      expect: () => [
        isA<EmployeeSearchInitial>(),
        isA<EmployeeSearchNotPermission>(),
      ],
    );

    blocTest(
      'emits [EmployeeSearchLoadMoreInProgress], [EmployeeSearchSuccess] '
      ' when loadMore is call success test',
      setUp: () {
        employeeSearchCubit.paginationEmployees =
            paginationEmployeeItemEntityMock;
        when(
          () => getEmployeesToFacialRegistrationUsecase.call(
            name: null,
            pageNumber: 1,
          ),
        ).thenAnswer((_) async => paginationEmployeeItemEntityMock);
      },
      build: () => employeeSearchCubit,
      act: (cubit) => cubit.loadMore(),
      expect: () => [
        isA<EmployeeSearchLoadMoreInProgress>(),
        isA<EmployeeSearchSuccess>(),
      ],
    );

    blocTest(
      'emits [EmployeeSearchFailure] '
      ' when loadMore is call failure test',
      setUp: () {
        employeeSearchCubit.paginationEmployees =
            paginationEmployeeItemEntityMock;
        when(
          () => getEmployeesToFacialRegistrationUsecase.call(
            name: null,
            pageNumber: 1,
          ),
        ).thenThrow(Exception('Unexpected Exception'));
      },
      build: () => employeeSearchCubit,
      act: (cubit) => cubit.loadMore(),
      expect: () => [
        isA<EmployeeSearchFailure>(),
      ],
    );

    test('changeNameSearch call test', () async {
      employeeSearchCubit.changeNameSearch('name');
      expect(employeeSearchCubit.getNameSearch(), 'name');
    });
  });
}
