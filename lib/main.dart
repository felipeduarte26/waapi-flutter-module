import 'dart:async';


import 'package:flutter/material.dart';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';
import 'app/core/environment/environment_variables.dart';
import 'app/core/services/pre_loading/pre_loading_service.dart';

Future<void> main() async {
  runZonedGuarded(
    () async {

      WidgetsFlutterBinding.ensureInitialized();

      final PreLoadingService preLoadingService = PreLoadingService();
      await preLoadingService.preLoad();

      SeniorAuthentication.initialize(
        enableLoginOffline: true,
        restUrl: EnvironmentVariables.platformUrlBase,
        platformEnvironment: EnvironmentVariables.platformEnvironmentWaapi,
        enableBiometry: false,
        encryptionKey: EnvironmentVariables.encryptionKey,
      );

      runApp(
        ModularApp(
          module: AppModule(),
          child: SeniorDesignSystem(
            theme: SENIOR_LIGHT_THEME,
            child: const AppWidget(),
          ),
        ),
      );
    },
    (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack),
  );
}
