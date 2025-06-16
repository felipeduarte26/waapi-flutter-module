import 'package:flutter/widgets.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

abstract class AuthenticationAnalyticsEvent {
  const AuthenticationAnalyticsEvent();
}

class InitAuthenticationScreenEvent extends AuthenticationAnalyticsEvent {
  final Locale userLocale;
  final String theme;

  const InitAuthenticationScreenEvent({
    required this.userLocale,
    required this.theme,
  });
}

class StatusChangedAuthenticationScreenEvent extends AuthenticationAnalyticsEvent {
  final AuthenticationStatus authenticationStatus;

  const StatusChangedAuthenticationScreenEvent({
    required this.authenticationStatus,
  });
}
