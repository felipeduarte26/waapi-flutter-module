import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/timeline_item_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/services/bottom_sheet_service/bottom_sheet_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/type_journey_time_enum.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/show_bottom_sheet_usecase.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_design_system/senior_design_system.dart';

class MockUtils extends Mock implements IUtils {}

class MockShowBottomSheetUsecase extends Mock
    implements IShowBottomSheetUsecase {}

void main() {
  late IUtils utils;
  late IShowBottomSheetUsecase showBottomSheetUsecase;
  // late BuildContext buildContext;

  Widget getWidget(
    String locale,
  ) {
    return SeniorDesignSystem(
      theme: SENIOR_LIGHT_THEME,
      child: MaterialApp(
        home: Localizations(
          delegates: CollectorLocalizations.localizationsDelegates,
          locale: Locale(locale),
          child: Scaffold(
            body: DriversJourneyTimelineWidget(
              showBottomSheetUsecase: showBottomSheetUsecase,
              utils: utils,
              journeyTimeDetailsList: const [],
              timelineItems: [
                TimelineItemDto(
                  isBeginning: true,
                  endDate: null,
                  startDate: DateTime(2023, 03, 28, 08, 00),
                  typeJourneyTimeEnum: TypeJourneyTimeEnum.working,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  setUp(
    () {
      utils = MockUtils();
      showBottomSheetUsecase = ShowBottomSheetUsecase(
        bottomSheetService: BottomSheetService(),
      );
    },
  );

  testWidgets(
    'DriversJourneyTimelineWidget show test',
    (tester) async {
      const locale = Locale('en');
      final collectorLocalizations = lookupCollectorLocalizations(locale);

      when(
        () => utils.formatTime(
          dateTime: DateTime(2023, 03, 28, 08, 00),
          locale: locale.languageCode,
        ),
      ).thenReturn(
        Utils().formatTime(
          dateTime: DateTime(2023, 03, 28, 08, 00),
          locale: locale.languageCode,
        ),
      );

      when(
        () => utils.formatTime(
          dateTime: DateTime(2023, 03, 28, 08, 00)
              .add(const Duration(hours: 3, minutes: 15)),
          locale: locale.languageCode,
        ),
      ).thenReturn(
        Utils().formatTime(
          dateTime: DateTime(2023, 03, 28, 08, 00)
              .add(const Duration(hours: 3, minutes: 15)),
          locale: locale.languageCode,
        ),
      );

      Widget widget = getWidget(locale.languageCode);

      await tester.pumpWidget(widget);

      /// TODO: quando feita a lógica para identificar o tipo de trabalho do motorista, identificar todos os ícones que devem ser exibidos

      final gestureDetectorFinder = find.byType(
        GestureDetector,
      );
      expect(
        gestureDetectorFinder,
        findsWidgets,
      );

      final workingCardButton = find.widgetWithIcon(
        GestureDetector,
        DriversWorkStatusEnum.working.icon,
      );
      expect(
        workingCardButton,
        findsOneWidget,
      );
      expect(
        find.widgetWithText(
          GestureDetector,
          collectorLocalizations.working,
        ),
        findsOneWidget,
      );

      final foodTimeCardButton = find.widgetWithIcon(
        GestureDetector,
        DriversWorkStatusEnum.foodTime.icon,
      );
      expect(
        foodTimeCardButton,
        findsOneWidget,
      );
      expect(
        find.widgetWithText(
          GestureDetector,
          collectorLocalizations.foodTime,
        ),
        findsOneWidget,
      );

      final drivingCardButton = find.widgetWithIcon(
        GestureDetector,
        DriversWorkStatusEnum.driving.icon,
      );
      expect(
        drivingCardButton,
        findsOneWidget,
      );
      expect(
        find.widgetWithText(
          GestureDetector,
          collectorLocalizations.driving,
        ),
        findsOneWidget,
      );

      final mandatoryBreakCardButton = find.widgetWithIcon(
        GestureDetector,
        DriversWorkStatusEnum.mandatoryBreak.icon,
      );
      expect(
        mandatoryBreakCardButton,
        findsOneWidget,
      );
      expect(
        find.widgetWithText(
          GestureDetector,
          collectorLocalizations.mandatoryBreak,
        ),
        findsOneWidget,
      );

      final watingCardButton = find.widgetWithIcon(
        GestureDetector,
        DriversWorkStatusEnum.waiting.icon,
      );
      expect(
        watingCardButton,
        findsOneWidget,
      );
      expect(
        find.widgetWithText(
          GestureDetector,
          collectorLocalizations.waiting,
        ),
        findsOneWidget,
      );

      await tester.tap(workingCardButton);
      await tester.pumpAndSettle();
      expect(
        find.text(
          collectorLocalizations.workingStatusDescription,
        ),
        findsOneWidget,
      );

      // final thumbsDownIcon = find.byWidgetPredicate(
      //   (widget) {
      //     return widget is SeniorIconButton &&
      //         widget.icon == FontAwesomeIcons.solidThumbsDown;
      //   },
      // );
      // expect(
      //   thumbsDownIcon,
      //   findsOneWidget,
      // );
      // final thumbsUpIcon = find.byWidgetPredicate(
      //   (widget) {
      //     return widget is SeniorIconButton &&
      //         widget.icon == FontAwesomeIcons.solidThumbsUp;
      //   },
      // );
      // expect(
      //   thumbsUpIcon,
      //   findsOneWidget,
      // );

      final cardCloseButton = find.byIcon(
        FontAwesomeIcons.xmark,
      );
      expect(
        cardCloseButton,
        findsOneWidget,
      );
      await tester.tap(cardCloseButton);
      await tester.pumpAndSettle();

      await tester.tap(foodTimeCardButton);
      await tester.pumpAndSettle();
      expect(
        find.text(
          collectorLocalizations.foodTimeStatusDescriptionModal,
        ),
        findsOneWidget,
      );

      // expect(
      //   thumbsDownIcon,
      //   findsOneWidget,
      // );
      // expect(
      //   thumbsUpIcon,
      //   findsOneWidget,
      // );

      expect(
        cardCloseButton,
        findsOneWidget,
      );
      await tester.tap(cardCloseButton);
      await tester.pumpAndSettle();

      await tester.tap(drivingCardButton);
      await tester.pumpAndSettle();
      expect(
        find.text(
          collectorLocalizations.drivingStatusDescription,
        ),
        findsOneWidget,
      );

      // expect(
      //   thumbsDownIcon,
      //   findsOneWidget,
      // );
      // expect(
      //   thumbsUpIcon,
      //   findsOneWidget,
      // );

      expect(
        cardCloseButton,
        findsOneWidget,
      );
      await tester.tap(cardCloseButton);
      await tester.pumpAndSettle();

      await tester.tap(mandatoryBreakCardButton);
      await tester.pumpAndSettle();
      expect(
        find.text(
          collectorLocalizations.mandatoryBreakStatusDescription,
        ),
        findsOneWidget,
      );

      // expect(
      //   thumbsDownIcon,
      //   findsOneWidget,
      // );
      // expect(
      //   thumbsUpIcon,
      //   findsOneWidget,
      // );

      expect(
        cardCloseButton,
        findsOneWidget,
      );
      await tester.tap(cardCloseButton);
      await tester.pumpAndSettle();

      await tester.tap(watingCardButton);
      await tester.pumpAndSettle();
      expect(
        find.text(
          collectorLocalizations.waitingStatusDescription,
        ),
        findsOneWidget,
      );

      // expect(
      //   thumbsDownIcon,
      //   findsOneWidget,
      // );
      // expect(
      //   thumbsUpIcon,
      //   findsOneWidget,
      // );

      expect(
        cardCloseButton,
        findsOneWidget,
      );
      await tester.tap(cardCloseButton);
      await tester.pumpAndSettle();
    },
  );
}
