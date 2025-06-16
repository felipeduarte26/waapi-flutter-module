import 'clocking_event_routes.dart';
import 'configuration_routes.dart';
import 'drivers_journey_routes.dart';
import 'facial_recognition_routes.dart';
import 'hours_routes.dart';
import 'hub_routes.dart';
import 'notification_collector_routes.dart';
import 'time_adjustment_routes.dart';

abstract class PontoMobileCollectorRoutes {
  static const String module = 'collector';
  static const String appStartupHome = '/startup/home';
  static const String clockingEventHome =
      '$module${ClockingEventRoutes.homeFull}';
  static const String timeAdjustmentHome =
      '$module/${TimeAdjustmentRoutes.homeFull}';
  static const String configurationHome =
      '$module/${ConfigurationRoutes.homeFull}';
  static const String facialRecognitionHome =
      '$module/${FacialRecognitionRoutes.homeFull}';
  static const String hoursHome = '$module/${HoursRoutes.homeFull}';
  static const String hubHome = '$module/${HubRoutes.module}';
  static const String driversJourney =
      '$module${DriversJourneyRoutes.homeFull}';
  static const String notificationHome =
      '$module${NotificationCollectorRoutes.homeFull}';
}
