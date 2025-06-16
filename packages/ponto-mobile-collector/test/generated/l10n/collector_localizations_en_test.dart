import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/generated/l10n/collector_localizations_en.dart';

void main() {
  test(
    'CollectorLocalizationsEn test.',
    () {
      CollectorLocalizationsEn localization = CollectorLocalizationsEn();
      expect(localization.appTitle, 'Marcação de Ponto Senior');
      expect(localization.helloWorld, 'Hello World!');
      expect(localization.dateFormatClock, 'MMM d, yyyy');
      expect(localization.share, 'Share');
      expect(localization.close, 'Close');
      expect(localization.appointmentReceipt, 'Clocking event receipt');
      expect(localization.cardReceiptData, 'Date');
      expect(localization.cardReceiptTime, 'Time');
      expect(localization.cardReceiptZone, 'Time Zone');
      expect(localization.cardReceiptEmployeeName, 'Employee');
      expect(localization.cardReceiptEmployeeCPF, 'CPF');
      expect(localization.cardReceiptCompanyName, 'Company');
      expect(localization.cardReceiptCompanyCNPJ, 'CNPJ');
      expect(
        localization.cardReceiptIdentification,
        'Clocking event identifier',
      );
      expect(localization.hoursWorked, 'Hours worked today');
      expect(localization.breaks, 'Breaks');
      expect(localization.lastClockingevent, 'Last clocking event');
      expect(localization.lastClockingevents, 'Last clocking events');
      expect(localization.breakTime, '%t break');
      expect(
        localization.whenRegistered,
        'When registered, they will appear here',
      );
      expect(localization.todaysClockinEvents, 'Today\'s clocking events');
      expect(
        localization.noClockingEvents,
        'No clocking events registered today.',
      );
      expect(localization.loading, 'Loading...');
      expect(localization.deviceSituation, 'Device situation');
      expect(localization.goToLogin, 'Exit');
      expect(
        localization.deviceAuthorizationIsPending,
        'The Time Control function is not activated for this device due to pending HR authorization.',
      );
      expect(
        localization.deviceAuthorizationWasRejected,
        'The Time Control function is not activated for this device due to authorization rejected by HR.',
      );
      expect(
        localization.deviceActivationIsPending,
        'The Time Control function is not activated for this device due to pending HR authorization.',
      );
      expect(
        localization.deviceActivationWasRejected,
        'The Time Control function is not activated for this device due to authorization rejected by HR.',
      );
      expect(localization.clockingEvents, 'Clocking events');
      expect(
        localization.rangeDate('fromDate', 'toDate'),
        'fromDate to toDate',
      );
      expect(localization.menuItemHome, 'Home');
      expect(localization.menuItemAppointment, 'Clocking events');
      expect(localization.menuItemTime, 'Hours');
      expect(localization.menuItemProfile, 'Profile');
      expect(localization.clockingEventTitle, 'Clocking Event');
      expect(localization.clockingEventGoodMorning, 'Good morning');
      expect(localization.clockingEventGoodAfternoon, 'Good afternoon');
      expect(localization.clockingEventGoodEvening, 'Good evening');
      expect(localization.clockingEventCaptureTime, 'Register clocking event');
      expect(
        localization.clockingEventCapturingTime,
        'Clocking event in progress',
      );
      expect(
        localization.clockingEventKeepButtonPressedToRegister,
        'Keep the button pressed to register',
      );
      expect(
        localization.clockingEventAppointmentMade,
        'Clocking event successful',
      );
      expect(localization.clockingEventSeeReceipt, 'View statement');
      expect(localization.withoutClockingEvents, 'No clocking events');
      expect(localization.dateFormatter, 'MM/dd/yyyy');
      expect(localization.period, 'Period');
      expect(localization.oddClockingEvent, 'Odd clocking events');
      expect(localization.periodClockingEvent, 'Clocking events of the period');
      expect(
        localization.lastUpdate('date1', 'date2'),
        'Last updated on date1 at date2',
      );
      expect(localization.clockInfoTitle1, 'Unsynchronized clocking event');
      expect(
        localization.clockInfoDescription1,
        'These are clocking events that were registered and will be synchronized as soon as an internet connection is available.',
      );
      expect(localization.clockInfoTitle2, 'Platform and cell phone origin');
      expect(
        localization.clockInfoDescription2,
        'These are clocking events registered via application and the platform. They are categorized as cross events.',
      );
      expect(localization.clockInfoTitle3, 'Cell phone origin');
      expect(
        localization.clockInfoDescription3,
        'These are clocking events registered via application, be it the Clocking Event app or Waapi.',
      );
      expect(localization.clockInfoTitle4, 'Platform origin');
      expect(
        localization.clockInfoDescription4,
        'These are clocking events registered via the platform.',
      );
      expect(localization.clockInfoTitle5, 'Manual clocking event');
      expect(
        localization.clockInfoDescription5,
        'A clocking event registered manually by the manager or employee through the app or platform.',
      );
      expect(localization.clockInfoTitle6, 'Odd clocking events');
      expect(
        localization.clockInfoDescription6,
        'It means there is one clocking event missing to complete your workday, but it may have been taken at another clocking event controller.',
      );
      expect(localization.clockInfoTitle7, 'Leave clocking events');
      expect(
        localization.clockInfoDescription7,
        'These are clocking events that have a leave registered in the workday.',
      );
      expect(localization.infoUnderstoodButton, 'Understood');
      expect(localization.registerCameraButton, 'Register');
      expect(localization.clockingsOfTheDay, 'Clocking events of the day');
      expect(localization.addClocking, 'Add clocking event');
      expect(localization.timeControlManagement, 'Time Control Management');
      expect(
        localization.centralizingJourney,
        'Centralizing the employee\'s journey',
      );
      expect(
        localization.haveControl,
        'Have control of your time control journey',
      );
      expect(
        localization.shortcutsTimeControl,
        'Shortcuts for Time Control Management',
      );
            expect(
        localization.recentClockingEventMessage,
        'You clocked in/out less than 2 minutes ago. Do you want to clock in/out again?',
      );
      expect(
        localization.outsideTheFenceMessage,
        'The current location is outside the perimeter defined by your employer. Do you wish to continue?',
      );
      expect(
        localization.alert,
        'Warning',
      );
      expect(
        localization.yes,
        'Yes',
      );
      expect(
        localization.no,
        'No',
      );
      expect(
        localization.confirmAppointment,
        'Confirm clocking event',
      );
      expect(
        localization.cancelAppointment,
        'Do not clock in/out',
      );
      expect(
        localization.contactRh,
        'Please contact HR or go to a collective device to clock in.',
      );
      expect(
        localization.clockingEventSingleNotAvailable,
        'Clocking event is not available in individual mode for your user',
      );
      expect(
        localization.goToConfiguration,
        'Permissions',
      );
      expect(localization.permissionCameraNotAllowedMessage,
      'To use facial recognition and photo capture after clocking in, you must allow access to the device\'s camera. This information is not mandatory, but complements your entry.',
      );
      expect(localization.permissionLocationNotAllowedMessage,
      'We recommend adding the location to your clocking event and, to do so, you need to allow access to your device\'s location. This information is not mandatory, but it complements your entry.',
      );
    },
  );
}
