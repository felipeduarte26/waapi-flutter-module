import '../entities/platform_menu_entity.dart';

abstract class GetPlatformMenuAppRepository {
  Future<List<PlatformMenuEntity>?> call();
}
