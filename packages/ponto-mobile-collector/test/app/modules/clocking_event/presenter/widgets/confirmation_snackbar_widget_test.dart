import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/get_receipt_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/show_bottom_sheet_usecase.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_design_system/senior_design_system.dart';

import '../../../../../mocks/clocking_event_mock.dart';
import '../../../../../mocks/clocking_event_receipt_model_mock.dart';

class MockGetReceiptUsecase extends Mock implements GetReceiptUsecase {}

class MockShowBottomSheetUsecase extends Mock
    implements ShowBottomSheetUsecase {}

class MockUtils extends Mock implements IUtils {}

class FakeBuildcontext extends Fake implements BuildContext {}

void main() {
  late ConfirmationSnackbarWidget confirmationSnackbarWidget;
  late GetReceiptUsecase getReceiptUsecase;
  late ShowBottomSheetUsecase showBottomSheetUsecase;
  late IUtils utils;
  late BuildContext buildContext;
  late Widget widget;

  setUp(() {
    getReceiptUsecase = MockGetReceiptUsecase();
    showBottomSheetUsecase = MockShowBottomSheetUsecase();
    utils = MockUtils();
    buildContext = FakeBuildcontext();
    widget = const Text('content');

    registerFallbackValue(buildContext);
    registerFallbackValue(widget);

    when(
      () => utils.formatTime(
        dateTime: clockingEventMock.getDateTimeEvent(),
        locale: 'pt',
      ),
    ).thenReturn('11:33');

    when(
      () => getReceiptUsecase.call(
        clockingEvent: clockingEventMock,
        locale: 'pt',
      ),
    ).thenReturn(clockingEventReceiptModelMock);

    when(
      () => showBottomSheetUsecase.call(
        context: any(named: 'context'),
        content: any(named: 'content'),
      ),
    ).thenAnswer((_) async => {});
  });

  Widget getWidget() {
    return SeniorDesignSystem(
      theme: SENIOR_LIGHT_THEME,
      child: MaterialApp(
        theme: SENIOR_LIGHT_THEME.themeData,
        home: Localizations(
          delegates: CollectorLocalizations.localizationsDelegates,
          locale: const Locale('pt'),
          child: Scaffold(
            body: Builder(
              builder: (context) {
                return FilledButton(
                  child: const Text('show'),
                  onPressed: () {
                    confirmationSnackbarWidget = ConfirmationSnackbarWidget(
                      context: context,
                      getReceiptUsecase: getReceiptUsecase,
                      showBottomSheetUsecase: showBottomSheetUsecase,
                      utils: utils,
                    );

                    confirmationSnackbarWidget.show(
                      clockingEvent: clockingEventMock,
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

  group('ConfirmationSnackbarWidget', () {
    testWidgets('show snackbar test', (tester) async {
      await tester.pumpWidget(getWidget());
      Finder buttonFinder = find.text('show');
      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();
      Finder msgFinder = find.text(
        'Marcação realizada às 11:33 no dia 29/10/2023 para José Antônio',
      );
      Finder actionFinder = find.text('Visualizar');
      expect(msgFinder, findsOneWidget);
      expect(actionFinder, findsOneWidget);

      await tester.tap(actionFinder);
      await tester.pumpAndSettle();

      verify(
        () => getReceiptUsecase.call(
          clockingEvent: clockingEventMock,
          locale: 'pt',
        ),
      );

      verify(
        () => showBottomSheetUsecase.call(
          context: any(named: 'context'),
          content: any(named: 'content'),
        ),
      );

      verifyNoMoreInteractions(getReceiptUsecase);
      verifyNoMoreInteractions(showBottomSheetUsecase);
    });
  });
}
