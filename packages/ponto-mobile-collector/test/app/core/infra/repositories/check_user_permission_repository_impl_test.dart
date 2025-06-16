import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/user_permissions_entity.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/token_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_access_token_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/adapters/user_permissions_entity_adapter.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/datasources/check_user_permission_datasource.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/repositories/check_user_permission_repository_impl.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../../mocks/authorization_response_mock.dart';
import '../../../../mocks/user_permission_check_entity_mock.dart';
import '../../../../mocks/user_permissions_entity_mock.dart';

class MockCheckUserPermissionDatasource extends Mock
    implements CheckUserPermissionDatasource {}

class MockUserPermissionsEntityAdapter extends Mock
    implements UserPermissionsEntityAdapter {}

class MockGetAccessTokenUsecase extends Mock implements GetAccessTokenUsecase {}

void main() {
  const String token = 'token';
  late CheckUserPermissionDatasource checkUserPermissionDatasource;
  late UserPermissionsEntityAdapter userPermissionsEntityAdapter;
  late CheckUserPermissionRepositoryImpl checkUserPermissionRepositoryImpl;
  late GetAccessTokenUsecase getAccessTokenUsecase;

  setUp(() {
    checkUserPermissionDatasource = MockCheckUserPermissionDatasource();
    getAccessTokenUsecase = MockGetAccessTokenUsecase();
    userPermissionsEntityAdapter = MockUserPermissionsEntityAdapter();

    registerFallbackValue(const UserName());

    when(
      () => getAccessTokenUsecase.call(tokenType: TokenType.user),
    ).thenAnswer((_) async => token);

    when(
      () => getAccessTokenUsecase.call(tokenType: TokenType.key),
    ).thenAnswer((_) async => token);

    when(
      () => checkUserPermissionDatasource.call(
        userPermissionCheckEntity: [userPermissionCheckEntityMock],
      ),
    ).thenAnswer(
      (_) async => authorizationResponseMock,
    );

    when(
      () => userPermissionsEntityAdapter.fromModel(
        authorizationResponse: authorizationResponseMock,
      ),
    ).thenReturn(
      userPermissionsEntityMock,
    );

    checkUserPermissionRepositoryImpl = CheckUserPermissionRepositoryImpl(
      checkUserPermissionDatasource: checkUserPermissionDatasource,
      getAccessTokenUsecase: getAccessTokenUsecase,
      userPermissionsEntityAdapter: userPermissionsEntityAdapter,
    );
  });

  group('CheckUserPermissionRepositoryImpl', () {
    test('call successfully test', () async {
      when(
        () => getAccessTokenUsecase.call(tokenType: TokenType.user),
      ).thenAnswer((_) async => token);

      when(
        () => checkUserPermissionDatasource.call(
          userPermissionCheckEntity: [userPermissionCheckEntityMock],
          tokenType: TokenType.user,
        ),
      ).thenAnswer(
        (_) async => authorizationResponseMock,
      );

      UserPermissionsEntity userPermissionsEntity =
          await checkUserPermissionRepositoryImpl.call(
        userPermissionCheckEntity: [userPermissionCheckEntityMock],
        tokenType: TokenType.user,
      );

      expect(userPermissionsEntity, userPermissionsEntityMock);
    });

    test('call no token test', () async {
      when(
        () => getAccessTokenUsecase.call(tokenType: TokenType.user),
      ).thenAnswer((_) async => null);

      when(
        () => getAccessTokenUsecase.call(tokenType: TokenType.key),
      ).thenAnswer((_) async => null);

      UserPermissionsEntity userPermissionsEntity =
          await checkUserPermissionRepositoryImpl.call(
        userPermissionCheckEntity: [userPermissionCheckEntityMock],
        tokenType: TokenType.user,
      );

      expect(userPermissionsEntity.authorized, false);
      expect(userPermissionsEntity.permissions, []);

      userPermissionsEntity = await checkUserPermissionRepositoryImpl.call(
        userPermissionCheckEntity: [userPermissionCheckEntityMock],
        tokenType: TokenType.key,
      );

      expect(userPermissionsEntity.authorized, false);
      expect(userPermissionsEntity.permissions, []);
    });

    test('call with key token test', () async {
      when(
        () => getAccessTokenUsecase.call(tokenType: TokenType.key),
      ).thenAnswer((_) async => token);

      when(
        () => checkUserPermissionDatasource.call(
          userPermissionCheckEntity: [userPermissionCheckEntityMock],
          tokenType: TokenType.key,
        ),
      ).thenAnswer(
        (_) async => authorizationResponseMock,
      );

      UserPermissionsEntity userPermissionsEntity =
          await checkUserPermissionRepositoryImpl.call(
        userPermissionCheckEntity: [userPermissionCheckEntityMock],
        tokenType: TokenType.key,
      );

      expect(userPermissionsEntity, userPermissionsEntityMock);
    });
  });
}
