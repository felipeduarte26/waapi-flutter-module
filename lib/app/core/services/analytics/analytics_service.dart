import 'package:flutter/widgets.dart';

import '../../enums/analytics/analytics_event_enum.dart';
import '../../enums/analytics/analytics_user_property_enum.dart';

/// This interface describes all the methods needed to generate app analytics logs
///
abstract class AnalyticsService<T> {
  /// Returns the analysis tool instance
  T get instance;

  /// Returns a NavigatorObserver to be listened to for screen changes
  NavigatorObserver get navigatorObserver;

  Future<void> setUserId({
    required String id,
  });

  /// Configures a user property to attach to the user.
  Future<void> setUserProperty({
    required AnalyticsUserPropertyEnum analyticsUserPropertyEnum,
    required String value,
  });

  /// Create a custom event
  Future<void> logEvent({
    required AnalyticsEventEnum analyticsEventEnum,
    Map<String, Object?>? parameters,
  });
}
