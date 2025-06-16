import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/ordering_mode_enum.dart';

void main() {
  test(
    'OrderingModeEnum test.',
    () {
      expect(
        OrderingModeEnum.build(
          OrderingModeEnum.asc.name,
        ),
        OrderingModeEnum.asc,
      );

      expect(
        OrderingModeEnum.build(OrderingModeEnum.desc.name),
        OrderingModeEnum.desc,
      );

      expect(
        () => OrderingModeEnum.build('error'),
        throwsA(
          isA<Exception>(),
        ),
      );
    },
  );
}
