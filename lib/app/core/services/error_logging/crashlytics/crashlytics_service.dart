import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

import '../../../enums/analytics/analytics_user_property_enum.dart';
import '../../../helper/enum_helper.dart';
import '../error_logging_service.dart';

class CrashlyticsService implements ErrorLoggingService<FirebaseCrashlytics> {
  final FirebaseCrashlytics _instance;

  const CrashlyticsService({
    required FirebaseCrashlytics instance,
  }) : _instance = instance;

  bool get _isEnabled {
    return _instance.isCrashlyticsCollectionEnabled;
  }

  @override
  FirebaseCrashlytics get instance {
    return _instance;
  }

  @override
  Future<void> registerCrashLogging() async {
    FlutterError.onError = _instance.recordFlutterError;
    await _instance.setCrashlyticsCollectionEnabled(true);
  }

  @override
  void appendLogMessage({
    required String message,
  }) {
    if (_isEnabled) {
      _instance.log(message);
    }
  }

  @override
  void recordError({
    dynamic exception,
    StackTrace? stackTrace,
  }) {
    if (_isEnabled) {
      _instance.recordError(exception, stackTrace);
    }
  }

  @override
  void setCustomKey({
    required AnalyticsUserPropertyEnum key,
    required Object value,
  }) {
    if (_isEnabled) {
      _instance.setCustomKey(
        EnumHelper()
            .enumToString(
              enumToParse: key,
            )
            .toLowerCase(),
        value,
      );
    }
  }

  @override
  void setUserIdentifier({
    required String identifier,
  }) {
    if (_isEnabled) {
      _instance.setUserIdentifier(identifier);
    }
  }
}
