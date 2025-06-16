import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_design_system/senior_design_system.dart';

Widget makeTestable(Widget widget) => SeniorDesignSystem(
      theme: SENIOR_LIGHT_THEME,
      child: MaterialApp(
        home: widget,
      ),
    );

void main() {
  testWidgets(
    'test BadgeSlider Multiple Select ',
    (WidgetTester tester) async {
      int callbackCalledTimes = 0;

      final List<BadgeInfo> badgesInfo = [
        BadgeInfo(
          label: 'pendencias (2)',
          value: FilterBadgeType.filterByEmployee,
          isSelected: false,
          callback: (_) {},
        ),
        BadgeInfo(
          isSelected: true,
          label: 'Com gestor (2)',
          value: FilterBadgeType.filterByPeriod,
          callback: (p0) {},
        ),
      ];

      await tester.pumpWidget(
        makeTestable(
          BadgesSlider(
            badgesInfo: badgesInfo,
            multipleSelect: true,
          ),
        ),
      );

      var text1 = find.text('pendencias (2)');
      var text2 = find.text('Com gestor (2)');

      expect(text1, findsOneWidget);
      expect(text2, findsOneWidget);
      expect(callbackCalledTimes, 0);
    },
  );
}
