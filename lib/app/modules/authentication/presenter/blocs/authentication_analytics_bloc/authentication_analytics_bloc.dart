import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import 'authentication_analytics_event.dart';
import 'authentication_analytics_state.dart';

class AuthenticationAnalyticsBloc extends Bloc<AuthenticationAnalyticsEvent, AuthenticationAnalyticsState> {
  final GetStoredUserUsecase _getStoredUserUsecase;
  late Locale userLocale;
  late String theme;

  AuthenticationAnalyticsBloc({
    required GetStoredUserUsecase getStoredUserUsecase,
  })  : _getStoredUserUsecase = getStoredUserUsecase,
        super(const AuthenticationUnknown()) {
    on<StatusChangedAuthenticationScreenEvent>(_authenticationStatusChanged);
    on<InitAuthenticationScreenEvent>(_initAuthenticationScreenEvent);
  }

  void _initAuthenticationScreenEvent(
    InitAuthenticationScreenEvent event,
    Emitter<AuthenticationAnalyticsState> _,
  ) {
    userLocale = event.userLocale;
    theme = event.theme;
  }

  Future<void> _authenticationStatusChanged(
    StatusChangedAuthenticationScreenEvent event,
    Emitter<AuthenticationAnalyticsState> emit,
  ) async {
    switch (event.authenticationStatus) {
      case AuthenticationStatus.unauthenticated:
        emit(const AuthenticationUnauthenticated());
        break;
      case AuthenticationStatus.authenticated:
        User? user = await _getStoredUserUsecase(const UserName());

        if (user != null) {
          emit(
            const AuthenticationAuthenticated(),
          );
        } else {
          emit(const AuthenticationUnauthenticated());
        }

        break;

      default:
        emit(const AuthenticationUnknown());
    }
  }
}
