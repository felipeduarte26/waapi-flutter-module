import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/hub_menu_entity.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/platform_menu_entity.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/token_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/get_platform_menu_app_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/firebase/log_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_platform_menus_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_token_usecase.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

class MockGetPlatformMenuAppRepository extends Mock
    implements GetPlatformMenuAppRepository {}

class MockGetTokenUsecase extends Mock implements GetTokenUsecase {}

class MockLogService extends Mock implements LogService {}

void main() {
  late GetPlatformMenusUsecase getPlatformMenusUsecase;

  late GetPlatformMenuAppRepository getPlatformMenuAppRepository;
  late GetTokenUsecase getTokenUsecase;
  late LogService logService;

  setUp(() {
    getPlatformMenuAppRepository = MockGetPlatformMenuAppRepository();
    getTokenUsecase = MockGetTokenUsecase();
    logService = MockLogService();

    getPlatformMenusUsecase = GetPlatformMenusUsecaseImpl(
      getPlatformMenuAppRepository,
      getTokenUsecase,
      logService,
    );

    var platformMenuEntity = const PlatformMenuEntity(
      id: '',
      name: '',
      resource: '',
      permission: '',
      description: '',
      url: 'http://teste.url.com.br/',
      backendUrl: '',
      active: true,
      flutterIcon: '0xe19d',
    );

    when(() => getPlatformMenuAppRepository.call())
        .thenAnswer((_) async => [platformMenuEntity]);

    var fakeToken = const Token(
      accessToken: '123',
      expiresIn: 1234123,
      tokenType: 'bearer',
      refreshToken: '123',
    );

    when(
      () => getTokenUsecase.call(tokenType: TokenType.user),
    ).thenAnswer(
      (_) async => fakeToken,
    );
  });

  group('GetPlatformMenusUsecaseTest', () {
    test('GetPlatformMenuUsecase teste call', () async {
      var call = await getPlatformMenusUsecase.call();
      var hubMenuEntity = call?[0];
      assert(hubMenuEntity is HubMenuEntity);
    });
  });
}
