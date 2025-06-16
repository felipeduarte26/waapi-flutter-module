import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/services/shared_preferences/shared_preferences_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/user_action_enum.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/user_resource_enum.dart';
import 'package:ponto_mobile_collector/app/collector/modules/time_adjustment/domain/usecases/verify_user_logged_is_admin_usecase.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

// Mocks
class MockSharedPreferencesService extends Mock
    implements SharedPreferencesService {}

void main() {
  late VerifyUserLoggedIsAdminUsecaseImpl usecase;
  late MockSharedPreferencesService mockSharedPreferencesService;

  registerFallbackValue(const UserName());

  var tAction = UserActionEnum.allow.action;
  var tResource = UserResourceEnum.admin.resource;
  var userIdentifier = 'username@tenant.com.br';

  setUp(() {
    mockSharedPreferencesService = MockSharedPreferencesService();

    usecase = VerifyUserLoggedIsAdminUsecaseImpl(
      sharedPreferencesService: mockSharedPreferencesService,
    );
    when(
      () => mockSharedPreferencesService.getUserPermission(
        userName: userIdentifier,
        action: tAction,
        resource: tResource,
      ),
    ).thenAnswer((_) async => true);
  });

  group('VerifyUserLoggedIsAdminUsecaseImpl', () {
    test('returns true when user has admin permission', () async {
      final result = await usecase.call(username: userIdentifier);

      expect(result, true);
      verify(
        () => mockSharedPreferencesService.getUserPermission(
          userName: userIdentifier,
          action: tAction,
          resource: tResource,
        ),
      ).called(1);
    });

    test('returns false when user does not have admin permission', () async {
      when(
        () => mockSharedPreferencesService.getUserPermission(
          userName: userIdentifier,
          action: tAction,
          resource: tResource,
        ),
      ).thenAnswer((_) async => false);

      final result = await usecase.call(username: userIdentifier);

      expect(result, false);
      verify(
        () => mockSharedPreferencesService.getUserPermission(
          userName: userIdentifier,
          action: tAction,
          resource: tResource,
        ),
      ).called(1);
    });
  });
}
