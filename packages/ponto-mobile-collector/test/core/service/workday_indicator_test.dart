import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

class DateTimeMock extends Mock implements DateTime {}

void main() {
  group('WorkdayIndicatorsTest', () {
    test('test workdays duration with pair clocking events', () {
      var workdayIndicators = WorkdayIndicators(
        clockingEvents: [
          DateTime.parse('2023-03-18T13:30:00.000Z'),
          DateTime.parse('2023-03-18T13:50:00.000Z'),
          DateTime.parse('2023-03-18T15:55:00.000Z'),
          DateTime.parse('2023-03-18T17:00:00.000Z'),
        ],
      );

      expect(
        workdayIndicators.breaks,
        const Duration(
          hours: 2,
          minutes: 5,
        ),
      );

      expect(
        workdayIndicators.workedHours(),
        const Duration(
          hours: 1,
          minutes: 25,
        ),
      );
    });
  });

  test('formatDuration test', () {
    Duration duration = const Duration(
      hours: 4,
      minutes: 20,
    );

    var response = WorkdayIndicators.formatDuration(duration);

    expect(response, ' 4h 20min');
  });
}
