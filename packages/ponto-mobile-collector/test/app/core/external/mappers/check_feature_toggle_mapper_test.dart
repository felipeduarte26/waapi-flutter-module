import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/mappers/check_feature_toggle_mapper.dart';

void main() {
  Map<String, dynamic> tMapReturn = {
    'hasFeature': true,
  };
  late CheckFeatureToggleMapper checkFeatureToggleMapper;

  setUp(() {
    checkFeatureToggleMapper = CheckFeatureToggleMapper();
  });

  group('CheckFeatureToggleMapper', () {
    test('fromMap test', () async {
      expect(checkFeatureToggleMapper.fromMap(map: tMapReturn), true);
    });
  });
}
