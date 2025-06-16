import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:senior_platform_authentication_ui/src/core/l10n/gen/app_localizations.dart';
import 'package:senior_platform_authentication_ui/src/core/l10n/l10n_extension.dart';
import 'package:senior_platform_authentication_ui/src/core/utils/validators.dart';

void main() {
  group('validateUserName', () {
    testWidgets('invalid UserName message', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Builder(
            builder: (BuildContext context) {
              final errorMessage = validateUserName(context, 'invalid_email');
              expect(errorMessage, context.l10n.usernameInvalidMessage);
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets('required UserName message', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Builder(
            builder: (BuildContext context) {
              final errorMessage = validateUserName(context, '');
              expect(errorMessage, context.l10n.usernameRequiredMessage);
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets('valid UserName message', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Builder(
            builder: (BuildContext context) {
              final errorMessage =
                  validateUserName(context, 'valid_email@senior.com.br');
              expect(errorMessage, null);
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });
  });

  group('validatePassword', () {
    testWidgets('required Password message', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Builder(
            builder: (BuildContext context) {
              final errorMessage = validatePassword(context, '');
              expect(errorMessage, context.l10n.passwordRequiredMessage);
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets('valid Password message', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Builder(
            builder: (BuildContext context) {
              final errorMessage = validatePassword(context, 'Tteste1!');
              expect(errorMessage, null);
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });
  });

  group('validateDomain', () {
    testWidgets('required Domain message', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Builder(
            builder: (BuildContext context) {
              final errorMessage = validateDomain(context, '', null);
              expect(errorMessage, context.l10n.loginWithKeyWrongDomain);
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets('valid Domain message', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Builder(
            builder: (BuildContext context) {
              final errorMessage = validateDomain(context, 'Tteste1!', null);
              expect(errorMessage, null);
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });
  });

  group('validateAccessKey', () {
    testWidgets('required AccessKey message', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Builder(
            builder: (BuildContext context) {
              final errorMessage = validateAccessKey(context, '', null);
              expect(errorMessage, context.l10n.loginWithKeyWrongKey);
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets('valid AccessKey message', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Builder(
            builder: (BuildContext context) {
              final errorMessage = validateAccessKey(context, 'Tteste1!', null);
              expect(errorMessage, null);
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });
  });

  group('validateSecret', () {
    testWidgets('required Secret message', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Builder(
            builder: (BuildContext context) {
              final errorMessage = validateSecret(context, '', null);
              expect(errorMessage, context.l10n.loginWithKeyWrongSecret);
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets('valid Secret message', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Builder(
            builder: (BuildContext context) {
              final errorMessage = validateSecret(context, 'Tteste1!', null);
              expect(errorMessage, null);
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });
  });
}
