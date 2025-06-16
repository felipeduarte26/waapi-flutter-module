import 'dart:isolate';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../../environment/environment_variables.dart';
import '../../environment/firebase_senior_environments.dart';
import '../error_logging/crashlytics/crashlytics_service.dart';
import '../error_logging/error_logging_service.dart';

class PreLoadingService {
  late ErrorLoggingService<FirebaseCrashlytics> errorService;

  Future preLoad() async {
    debugPrint('PreLoadingService: preLoad ${Firebase.apps.isEmpty}');
    if (Firebase.apps.isEmpty) {
      var firebaseOptions = FirebaseSeniorEnvironments.development;

      if (EnvironmentVariables.firebaseEnvironment == 'production') {
        firebaseOptions = FirebaseSeniorEnvironments.production;
      }

      await Firebase.initializeApp(
        options: firebaseOptions,
      );
    }

    errorService = CrashlyticsService(
      instance: FirebaseCrashlytics.instance,
    );

    await errorService.registerCrashLogging();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    Isolate.current.addErrorListener(
      RawReceivePort(
        (pair) async {
          final List<dynamic> errorAndStacktrace = pair;
          await FirebaseCrashlytics.instance.recordError(
            errorAndStacktrace.first,
            errorAndStacktrace.last,
          );
        },
      ).sendPort,
    );
  }
}
