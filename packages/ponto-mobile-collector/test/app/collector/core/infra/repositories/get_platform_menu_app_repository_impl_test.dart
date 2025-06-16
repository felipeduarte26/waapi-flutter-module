import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/platform_menu_entity.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/get_platform_menu_app_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/datasources/platform_menu_app_datasource.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/repositories/get_platform_menu_app_repository.dart';

class MockPlatformMenuAppDatasource extends Mock
    implements PlatformMenuAppDatasource {}

class FakePlatformMenuEntity extends Fake implements PlatformMenuEntity {}

void main() {
  late GetPlatformMenuAppRepository getPlatformMenuAppRepository;
  late PlatformMenuAppDatasource platformMenuAppDatasource;

  setUp(() {
    platformMenuAppDatasource = MockPlatformMenuAppDatasource();
    getPlatformMenuAppRepository =
        GetPlatformMenuAppRepositoryImpl(platformMenuAppDatasource);

    when(() => platformMenuAppDatasource.call())
        .thenAnswer((_) async => [FakePlatformMenuEntity()]);
  });

  group('GetPlatformMenuAppRepositoryTest', () {
    test('Test call GetPlatformMenuAppRepository', () async {
      var call = await getPlatformMenuAppRepository.call();

      expect(call?.length, 1);
    });
  });
}
