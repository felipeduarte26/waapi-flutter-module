import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_platform_authentication_ui/src/core/l10n/l10n_extension.dart';
import 'package:senior_platform_authentication_ui/src/core/widgets/base_authentication_screen.dart';
import 'package:senior_platform_authentication_ui/src/presentation/helper_screen/widgets/image_helper_widget.dart';

void main() {
  Widget makeTestableWidgetWhithelpurlLink() {
    return SeniorDesignSystem(
      child: BaseAuthenticationScreen(
        child: SeniorBackdrop(
          title: Builder(
            builder: (context) => Text(
              context.l10n.help,
            ),
          ),
          body: const ImageHelperWidget(
              urlLink: 'https://cdn-icons-png.flaticon.com/512/682/682055.png'),
        ),
      ),
    );
  }

  Widget makeTestableWidgetWhithelpassetLink() {
    return SeniorDesignSystem(
      child: BaseAuthenticationScreen(
        child: SeniorBackdrop(
          title: Builder(
            builder: (context) => Text(
              context.l10n.help,
            ),
          ),
          body: const ImageHelperWidget(
            assetLink: 'images/help.png',
          ),
        ),
      ),
    );
  }

  testWidgets(
    'image helper urlLink ...',
    (tester) async {
      await tester.pumpWidget(makeTestableWidgetWhithelpassetLink());

      await tester.pumpAndSettle();

      final image = find.byType(Image);

      expect(image, findsOneWidget);
    },
  );
}
