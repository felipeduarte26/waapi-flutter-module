import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';
import 'package:senior_platform_authentication_ui/src/core/l10n/l10n_extension.dart';
import 'package:senior_platform_authentication_ui/src/presentation/helper_screen/key_helper_screen.dart';

void main() {
  Widget makeTestableWidget() {
    return SeniorDesignSystem(
      child: BaseAuthenticationScreen(
        child: SeniorBackdrop(
            title: Builder(
              builder: (context) => Text(
                context.l10n.help,
              ),
            ),
            body: const KeyHelperScreen()),
      ),
    );
  }

  group('KeyHelperScreen', () {
    testWidgets('should render correctly', (tester) async {
      await tester.pumpWidget(makeTestableWidget());

      expect(
          find.text(
              'The information must be obtained from your company\'s system administrator, contact HR for more information.'),
          findsOneWidget);
    });
  });
}
