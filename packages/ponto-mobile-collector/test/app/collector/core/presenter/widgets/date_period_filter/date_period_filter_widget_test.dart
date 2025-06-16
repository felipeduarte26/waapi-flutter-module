import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/generated/l10n/collector_localizations_en.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_design_system/senior_design_system.dart';

class MockCallback extends Mock {
  void call(String initDate, String endDate);
}

void main() {
  late IUtils utils;

  Widget getWidget(
    String locale,
    Widget widget,
  ) {
    return SeniorDesignSystem(
      theme: SENIOR_LIGHT_THEME,
      child: MaterialApp(
        home: Localizations(
          delegates: CollectorLocalizations.localizationsDelegates,
          locale: Locale(locale),
          child: Scaffold(
            body: widget,
          ),
        ),
      ),
    );
  }

  setUp(
    () {
      utils = Utils();
    },
  );

  group(
    'DatePeriodFilterWidget test en',
    () {
      const locale = Locale('en');

      testWidgets(
        'Texts and Icons',
        (tester) async {
          final collectorLocalizations = lookupCollectorLocalizations(locale);

          Widget widget = getWidget(
            locale.languageCode,
            DatePeriodFilterWidget(
              utils: utils,
            ),
          );

          await tester.pumpWidget(widget);

          expect(
            find.text(
              collectorLocalizations.selectPeriodToFilter,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.period,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.init,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.end,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              utils.getDateMaskFromLocale(
                collectorLocalizations.localeName,
              ),
            ),
            findsNWidgets(2),
          );

          expect(
            find.byIcon(
              FontAwesomeIcons.solidCalendarDays,
            ),
            findsNWidgets(2),
          );

          expect(
            find.text(
              collectorLocalizations.filter,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.cancel,
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'Text Form Fields',
        (tester) async {
          final collectorLocalizations = lookupCollectorLocalizations(locale);

          Widget widget = getWidget(
            locale.languageCode,
            DatePeriodFilterWidget(
              utils: utils,
            ),
          );

          await tester.pumpWidget(widget);

          final initDateTextFormFieldFinder = find.widgetWithText(
            SeniorTextField,
            collectorLocalizations.init,
          );
          final initDateTextFormFieldWidget = tester.widget<SeniorTextField>(
            initDateTextFormFieldFinder,
          );
          final initDateValidator = initDateTextFormFieldWidget.validator!;

          final endDateTextFormFieldFinder = find.widgetWithText(
            SeniorTextField,
            collectorLocalizations.end,
          );
          final endDateTextFormFieldWidget = tester.widget<SeniorTextField>(
            endDateTextFormFieldFinder,
          );
          final endDateValidator = endDateTextFormFieldWidget.validator!;

          await tester.enterText(
            initDateTextFormFieldFinder,
            '30',
          );
          await tester.pump();

          expect(
            find.text(
              '30',
            ),
            findsOneWidget,
          );

          expect(
            initDateValidator(
              '30',
            ),
            collectorLocalizations.invalidDate,
          );

          await tester.enterText(
            initDateTextFormFieldFinder,
            '30112000',
          );
          await tester.pump();

          expect(
            find.text(
              '30/11/2000',
            ),
            findsOneWidget,
          );

          expect(
            initDateValidator(
              '30/11/2000',
            ),
            collectorLocalizations.invalidDateFormat,
          );

          await tester.enterText(
            initDateTextFormFieldFinder,
            '12312000',
          );
          await tester.enterText(
            endDateTextFormFieldFinder,
            '11302000',
          );
          await tester.pump();

          expect(
            find.text(
              '12/31/2000',
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              '11/30/2000',
            ),
            findsOneWidget,
          );

          expect(
            initDateValidator(
              '12/31/2000',
            ),
            collectorLocalizations.moreThanEndDate,
          );
          expect(
            endDateValidator(
              '11/30/2000',
            ),
            collectorLocalizations.lessThanStartDate,
          );

          await tester.enterText(
            initDateTextFormFieldFinder,
            '11302000',
          );
          await tester.enterText(
            endDateTextFormFieldFinder,
            '',
          );
          await tester.pump();

          expect(
            find.text(
              '11/30/2000',
            ),
            findsOneWidget,
          );

          expect(
            initDateValidator(
              '11/30/2000',
            ),
            null,
          );

          await tester.enterText(
            initDateTextFormFieldFinder,
            '',
          );
          await tester.enterText(
            endDateTextFormFieldFinder,
            '31',
          );
          await tester.pump();

          expect(
            find.text(
              '31',
            ),
            findsOneWidget,
          );

          expect(
            endDateValidator(
              '31',
            ),
            collectorLocalizations.invalidDate,
          );

          await tester.enterText(
            endDateTextFormFieldFinder,
            '31122000',
          );
          await tester.pump();

          expect(
            find.text(
              '31/12/2000',
            ),
            findsOneWidget,
          );

          expect(
            endDateValidator(
              '31/12/2000',
            ),
            collectorLocalizations.invalidDateFormat,
          );

          await tester.enterText(
            endDateTextFormFieldFinder,
            '12312000',
          );
          await tester.pump();

          expect(
            find.text(
              '12/31/2000',
            ),
            findsOneWidget,
          );

          expect(
            endDateValidator(
              '12/31/2000',
            ),
            null,
          );
        },
      );
    },
  );

  group(
    'DatePeriodFilterWidget test es',
    () {
      const locale = Locale('es');

      testWidgets(
        'Texts and Icons',
        (tester) async {
          final collectorLocalizations = lookupCollectorLocalizations(locale);

          Widget widget = getWidget(
            locale.languageCode,
            DatePeriodFilterWidget(
              utils: utils,
            ),
          );

          await tester.pumpWidget(widget);

          expect(
            find.text(
              collectorLocalizations.selectPeriodToFilter,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.period,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.init,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.end,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              utils.getDateMaskFromLocale(
                collectorLocalizations.localeName,
              ),
            ),
            findsNWidgets(2),
          );

          expect(
            find.byIcon(
              FontAwesomeIcons.solidCalendarDays,
            ),
            findsNWidgets(2),
          );

          expect(
            find.text(
              collectorLocalizations.filter,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.cancel,
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'Text Form Fields',
        (tester) async {
          final collectorLocalizations = lookupCollectorLocalizations(locale);

          Widget widget = getWidget(
            locale.languageCode,
            DatePeriodFilterWidget(
              utils: utils,
            ),
          );

          await tester.pumpWidget(widget);

          final initDateTextFormFieldFinder = find.widgetWithText(
            SeniorTextField,
            collectorLocalizations.init,
          );
          final initDateTextFormFieldWidget = tester.widget<SeniorTextField>(
            initDateTextFormFieldFinder,
          );
          final initDateValidator = initDateTextFormFieldWidget.validator!;

          final endDateTextFormFieldFinder = find.widgetWithText(
            SeniorTextField,
            collectorLocalizations.end,
          );
          final endDateTextFormFieldWidget = tester.widget<SeniorTextField>(
            endDateTextFormFieldFinder,
          );
          final endDateValidator = endDateTextFormFieldWidget.validator!;

          await tester.enterText(
            initDateTextFormFieldFinder,
            '11',
          );
          await tester.pump();

          expect(
            find.text(
              '11',
            ),
            findsOneWidget,
          );

          expect(
            initDateValidator(
              '11',
            ),
            collectorLocalizations.invalidDate,
          );

          await tester.enterText(
            initDateTextFormFieldFinder,
            '11302000',
          );
          await tester.pump();

          expect(
            find.text(
              '11/30/2000',
            ),
            findsOneWidget,
          );

          expect(
            initDateValidator(
              '11/30/2000',
            ),
            collectorLocalizations.invalidDateFormat,
          );

          await tester.enterText(
            initDateTextFormFieldFinder,
            '31122000',
          );
          await tester.enterText(
            endDateTextFormFieldFinder,
            '30112000',
          );
          await tester.pump();

          expect(
            find.text(
              '31/12/2000',
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              '30/11/2000',
            ),
            findsOneWidget,
          );

          expect(
            initDateValidator(
              '31/12/2000',
            ),
            collectorLocalizations.moreThanEndDate,
          );

          expect(
            endDateValidator(
              '30/11/2000',
            ),
            collectorLocalizations.lessThanStartDate,
          );

          await tester.enterText(
            initDateTextFormFieldFinder,
            '30112000',
          );
          await tester.enterText(
            endDateTextFormFieldFinder,
            '',
          );
          await tester.pump();

          expect(
            find.text(
              '30/11/2000',
            ),
            findsOneWidget,
          );

          expect(
            initDateValidator(
              '30/11/2000',
            ),
            null,
          );

          await tester.enterText(
            initDateTextFormFieldFinder,
            '',
          );
          await tester.enterText(
            endDateTextFormFieldFinder,
            '12',
          );
          await tester.pump();

          expect(
            find.text(
              '12',
            ),
            findsOneWidget,
          );

          expect(
            endDateValidator(
              '12',
            ),
            collectorLocalizations.invalidDate,
          );

          await tester.enterText(
            endDateTextFormFieldFinder,
            '12312000',
          );
          await tester.pump();

          expect(
            find.text(
              '12/31/2000',
            ),
            findsOneWidget,
          );

          expect(
            endDateValidator(
              '12/31/2000',
            ),
            collectorLocalizations.invalidDateFormat,
          );

          await tester.enterText(
            endDateTextFormFieldFinder,
            '31122000',
          );
          await tester.pump();

          expect(
            find.text(
              '31/12/2000',
            ),
            findsOneWidget,
          );

          expect(
            endDateValidator(
              '31/12/2000',
            ),
            null,
          );
        },
      );
    },
  );

  group(
    'DatePeriodFilterWidget test pt',
    () {
      const locale = Locale('pt');

      testWidgets(
        'Texts and Icons',
        (tester) async {
          final collectorLocalizations = lookupCollectorLocalizations(locale);

          Widget widget = getWidget(
            locale.languageCode,
            DatePeriodFilterWidget(
              utils: utils,
            ),
          );

          await tester.pumpWidget(widget);

          expect(
            find.text(
              collectorLocalizations.selectPeriodToFilter,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.period,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.init,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.end,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              utils.getDateMaskFromLocale(
                collectorLocalizations.localeName,
              ),
            ),
            findsNWidgets(2),
          );

          expect(
            find.byIcon(
              FontAwesomeIcons.solidCalendarDays,
            ),
            findsNWidgets(2),
          );

          expect(
            find.text(
              collectorLocalizations.filter,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.cancel,
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'Text Form Fields',
        (tester) async {
          final collectorLocalizations = lookupCollectorLocalizations(locale);

          Widget widget = getWidget(
            locale.languageCode,
            DatePeriodFilterWidget(
              utils: utils,
            ),
          );

          await tester.pumpWidget(widget);

          final initDateTextFormFieldFinder = find.widgetWithText(
            SeniorTextField,
            collectorLocalizations.init,
          );
          final initDateTextFormFieldWidget = tester.widget<SeniorTextField>(
            initDateTextFormFieldFinder,
          );
          final initDateValidator = initDateTextFormFieldWidget.validator!;

          final endDateTextFormFieldFinder = find.widgetWithText(
            SeniorTextField,
            collectorLocalizations.end,
          );
          final endDateTextFormFieldWidget = tester.widget<SeniorTextField>(
            endDateTextFormFieldFinder,
          );
          final endDateValidator = endDateTextFormFieldWidget.validator!;

          await tester.enterText(
            initDateTextFormFieldFinder,
            '11',
          );
          await tester.pump();

          expect(
            find.text(
              '11',
            ),
            findsOneWidget,
          );

          expect(
            initDateValidator(
              '11',
            ),
            collectorLocalizations.invalidDate,
          );

          await tester.enterText(
            initDateTextFormFieldFinder,
            '11302000',
          );
          await tester.pump();

          expect(
            find.text(
              '11/30/2000',
            ),
            findsOneWidget,
          );

          expect(
            initDateValidator(
              '11/30/2000',
            ),
            collectorLocalizations.invalidDateFormat,
          );

          await tester.enterText(
            initDateTextFormFieldFinder,
            '31122000',
          );
          await tester.enterText(
            endDateTextFormFieldFinder,
            '30112000',
          );
          await tester.pump();

          expect(
            find.text(
              '31/12/2000',
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              '30/11/2000',
            ),
            findsOneWidget,
          );

          expect(
            initDateValidator(
              '31/12/2000',
            ),
            collectorLocalizations.moreThanEndDate,
          );

          expect(
            endDateValidator(
              '30/11/2000',
            ),
            collectorLocalizations.lessThanStartDate,
          );

          await tester.enterText(
            initDateTextFormFieldFinder,
            '30112000',
          );
          await tester.enterText(
            endDateTextFormFieldFinder,
            '',
          );
          await tester.pump();

          expect(
            find.text(
              '30/11/2000',
            ),
            findsOneWidget,
          );

          expect(
            initDateValidator(
              '30/11/2000',
            ),
            null,
          );

          await tester.enterText(
            initDateTextFormFieldFinder,
            '',
          );
          await tester.enterText(
            endDateTextFormFieldFinder,
            '12',
          );
          await tester.pump();

          expect(
            find.text(
              '12',
            ),
            findsOneWidget,
          );

          expect(
            endDateValidator(
              '12',
            ),
            collectorLocalizations.invalidDate,
          );

          await tester.enterText(
            endDateTextFormFieldFinder,
            '12312000',
          );
          await tester.pump();

          expect(
            find.text(
              '12/31/2000',
            ),
            findsOneWidget,
          );

          expect(
            endDateValidator(
              '12/31/2000',
            ),
            collectorLocalizations.invalidDateFormat,
          );

          await tester.enterText(
            endDateTextFormFieldFinder,
            '31122000',
          );
          await tester.pump();

          expect(
            find.text(
              '31/12/2000',
            ),
            findsOneWidget,
          );

          expect(
            endDateValidator(
              '31/12/2000',
            ),
            null,
          );
        },
      );
    },
  );

  group(
    'DatePeriodFilterWidget test',
    () {
      testWidgets(
        'Filter button',
        (tester) async {
          const locale = Locale('en');
          final collectorLocalizations = lookupCollectorLocalizations(locale);

          final onFilterPressedMock = MockCallback();

          Widget widget = getWidget(
            locale.languageCode,
            DatePeriodFilterWidget(
              utils: utils,
              onFilterPressed: onFilterPressedMock.call,
            ),
          );

          await tester.pumpWidget(widget);

          await tester.enterText(
            find.widgetWithText(
              SeniorTextField,
              collectorLocalizations.init,
            ),
            '11302000',
          );
          await tester.pump();

          expect(
            find.text(
              '11/30/2000',
            ),
            findsOneWidget,
          );

          await tester.enterText(
            find.widgetWithText(
              SeniorTextField,
              collectorLocalizations.end,
            ),
            '12312000',
          );
          await tester.pump();

          expect(
            find.text(
              '12/31/2000',
            ),
            findsOneWidget,
          );

          final filterButtonFinder = find.text(
            collectorLocalizations.filter,
          );

          await tester.tap(filterButtonFinder);
          await tester.pump();

          verify(
            () => onFilterPressedMock(
              '11/30/2000',
              '12/31/2000',
            ),
          ).called(1);
        },
      );

      testWidgets('show calendar on click on initDateTextField test',
          (tester) async {
        const locale = Locale('en');
        final onFilterPressedMock = MockCallback();

        Widget widget = getWidget(
          locale.languageCode,
          DatePeriodFilterWidget(
            utils: utils,
            onFilterPressed: onFilterPressedMock.call,
          ),
        );

        await tester.pumpWidget(widget);

        Finder initDateTextFormFieldFinder =
            find.byKey(const Key('initDateTextField'));
        expect(initDateTextFormFieldFinder, findsOneWidget);

        await tester.tap(initDateTextFormFieldFinder);
        await tester.pumpAndSettle();
        Finder datePickerFinder =
            find.text(CollectorLocalizationsEn().selectTheStartingDate);
        expect(datePickerFinder, findsOneWidget);
        await tester.pumpAndSettle();
        Finder selectedDayFinder = find.text(DateTime.now().day.toString());
        await tester.tap(selectedDayFinder.last);
        await tester.pumpAndSettle();
        expect(find.byKey(const Key('initDateTextField')), findsOneWidget);
      });

      testWidgets('show calendar on click on endDateTextField test',
          (tester) async {
        const locale = Locale('en');
        final onFilterPressedMock = MockCallback();

        Widget widget = getWidget(
          locale.languageCode,
          DatePeriodFilterWidget(
            utils: utils,
            onFilterPressed: onFilterPressedMock.call,
          ),
        );

        await tester.pumpWidget(widget);

        Finder initDateTextFormFieldFinder =
            find.byKey(const Key('endDateTextField'));
        expect(initDateTextFormFieldFinder, findsOneWidget);

        await tester.tap(initDateTextFormFieldFinder);
        await tester.pumpAndSettle();
        
        Finder datePickerFinder =
            find.text(CollectorLocalizationsEn().selectTheEndDate);
        expect(datePickerFinder, findsOneWidget);
        await tester.pumpAndSettle();
        Finder selectedDayFinder = find.text(DateTime.now().day.toString());
        await tester.tap(selectedDayFinder.last);
        await tester.pumpAndSettle();
        expect(find.byKey(const Key('endDateTextField')), findsOneWidget);
      });
    },
  );
}
