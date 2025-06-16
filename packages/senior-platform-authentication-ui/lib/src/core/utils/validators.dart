import 'package:flutter/material.dart';

import '../l10n/l10n_extension.dart';
import 'constants.dart';

String? validateUserName(BuildContext context, String? text) {
  if (text == null || text.isEmpty) {
    return context.l10n.usernameRequiredMessage;
  }

  if (!emailRegex.hasMatch(text)) {
    return context.l10n.usernameInvalidMessage;
  }

  return null;
}

String? validatePassword(BuildContext context, String? text) {
  if (text == null || text.isEmpty) {
    return context.l10n.passwordRequiredMessage;
  }

  return null;
}

String? validateDomain(
  BuildContext context,
  String? text,
  String? loginWithKeyWrongDomain,
) {
  if (text == null || text.isEmpty) {
    return loginWithKeyWrongDomain ?? context.l10n.loginWithKeyWrongDomain;
  }

  return null;
}

String? validateAccessKey(
  BuildContext context,
  String? text,
  String? loginWithKeyWrongKey,
) {
  if (text == null || text.isEmpty) {
    return loginWithKeyWrongKey ?? context.l10n.loginWithKeyWrongKey;
  }

  return null;
}

String? validateSecret(
  BuildContext context,
  String? text,
  String? loginWithKeyWrongSecret,
) {
  if (text == null || text.isEmpty) {
    return loginWithKeyWrongSecret ?? context.l10n.loginWithKeyWrongSecret;
  }

  return null;
}
