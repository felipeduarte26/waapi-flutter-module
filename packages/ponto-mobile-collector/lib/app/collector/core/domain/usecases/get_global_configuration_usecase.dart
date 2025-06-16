import 'dart:developer';

import '../../external/mappers/global_configuration_mapper.dart';
import '../../infra/datasources/configuration_global_query_datasource.dart';
import '../../infra/repositories/database/global_configuration_repository.dart';
import '../entities/global_configuration_entity.dart';
import '../enums/network_status.dart';
import '../enums/token_type.dart';
import '../services/platform/iplatform_service.dart';
import 'get_access_token_usecase.dart';

abstract class GetGlobalConfigurationUsecase {
  Future<GlobalConfigurationEntity?> call();
}

/// GetGlobalConfigurationUseCaseImpl
/// Fetch and save local global configuration
class GetGlobalConfigurationUseCaseImpl
    implements GetGlobalConfigurationUsecase {
  final ConfigurationGlobalQueryDatasource configurationGlobalQueryDatasource;
  final GlobalConfigurationRepository globalConfigurationRepository;
  final GetAccessTokenUsecase getAccessTokenUsecase;
  final IPlatformService platformService;

  GetGlobalConfigurationUseCaseImpl({
    required this.configurationGlobalQueryDatasource,
    required this.globalConfigurationRepository,
    required this.getAccessTokenUsecase,
    required this.platformService,
  });

  Duration get timeLimit => const Duration(seconds: 3);

  @override
  Future<GlobalConfigurationEntity?> call() async {
    if (await platformService.connectivityStatus() !=
        NetworkStatusEnum.active) {
      return null;
    }

    String? accessKeyToken =
        await getAccessTokenUsecase.call(tokenType: TokenType.key);

    if (accessKeyToken != null) {
      try {
        var globalConfigurationEntity =
            await configurationGlobalQueryDatasource.call().timeout(timeLimit);
        var tableData = GlobalConfigurationEntityMapper()
            .toTableData(globalConfigurationEntity: globalConfigurationEntity);
        await globalConfigurationRepository.save(configuration: tableData);
        return globalConfigurationEntity;
      } catch (e) {
        log(e.toString());
      }
    }

    var list = await globalConfigurationRepository.getAll();
    return list.isNotEmpty ? list.first : null;
  }
}
