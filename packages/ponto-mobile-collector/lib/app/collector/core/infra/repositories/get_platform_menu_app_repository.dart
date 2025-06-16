import '../../domain/entities/platform_menu_entity.dart';
import '../../domain/repositories/get_platform_menu_app_repository.dart';
import '../datasources/platform_menu_app_datasource.dart';

class GetPlatformMenuAppRepositoryImpl implements GetPlatformMenuAppRepository {
  late PlatformMenuAppDatasource platformMenuAppDatasource;

  GetPlatformMenuAppRepositoryImpl(
    this.platformMenuAppDatasource,
  );

  @override
  Future<List<PlatformMenuEntity>?> call() async {
    return platformMenuAppDatasource.call();
  }
}
