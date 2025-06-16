import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

void main() {
  Widget makeTestableWidget(ThemeOption themeOption) {
    return SeniorDesignSystem(
      child: BaseAuthenticationScreen(
        themeOption: themeOption,
        child: const Text('TEST'),
      ),
    );
  }

  testWidgets('should render correctly passing ThemeOption.system',
      (tester) async {
    await tester.pumpWidget(makeTestableWidget(ThemeOption.system));

    final consumerFinder = find.byType(Consumer<ThemeRepository>);
    expect(consumerFinder, findsOneWidget);

    final materialAppFinder = find.byType(MaterialApp);
    expect(materialAppFinder, findsOneWidget);

    final scaffoldFinder = find.byType(Scaffold);
    expect(scaffoldFinder, findsOneWidget);

    final childFinder = find.text('TEST');
    expect(childFinder, findsOneWidget);
  });

  testWidgets('should render correctly in darkmode passing ThemeOption.dark',
      (tester) async {
    await tester.pumpWidget(makeTestableWidget(ThemeOption.dark));

    final consumerFinder = find.byType(Consumer<ThemeRepository>);
    expect(consumerFinder, findsOneWidget);

    final materialAppFinder = find.byType(MaterialApp);
    expect(materialAppFinder, findsOneWidget);

    final scaffoldFinder = find.byType(Scaffold);
    expect(scaffoldFinder, findsOneWidget);

    final childFinder = find.text('TEST');
    expect(childFinder, findsOneWidget);
  });

  testWidgets('should render correctly in darkmode passing ThemeOption.light',
      (tester) async {
    await tester.pumpWidget(makeTestableWidget(ThemeOption.light));

    final consumerFinder = find.byType(Consumer<ThemeRepository>);
    expect(consumerFinder, findsOneWidget);

    final materialAppFinder = find.byType(MaterialApp);
    expect(materialAppFinder, findsOneWidget);

    final scaffoldFinder = find.byType(Scaffold);
    expect(scaffoldFinder, findsOneWidget);

    final childFinder = find.text('TEST');
    expect(childFinder, findsOneWidget);
  });
}
