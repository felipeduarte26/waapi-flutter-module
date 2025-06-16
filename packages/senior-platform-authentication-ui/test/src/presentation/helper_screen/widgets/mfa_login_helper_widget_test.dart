import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_platform_authentication_ui/src/core/l10n/l10n_extension.dart';
import 'package:senior_platform_authentication_ui/src/core/widgets/base_authentication_screen.dart';
import 'package:senior_platform_authentication_ui/src/presentation/helper_screen/widgets/mfa_login_helper_widget.dart';

void main() {
  Widget makeTestableWidget() {
    return SeniorDesignSystem(
      child: BaseAuthenticationScreen(
        child: SeniorBackdrop(
          title: Builder(
            builder: (context) => Text(context.l10n.help),
          ),
          body: const MfaLoginHelperWidget(),
        ),
      ),
    );
  }

  testWidgets('should render correctly', (tester) async {
    await tester.pumpWidget(makeTestableWidget());

    final loadingFinder = find.byType(Text);

    expect(loadingFinder, findsAtLeastNWidgets(11));
  });
}
