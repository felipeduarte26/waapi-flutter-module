import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

void main() {
  test(
    'TabActionState state test',
    () {
      // Act
      TabActionState state = TabActionState(tabIndex: 0);

      // Assert
      expect(state.tabIndex, 0);
      expect(tabActionInitialState.tabIndex, 0);
    },
  );
}
