import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/execution_mode_enum.dart';

void main() {
  group('ExecutionModeEnum', () {
    test('call is test', () {
      expect(ExecutionModeEnum.individual.isIndividualOrDriver(), true);
      expect(ExecutionModeEnum.multiple.isMultiple(), true);
    });
  });
}
