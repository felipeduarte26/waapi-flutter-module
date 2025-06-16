import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/modules/time_adjustment/presenter/widgets/selected_employee_widget.dart';
import 'package:ponto_mobile_collector/generated/l10n/collector_localizations.dart';
import 'package:ponto_mobile_collector/generated/l10n/collector_localizations_pt.dart';
import 'package:senior_design_system/senior_design_system.dart';

void main() {
  Widget getWidget(Widget widget) {
    return SeniorDesignSystem(
      theme: SENIOR_LIGHT_THEME,
      child: MaterialApp(
        theme: SENIOR_LIGHT_THEME.themeData,
        home: Localizations(
          locale: const Locale('pt'),
          delegates: const [
            CollectorLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          child: Scaffold(body: widget),
        ),
      ),
    );
  }

  group('SelectedEmployeeWidget', () {
    testWidgets('show widget successfully test', (tester) async {
      String tEmployeeName = 'Employee Name';
      await tester.pumpWidget(
        getWidget(SelectedEmployeeWidget(name: tEmployeeName)),
      );

      expect(find.text(tEmployeeName), findsOneWidget);
      expect(find.text(CollectorLocalizationsPt().change), findsOneWidget);
      expect(find.byType(SeniorProfilePicture), findsOneWidget);
    });
  });
}
