import '../../domain/entities/platform_menu_entity.dart';

abstract class PlatformMenuAppDatasource {
  Future<List<PlatformMenuEntity>?> call();
}
