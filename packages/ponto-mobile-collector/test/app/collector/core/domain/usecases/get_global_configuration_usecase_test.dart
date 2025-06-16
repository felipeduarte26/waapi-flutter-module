import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/global_configuration_entity.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/network_status.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/token_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/platform/iplatform_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_access_token_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_global_configuration_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/mappers/global_configuration_mapper.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/datasources/configuration_global_query_datasource.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/repositories/database/global_configuration_repository.dart';

import '../../../../../mocks/global_configuration_entity_mock.dart';

class MockConfigurationGlobalQueryDatasource extends Mock
    implements ConfigurationGlobalQueryDatasource {}

class MockGlobalConfigurationRepository extends Mock
    implements GlobalConfigurationRepository {}

class MockGetAccessTokenUsecase extends Mock implements GetAccessTokenUsecase {}

class MockPlatformService extends Mock implements IPlatformService {}

void main() {
  late MockConfigurationGlobalQueryDatasource
      mockConfigurationGlobalQueryDatasource;
  late MockGlobalConfigurationRepository mockGlobalConfigurationRepository;
  late GetGlobalConfigurationUseCaseImpl useCase;
  late GetAccessTokenUsecase getAccessTokenUsecase;
  late IPlatformService platformService;

  setUp(() {
    platformService = MockPlatformService();
    mockConfigurationGlobalQueryDatasource =
        MockConfigurationGlobalQueryDatasource();
    mockGlobalConfigurationRepository = MockGlobalConfigurationRepository();
    getAccessTokenUsecase = MockGetAccessTokenUsecase();

    when(
      () => getAccessTokenUsecase.call(tokenType: TokenType.key),
    ).thenAnswer((_) async => 'accessToken');
    
    when(() => platformService.connectivityStatus())
        .thenAnswer((_) async => NetworkStatusEnum.active);

    useCase = GetGlobalConfigurationUseCaseImpl(
      configurationGlobalQueryDatasource:
          mockConfigurationGlobalQueryDatasource,
      globalConfigurationRepository: mockGlobalConfigurationRepository,
      getAccessTokenUsecase: getAccessTokenUsecase,
      platformService: platformService,
    );
  });

  test('call method returns GlobalConfigurationEntity', () async {
    var globalConfigurationEntity = const GlobalConfigurationEntity(id: '123');
    when(() => mockConfigurationGlobalQueryDatasource.call())
        .thenAnswer((_) async => globalConfigurationEntity);
    var tableData = GlobalConfigurationEntityMapper()
        .toTableData(globalConfigurationEntity: globalConfigurationEntity);
    when(() => mockGlobalConfigurationRepository.save(configuration: tableData))
        .thenAnswer((_) async => true);
    when(() => mockGlobalConfigurationRepository.getAll())
        .thenAnswer((_) async => [globalConfigurationEntityMock]);

    final result = await useCase.call();

    expect(result, isA<GlobalConfigurationEntity>());
  });

  test('call method returns null when exception is thrown', () async {
    when(() => mockConfigurationGlobalQueryDatasource.call())
        .thenThrow(Exception());
    when(() => mockGlobalConfigurationRepository.getAll())
        .thenAnswer((_) async => []);

    final result = await useCase.call();

    expect(result, null);
  });
}
