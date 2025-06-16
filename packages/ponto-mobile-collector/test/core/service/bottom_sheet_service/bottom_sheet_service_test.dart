import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/bottom_sheet_service/ibottom_sheet_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/services/bottom_sheet_service/bottom_sheet_service.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_design_system/senior_design_system.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  Widget getWidget(
    String locale,
    IBottomSheetService service,
    List<Widget> content, {
    required bool userRootContext,
    bool isCustom = false,
  }) {
    return MaterialApp(
      home: Localizations(
        delegates: CollectorLocalizations.localizationsDelegates,
        locale: Locale(locale),
        child: Scaffold(
          body: SeniorDesignSystem(
            theme: isCustom
                ? SENIOR_LIGHT_THEME.copyWith(
                    themeType: ThemeType.custom,
                    primaryColor: Colors.red,
                  )
                : SENIOR_LIGHT_THEME,
            child: Builder(
              builder: (BuildContext context) {
                return SeniorButton(
                  label: 'ButtomSheet',
                  onPressed: () {
                    service.show(
                      context: context,
                      content: content,
                      userRootContext: userRootContext,
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  group(
    'Bottom Sheet Service test',
    () {
      testWidgets(
        'Show sucess test',
        (tester) async {
          IBottomSheetService service = BottomSheetService();
          List<Widget> content = [const Text('foo')];
          registerFallbackValue(MockBuildContext());
          Widget widget =
              getWidget('pt', service, content, userRootContext: false);
          await tester.pumpWidget(widget);

          Finder buttonFinder = find.text('ButtomSheet');
          expect(buttonFinder, findsOneWidget);

          bool error = false;
          try {
            await tester.tap(buttonFinder);
          } on Exception catch (_) {
            error = true;
          }

          expect(error, false);
        },
      );

      testWidgets(
        'Show sucess test with custom theme',
        (tester) async {
          IBottomSheetService service = BottomSheetService();
          List<Widget> content = [const Text('foo')];
          registerFallbackValue(MockBuildContext());
          Widget widget = getWidget(
            'pt',
            service,
            content,
            userRootContext: false,
            isCustom: true,
          );
          await tester.pumpWidget(widget);

          Finder buttonFinder = find.text('ButtomSheet');
          expect(buttonFinder, findsOneWidget);

          bool error = false;
          try {
            await tester.tap(buttonFinder);
          } on Exception catch (_) {
            error = true;
          }

          expect(error, false);
        },
      );
    },
  );
}
