import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_design_system/senior_design_system.dart';

void main() {
  Widget getWidget(Widget widget) {
    return MaterialApp(
      home: SeniorDesignSystem(
        theme: SENIOR_LIGHT_THEME,
        child: widget,
      ),
    );
  }

  testWidgets(
    'Validates not to find even an icon',
    (tester) async {
      Widget widget = getWidget(
        const ClockingEventStatusWidget(
          isSynchronized: true,
        ),
      );
      await tester.pumpWidget(widget);

      final isUnsynchronizedIconFinder = find.byIcon(FontAwesomeIcons.rotate);
      final isOddIconFinder = find.byIcon(FontAwesomeIcons.solidCalendarXmark);
      final isRemotenessIconFinder = find.byIcon(FontAwesomeIcons.userInjured);
      final isOvernightIconFinder = find.byIcon(FontAwesomeIcons.solidMoon);

      expect(isUnsynchronizedIconFinder, findsNWidgets(0));
      expect(isOddIconFinder, findsNWidgets(0));
      expect(isRemotenessIconFinder, findsNWidgets(0));
      expect(isOvernightIconFinder, findsNWidgets(0));
    },
  );

  testWidgets(
    'Validates if the 3 icons are found',
    (tester) async {
      Widget widget = getWidget(
        const ClockingEventStatusWidget(
          isOdd: true,
          isRemoteness: true,
          isSynchronized: false,
          isOvernight: true,
        ),
      );
      await tester.pumpWidget(widget);
      final isUnsynchronizedIconFinder = find.byIcon(FontAwesomeIcons.rotate);
      final isOddIconFinder = find.byIcon(FontAwesomeIcons.solidCalendarXmark);
      final isRemotenessIconFinder = find.byIcon(FontAwesomeIcons.userInjured);
      final isOvernightIconFinder = find.byIcon(FontAwesomeIcons.solidMoon);

      expect(isUnsynchronizedIconFinder, findsNWidgets(1));
      expect(isOddIconFinder, findsNWidgets(1));
      expect(isRemotenessIconFinder, findsNWidgets(1));
      expect(isOvernightIconFinder, findsNWidgets(1));
    },
  );
}
