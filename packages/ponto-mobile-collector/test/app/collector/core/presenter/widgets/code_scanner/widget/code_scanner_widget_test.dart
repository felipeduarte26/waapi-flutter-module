import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/presenter/widgets/code_scanner/cubit/code_scanner_cubit.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_design_system/senior_design_system.dart';

class MockCodeScannerCubit extends Mock implements CodeScannerCubit {}

class MockBarcodeScanner extends Mock implements BarcodeScanner {}

class MockValueNotifier extends Mock implements ValueNotifier<int> {
  @override
  int value = 1;
}

void main() {
  late CodeScannerCubit codeScannerCubit;
  late BarcodeScanner barcodeScanner;
  late ValueNotifier<int> limitTimeInSeconds;

  setUp(() {
    codeScannerCubit = MockCodeScannerCubit();
    barcodeScanner = MockBarcodeScanner();
    limitTimeInSeconds = MockValueNotifier();

    registerFallbackValue(() => {});

    when(
      () => limitTimeInSeconds.addListener(any()),
    ).thenReturn(null);

    when(
      () => limitTimeInSeconds.removeListener(any()),
    ).thenReturn(null);

    when(() => barcodeScanner.close()).thenAnswer((_) async => {});

    when(
      () => codeScannerCubit.limitTimeInSeconds,
    ).thenReturn(limitTimeInSeconds);

    when(
      () => codeScannerCubit.getBarcodeScanner(),
    ).thenReturn(barcodeScanner);
  });

  Widget getCodeScannerWidget({
    required Function(Barcode) onDetect,
    required Function() onExpired,
    int limitTimeInSeconds = 60,
  }) {
    return MaterialApp(
      home: Localizations(
        delegates: CollectorLocalizations.localizationsDelegates,
        locale: const Locale('pt'),
        child: Scaffold(
          body: SeniorDesignSystem(
            theme: SENIOR_LIGHT_THEME,
            child: CodeScannerWidget(
              onDetect: onDetect,
              onExpired: onExpired,
              codeScannerCubit: codeScannerCubit,
              secondsLeftToExpire: (int seconds) {},
            ),
          ),
        ),
      ),
    );
  }

  group('CodeScannerWidget', () {
    testWidgets('Should show CodeCameraWidget', (widgetTester) async {
      final result =
          getCodeScannerWidget(onExpired: () {}, onDetect: (barcode) {});
      await widgetTester.pumpWidget(result);
      await widgetTester.pumpAndSettle();

      expect(find.text('Camera preview'), findsOneWidget);
      verify(() => limitTimeInSeconds.addListener(any()));
      verify(() => codeScannerCubit.limitTimeInSeconds);
    });

    testWidgets('Should call onExpired when timer is over',
        (widgetTester) async {
      bool isExpired = false;
      final result = getCodeScannerWidget(
        onExpired: () {
          isExpired = true;
          expect(isExpired, isTrue);
        },
        onDetect: (barcode) {},
        limitTimeInSeconds: 5,
      );
      await widgetTester.pumpWidget(result);
      await widgetTester.pumpAndSettle(const Duration(seconds: 7));
    });
  });
}
