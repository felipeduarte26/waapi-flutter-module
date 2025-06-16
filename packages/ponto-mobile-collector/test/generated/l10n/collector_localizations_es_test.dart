import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/generated/l10n/collector_localizations_es.dart';

void main() {
  test(
    'CollectorLocalizationsEs test.',
    () {
      CollectorLocalizationsEs localization = CollectorLocalizationsEs();
      expect(localization.appTitle, 'Marcação de Ponto Senior');
      expect(localization.helloWorld, '¡Hola Mundo!');
      expect(localization.dateFormatClock, 'd \'de\' MMMM \'de\' y');
      expect(localization.share, 'Compartir');
      expect(localization.close, 'Cerrar');
      expect(localization.appointmentReceipt, 'Comprobante de Marcación');
      expect(localization.cardReceiptData, 'Fecha');
      expect(localization.cardReceiptTime, 'Hora');
      expect(localization.cardReceiptZone, 'Zona');
      expect(localization.cardReceiptEmployeeName, 'Empleado');
      expect(localization.cardReceiptEmployeeCPF, 'CPF');
      expect(localization.cardReceiptCompanyName, 'Empresa');
      expect(localization.cardReceiptCompanyCNPJ, 'CNPJ');
      expect(
        localization.cardReceiptIdentification,
        'Identificador de marcación',
      );
      expect(localization.hoursWorked, 'Horas trabajadas hoy');
      expect(localization.breaks, 'Intervalos');
      expect(localization.lastClockingevent, 'Última marcación');
      expect(localization.lastClockingevents, 'Últimas marcaciones');
      expect(localization.breakTime, 'Intervalo de %t');
      expect(
        localization.whenRegistered,
        'Cuando se registren, aparecerán aquí',
      );
      expect(localization.todaysClockinEvents, 'Marcaciones de hoy');
      expect(
        localization.noClockingEvents,
        'No hay marcaciones registradas hoy.',
      );
      expect(localization.loading, 'Cargando...');
      expect(localization.deviceSituation, 'Novedad del dispositivo');
      expect(localization.goToLogin, 'Salir');
      expect(
        localization.deviceAuthorizationIsPending,
        'La función Punto no está activada para este dispositivo debido a una autorización pendiente de RH.',
      );
      expect(
        localization.deviceAuthorizationWasRejected,
        'La función Punto no está activada para este dispositivo debido a autorización rechazada por RH.',
      );
      expect(
        localization.deviceActivationIsPending,
        'La función Punto no está activada para este dispositivo debido a una activación pendiente por parte de RH.',
      );
      expect(
        localization.deviceActivationWasRejected,
        'La función Punto no está activada para este dispositivo debido a una activación rechazada por RH.',
      );
      expect(localization.clockingEvents, 'Marcaciones');
      expect(
        localization.rangeDate('fromDate', 'toDate'),
        'fromDate hasta toDate',
      );
      expect(localization.menuItemHome, 'Inicio');
      expect(localization.menuItemAppointment, 'Marcaciones');
      expect(localization.menuItemTime, 'Horas');
      expect(localization.menuItemProfile, 'Perfil');
      expect(localization.clockingEventTitle, 'Punto');
      expect(localization.clockingEventGoodMorning, 'Buenos días');
      expect(localization.clockingEventGoodAfternoon, 'Buenas tardes');
      expect(localization.clockingEventGoodEvening, 'Buenas noches');
      expect(localization.clockingEventCaptureTime, 'Registrar punto');
      expect(
        localization.clockingEventCapturingTime,
        'Realizando marcación',
      );
      expect(
        localization.clockingEventKeepButtonPressedToRegister,
        'Mantenga pulsado el botón para registrar',
      );
      expect(
        localization.clockingEventAppointmentMade,
        'Marcación hecha',
      );
      expect(localization.clockingEventSeeReceipt, 'Ver comprobante');
      expect(localization.withoutClockingEvents, 'Sin marcaciones');
      expect(localization.dateFormatter, 'dd/MM/yyyy');
      expect(localization.period, 'Período');
      expect(localization.oddClockingEvent, 'Marcaciones impares');
      expect(localization.periodClockingEvent, 'Marcaciones del período');
      expect(
        localization.lastUpdate('date1', 'date2'),
        'Última actualización date1 a la(s) date2',
      );
      expect(localization.clockInfoTitle1, 'Marcación no sincronizada');
      expect(
        localization.clockInfoDescription1,
        'Son marcaciones que fueron registradas y se sincronizarán tan pronto como haya una conexión a Internet.',
      );
      expect(localization.clockInfoTitle2, 'Origen vía móvil y plataforma');
      expect(
        localization.clockInfoDescription2,
        'Son marcaciones que fueron registradas vía aplicación y plataforma. Se clasifican como marcación cross.',
      );
      expect(localization.clockInfoTitle3, 'Origen vía móvil');
      expect(
        localization.clockInfoDescription3,
        'Son marcaciones que fueron registradas vía aplicación, tanto Punto como Waapi.',
      );
      expect(localization.clockInfoTitle4, 'Origen vía plataforma');
      expect(
        localization.clockInfoDescription4,
        'Son marcaciones que fueron registradas vía plataforma',
      );
      expect(localization.clockInfoTitle5, 'Marcación Manual');
      expect(
        localization.clockInfoDescription5,
        'Marcación registrada manualmente por el gestor o empleado a través del app o plataforma.',
      );
      expect(localization.clockInfoTitle6, 'Marcaciones impares');
      expect(
        localization.clockInfoDescription6,
        'Significa que falta una marcación para que su jornada laboral esté completa, pero puede haberse realizado en otro registrador de punto.',
      );
      expect(localization.clockInfoTitle7, 'Marcación con ausentismo');
      expect(
        localization.clockInfoDescription7,
        'Son marcaciones que tienen algún ausentismo registrado en la jornada laboral.',
      );
      expect(localization.infoUnderstoodButton, 'Entendí');
      expect(localization.registerCameraButton, 'Registrar');
      expect(localization.clockingsOfTheDay, 'Marcaciones del día');
      expect(localization.addClocking, 'Agregar marcación');
      expect(localization.timeControlManagement, 'Gestión del Punto');
      expect(
        localization.centralizingJourney,
        'Centralizando la jornada del empleado',
      );
      expect(
        localization.haveControl,
        'Tenga el control de su jornada del punto.',
      );
      expect(
        localization.shortcutsTimeControl,
        'Acceso directo al Gestión del Punto',
      );
      expect(
        localization.recentClockingEventMessage,
        'Usted ha marcado el punto hace menos de 2 minutos. ¿Desea realizar otra marcación?',
      );
      expect(
        localization.outsideTheFenceMessage,
        'La ubicación actual está fuera del perímetro definido por su empleador. ¿Desea continuar?',
      );
      expect(
        localization.alert,
        'Atención',
      );
      expect(
        localization.yes,
        'Sí',
      );
      expect(
        localization.no,
        'No',
      );
      expect(
        localization.confirmAppointment,
        'Confirmar marcación',
      );
      expect(
        localization.cancelAppointment,
        'No realizar marcación',
      );
      expect(
        localization.contactRh,
        'Por favor, contacte con el RRHH y/o diríjase a un dispositivo colectivo para registrar el punto.',
      );
      expect(
        localization.clockingEventSingleNotAvailable ,
        'La marcación del punto no está disponible para el modo individual para su usuario',
      );
      expect(
        localization.goToConfiguration ,
        'Permisos',
      );
      expect(localization.permissionCameraNotAllowedMessage,
      'Para utilizar el reconocimiento facial y la captura de fotos después de marcar, es necesario permitir el acceso a la cámara del dispositivo. Esta información no es obligatoria, pero complementa su registro.',
      );
      expect(localization.permissionLocationNotAllowedMessage,
      'Recomendamos añadir la dirección a su marcación de punto. Para eso, es necesario permitir acceso a la localización del dispositivo. Esta información no es obligatoria, pero complementa su registro.',
      );
    },
  );
}
