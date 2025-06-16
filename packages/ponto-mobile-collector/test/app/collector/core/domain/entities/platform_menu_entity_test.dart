import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/platform_menu_entity.dart';

void main() {
  group('PlatformMenuEntityTest', () {
    test('Test entity', () {
      var platformMenuEntity = const PlatformMenuEntity(
        id: 'id123',
        name: '',
        resource: '',
        permission: '',
        active: true,
        backendUrl: '',
        description: '',
        url: '',
        flutterIcon: '',
      );


      expect(platformMenuEntity.props[0], 'id123');
    });
  });
}
