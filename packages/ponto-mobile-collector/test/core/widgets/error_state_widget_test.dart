import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/widgets/error_state_widget.dart';
import 'package:ponto_mobile_collector/generated/l10n/collector_localizations.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/repositories/theme_repository.dart';
import 'package:senior_design_system/theme/senior_theme_data.dart';

void main() {
  testWidgets('Teste do ErrorStateWidget', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider<ThemeRepository>(
          create: (_) => ThemeRepository(
            const SeniorThemeData(
              themeType: ThemeType.light,
            ),
          ),
          child: MaterialApp(
            localizationsDelegates: const [
              CollectorLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''),
              Locale('pt', ''),
            ],
            home: Scaffold(
              body: ErrorStateWidget(
                title: 'Texto Inicial',
                imagePath: 'assets/image.svg',
                isTest: true,
                onTapTryAgain: () {},
              ),
            ),
          ),
        ),
      );

      expect(find.text('Texto Inicial'), findsOneWidget);
  });

    testWidgets('Teste do ErrorStateWidget Subtitle', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider<ThemeRepository>(
          create: (_) => ThemeRepository(
            const SeniorThemeData(
              themeType: ThemeType.light,
            ),
          ),
          child: MaterialApp(
            localizationsDelegates: const [
              CollectorLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''),
              Locale('pt', ''),
            ],
            home: Scaffold(
              body: ErrorStateWidget(
                title: 'Texto Inicial',
                subTitle: 'Subtítulo',
                imagePath: 'assets/image.svg',
                isTest: true,
                onTapTryAgain: () {},
              ),
            ),
          ),
        ),
      );

      expect(find.text('Texto Inicial'), findsOneWidget);
      expect(find.text('Subtítulo'), findsOneWidget);
  });
}
