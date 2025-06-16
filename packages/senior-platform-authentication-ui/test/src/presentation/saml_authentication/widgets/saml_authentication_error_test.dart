import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_platform_authentication_ui/src/core/l10n/l10n_extension.dart';
import 'package:senior_platform_authentication_ui/src/core/widgets/base_authentication_screen.dart';
import 'package:senior_platform_authentication_ui/src/presentation/saml_authentication/widgets/saml_authentication_error.dart';

void main() {
  Widget makeTestableWidget() {
    return SeniorDesignSystem(
      child: BaseAuthenticationScreen(
        child: SeniorBackdrop(
          title: Builder(
              builder: (context) => Text(context.l10n.userNameScreenTitle)),
          body: const SAMLAuthenticationError(),
        ),
      ),
    );
  }

  testWidgets('should render correctly', (tester) async {
    await tester.pumpWidget(makeTestableWidget());

    final textsFinder = find.byType(Text);
    final iconFinder = find.byWidgetPredicate((widget) =>
        widget is Icon && widget.icon == FontAwesomeIcons.exclamation);

    expect(textsFinder, findsAtLeastNWidgets(3));
    expect(iconFinder, findsOneWidget);
  });
}
