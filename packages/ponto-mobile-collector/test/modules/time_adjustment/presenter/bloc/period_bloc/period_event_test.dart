import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';


void main() {

  var userIdentifier = 'username@tenant.com.br';
  test(
    'LoadingClockingEventEvent Test',
    () {
      DateTime date = DateTime.now();

      // Act
      LoadingClockingEventEvent event = LoadingClockingEventEvent(
        username: userIdentifier,
        initDate: date,
        endDate: date,
      );

      // Assert
      expect(event.initDate, date);
      expect(event.endDate, date);
    },
  );
}
