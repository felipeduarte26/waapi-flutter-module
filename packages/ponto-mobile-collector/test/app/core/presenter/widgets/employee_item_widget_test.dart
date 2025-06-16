import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/presenter/screens/employee_item_widget.dart';
import 'package:ponto_mobile_collector/generated/l10n/collector_localizations.dart';
import 'package:senior_design_system/senior_design_system.dart';

Widget getWidget(String locale, Widget widget) {
  return MaterialApp(
    home: Localizations(
      delegates: CollectorLocalizations.localizationsDelegates,
      locale: Locale(locale),
      child: Scaffold(
        body: SeniorDesignSystem(
          theme: SENIOR_LIGHT_THEME,
          child: widget,
        ),
      ),
    ),
  );
}

void main() {
  String tName = 'name';
  String tIdentifier = 'identifier';
  int index = 234;
  bool tSelected = true;

  group('EmployeeItemWidget', () {
    testWidgets('Should show the widget correctly', (tester) async {
      var widget = getWidget(
        'pt',
        EmployeeItemWidget(
          identifier: tIdentifier,
          index: index,
          name: tName,
          onTap: () => {},
          selected: tSelected,
        ),
      );

      await tester.pumpWidget(widget);

      expect(find.text(tName), findsOneWidget);
      expect(find.text(tIdentifier), findsOneWidget);
    });
  });
}
