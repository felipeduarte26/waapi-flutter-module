import '../../domain/entities/platform_menu_entity.dart';

class PlatformMenuModelMapper {
  PlatformMenuEntity fromMap({required Map<String, dynamic> map}) {
    return PlatformMenuEntity(
      id: map['id'],
      name: map['name'],
      resource: map['resource'],
      permission: map['permission'],
      description: map['description'],
      url: map['url'],
      backendUrl: map['backendUrl'],
      active: map['active'],
      flutterIcon: map['flutterIcon'],
    );
  }

  List<PlatformMenuEntity> fromList({required List<dynamic> list}) {
    var map = list.map((e) => fromMap(map: e));
    return map.toList();
  }
}
