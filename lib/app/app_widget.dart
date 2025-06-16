import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart' as flutter_localizations;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ponto_mobile_collector/generated/l10n/collector_localizations.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart' as senior_ui;
import 'core/environment/environment_variables.dart';
import 'core/services/integration_user/infra/repositories/integration_user_repository_impl.dart';
import 'routes/routes.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({
    super.key,
  });

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> with WidgetsBindingObserver {
  bool isHidden = false;
  DateTime? backgroundTime;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (isHidden && state == AppLifecycleState.resumed && senior_ui.SeniorAuthentication.enableBiometry) {
      final authenticationBloc = Modular.get<senior_ui.AuthenticationBloc>();
      if (authenticationBloc.state.status == senior_ui.AuthenticationStatus.authenticated) {
        if (backgroundTime != null) {
          final currentTime = DateTime.now();
          final elapsedDuration = currentTime.difference(backgroundTime!);
          if (elapsedDuration.inMinutes > 5) {
            authenticationBloc.add(
              senior_ui.CheckBiometricAuthenticationRequested(
                username: authenticationBloc.state.username,
              ),
            );
          }
        }
      }
      isHidden = false;
    }

    if (!isHidden) {
      isHidden = state == AppLifecycleState.hidden;
      if (isHidden) {
        backgroundTime = DateTime.now();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute(OnboardingRoutes.splashScreenInitialRoute);


    return BlocProvider(
      create: (_) => senior_ui.AuthenticationBloc()
        ..add(
          const senior_ui.CheckAuthenticationRequested(checkOnline: false),
        ),
      child: MaterialApp.router(
        builder: (context, child) {
          return BlocListener<senior_ui.AuthenticationBloc, senior_ui.AuthenticationState>(
            child: child,
            listener: (context, state) {
              Modular.get<IntegrationUserRepositoryImpl>().saveIntegrationUser(state.integrationUser);
              switch (state.status) {
                case senior_ui.AuthenticationStatus.authenticated:
                  log(
                    'User authenticated! \n',
                  );
                  break;
                case senior_ui.AuthenticationStatus.unauthenticated:
                  log(
                    'User unauthenticated! \n',
                  );
                  break;
                default:
                  break;
              }
            },
          );
        },
        theme: SENIOR_LIGHT_THEME.themeData,
        darkTheme: SENIOR_LIGHT_THEME.themeData,
        routeInformationParser: Modular.routeInformationParser,
        routerDelegate: Modular.routerDelegate,
        debugShowCheckedModeBanner: EnvironmentVariables.showDebugBanner,
        localizationsDelegates: const [
          CollectorLocalizations.delegate,
          ...flutter_localizations.AppLocalizations.localizationsDelegates,
        ],
        supportedLocales: flutter_localizations.AppLocalizations.supportedLocales,
        onGenerateTitle: (context) => flutter_localizations.AppLocalizations.of(context)?.appTitle ?? 'Waapi',
      ),
    );
  }
}
