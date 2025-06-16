import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/widgets.dart';

import '../../../enums/analytics/analytics_event_enum.dart';
import '../../../enums/analytics/analytics_user_property_enum.dart';
import '../../../helper/enum_helper.dart';
import '../../error_logging/error_logging_service.dart';
import '../analytics_service.dart';

class FirebaseAnalyticsService implements AnalyticsService<FirebaseAnalytics> {
  final FirebaseAnalytics _instance;
  final ErrorLoggingService _errorLoggingService;

  const FirebaseAnalyticsService({
    required FirebaseAnalytics instance,
    required ErrorLoggingService errorLoggingService,
  })  : _instance = instance,
        _errorLoggingService = errorLoggingService;

  @override
  FirebaseAnalytics get instance {
    return _instance;
  }

  @override
  NavigatorObserver get navigatorObserver {
    return FirebaseAnalyticsObserver(
      analytics: _instance,
    );
  }

  @override
  Future<void> logEvent({
    required AnalyticsEventEnum analyticsEventEnum,
    Map<String, Object?>? parameters,
  }) async {
    try {
      await _instance.logEvent(
        name: EnumHelper()
            .enumToString(
              enumToParse: analyticsEventEnum,
            )
            .toLowerCase(),
        parameters: parameters?.cast<String,Object>(),
      );
    } catch (error, stackTrace) {
      _errorLoggingService.recordError(
        exception: error,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<void> setUserId({
    required String id,
  }) async {
    try {
      await _instance.setUserId(
        id: id,
      );
    } catch (error, stackTrace) {
      _errorLoggingService.recordError(
        exception: error,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<void> setUserProperty({
    required AnalyticsUserPropertyEnum analyticsUserPropertyEnum,
    required String value,
  }) async {
    try {
      await _instance.setUserProperty(
        name: EnumHelper()
            .enumToString(
              enumToParse: analyticsUserPropertyEnum,
            )
            .toLowerCase(),
        value: value,
      );
    } catch (error, stackTrace) {
      _errorLoggingService.recordError(
        exception: error,
        stackTrace: stackTrace,
      );
    }
  }
}
