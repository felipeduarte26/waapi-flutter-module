import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/widgets/empty_state_widget.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/repositories/theme_repository.dart';
import 'package:senior_design_system/theme/senior_theme_data.dart';

void main() {
  testWidgets('Teste do EmptyStateWidget', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider<ThemeRepository>(
        create: (_) => ThemeRepository(
          const SeniorThemeData(
            themeType: ThemeType.light,
          ),
        ),
        child: const MaterialApp(
          home: EmptyStateWidget(
            title: 'Texto Inicial',
            imagePath: 'assets/image.svg',
            isTest: true,
          ),
        ),
      ),
    );

    expect(find.text('Texto Inicial'), findsOneWidget);
  });

    testWidgets('Teste do EmptyStateWidget Subtitle', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider<ThemeRepository>(
        create: (_) => ThemeRepository(
          const SeniorThemeData(
            themeType: ThemeType.light,
          ),
        ),
        child: const MaterialApp(
          home: EmptyStateWidget(
            title: 'Texto Inicial',
            subTitle: 'Subtitulo',
            imagePath: 'assets/image.svg',
            isTest: true,
          ),
        ),
      ),
    );

    expect(find.text('Texto Inicial'), findsOneWidget);
    expect(find.text('Subtitulo'), findsOneWidget);
  });
}
