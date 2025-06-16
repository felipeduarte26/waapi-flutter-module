import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/extension/media_query_extension.dart';
import 'package:ponto_mobile_collector/generated/l10n/collector_localizations.dart';
import 'package:senior_design_system/senior_design_system.dart';

void main() {
  Widget buildWidget(Widget widget) {
    return MaterialApp(
      home: Localizations(
        delegates: CollectorLocalizations.localizationsDelegates,
        locale: const Locale('pt'),
        child: Scaffold(
          body: SeniorDesignSystem(
            theme: SENIOR_LIGHT_THEME,
            child: widget,
          ),
        ),
      ),
    );
  }

  testWidgets(
    'MediaQueryExtension test',
    (tester) async {
      late double heightSize;
      late double widthSize;
      late double notchHeight;
      late double bottomSize;
      late double seniorColorfulHeaderBodySize;
      late double bottomSheetSize;
      late double bottomSheetSizeContacts;
      late bool isSmallDevice;

      Widget widget = buildWidget(
        Center(
          child: Builder(
            builder: (BuildContext context) {
              heightSize = context.heightSize;
              widthSize = context.widthSize;
              notchHeight = context.notchHeight;

              bottomSize = context.bottomSize;
              seniorColorfulHeaderBodySize =
                  context.seniorColorfulHeaderBodySize;
              bottomSheetSize = context.bottomSheetSize;
              bottomSheetSizeContacts = context.bottomSheetSizeContacts;
              isSmallDevice = context.isSmallDevice;
              return const Text('foo');
            },
          ),
        ),
      );

      await tester.pumpWidget(widget);

      expect(widthSize, 800);
      expect(heightSize, 600);
      expect(notchHeight, 0);
      expect(bottomSize, 0);
      expect(seniorColorfulHeaderBodySize, 529);
      expect(bottomSheetSize, 544);
      expect(bottomSheetSizeContacts, 521);
      expect(isSmallDevice, false);
    },
  );
}
