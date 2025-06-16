import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

void main() {
  test(
    'ChangeTabActionEvent event Test',
    () {

      // Act
      ChangeTabActionEvent event = ChangeTabActionEvent(tabIndexToChange: 1);

      // Assert
      expect(event.tabIndexToChange, 1);
    },
  );
}
