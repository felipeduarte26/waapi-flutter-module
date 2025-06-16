import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_authentication/mobile_authentication_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/datasources/check_user_permission_datasource_impl.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/datasources/check_user_permission_datasource.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

import '../../../../mocks/authorization_permissions_mock.dart';
import '../../../../mocks/authorization_response_mock.dart';
import '../../../../mocks/user_permission_check_entity_mock.dart';

class MockEnvironmentService extends Mock implements IEnvironmentService {}

class MockIMobileAuthenticationService extends Mock
    implements IMobileAuthenticationService {}

void main() {
  TokenType tokenType = TokenType.first;
  late IEnvironmentService environmentService;
  late MockIMobileAuthenticationService mobileAuthenticationService;
  late CheckUserPermissionDatasource checkUserPermissionDatasource;

  setUp(() {
    registerFallbackValue(Environment.dev);
    registerFallbackValue(authorizationPermissionsMock);

    environmentService = MockEnvironmentService();
    mobileAuthenticationService = MockIMobileAuthenticationService();

    when(
      () => environmentService.environment(),
    ).thenReturn(EnvironmentEnum.dev);

    when(
      () => mobileAuthenticationService.getAuthorization(
        any(),
        any(),
        tokenType: tokenType.value,
      ),
    ).thenAnswer((_) async => authorizationResponseMock);

    checkUserPermissionDatasource = CheckUserPermissionDatasourceImpl(
      environmentService: environmentService,
      mobileAuthenticationService: mobileAuthenticationService,
    );
  });

  group('CheckUserPermissionDatasourceImpl', () {
    test('props test', () async {
      AuthorizationResponse authorizationResponse =
          await checkUserPermissionDatasource.call(
        tokenType: tokenType,
        userPermissionCheckEntity: [userPermissionCheckEntityMock],
      );

      expect(authorizationResponse, authorizationResponseMock);

      verify(() => environmentService.environment()).called(1);
      verify(
        () => mobileAuthenticationService.getAuthorization(
          any(),
          any(),
          tokenType: tokenType.value,
        ),
      );

      verifyNoMoreInteractions(environmentService);
      verifyNoMoreInteractions(mobileAuthenticationService);
    });
  });
}
