import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

void main() {
  test(
    'TimerAdjustmentEvent event test',
    () {
      // Act
      DateTime selectedDay = DateTime.now();
      LoadDayTimerAdjustmentEvent loadDayTimerAdjustmentEvent =
          LoadDayTimerAdjustmentEvent(
        selectedDay: selectedDay,
      );

      ShowReceiptTimerAdjustmentEvent showReceiptTimerAdjustmentEvent =
          ShowReceiptTimerAdjustmentEvent(
        clockingEventId: 'clockingEventId',
        locale: 'locale',
      );

      // Assert
      expect(loadDayTimerAdjustmentEvent.selectedDay, selectedDay);
      expect(
        showReceiptTimerAdjustmentEvent.clockingEventId,
        'clockingEventId',
      );
      expect(showReceiptTimerAdjustmentEvent.locale, 'locale');
    },
  );
}
