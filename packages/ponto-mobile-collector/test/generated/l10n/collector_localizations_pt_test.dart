import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/generated/l10n/collector_localizations_pt.dart';

void main() {
  test(
    'CollectorLocalizationsPt test.',
    () {
      CollectorLocalizationsPt localization = CollectorLocalizationsPt();
      expect(localization.appTitle, 'Marcação de Ponto Senior');
      expect(localization.helloWorld, 'Olá Mundo!');
      expect(localization.dateFormatClock, 'd \'de\' MMMM \'de\' y');
      expect(localization.share, 'Compartilhar');
      expect(localization.close, 'Fechar');
      expect(localization.appointmentReceipt, 'Comprovante de marcação');
      expect(localization.cardReceiptData, 'Data');
      expect(localization.cardReceiptTime, 'Horário');
      expect(localization.cardReceiptZone, 'Fuso');
      expect(localization.cardReceiptEmployeeName, 'Colaborador');
      expect(localization.cardReceiptEmployeeCPF, 'CPF');
      expect(localization.cardReceiptCompanyName, 'Empresa');
      expect(localization.cardReceiptCompanyCNPJ, 'CNPJ');
      expect(
        localization.cardReceiptIdentification,
        'Identificação da Marcação',
      );
      expect(localization.hoursWorked, 'Horas trabalhadas hoje');
      expect(localization.breaks, 'Intervalos');
      expect(localization.lastClockingevent, 'Última marcação');
      expect(localization.lastClockingevents, 'Últimas marcações');
      expect(localization.breakTime, 'Intervalo de %t');
      expect(
        localization.whenRegistered,
        'Quando registrar, elas aparecerão aqui',
      );
      expect(localization.todaysClockinEvents, 'Marcações de hoje');
      expect(
        localization.noClockingEvents,
        'Não há marcações registradas hoje',
      );
      expect(localization.loading, 'Carregando...');
      expect(localization.deviceSituation, 'Situação do dispositivo');
      expect(localization.goToLogin, 'Sair');
      expect(
        localization.deviceAuthorizationIsPending,
        'A função de Ponto não está ativada para este dispositivo devido à autorização pendente do RH.',
      );
      expect(
        localization.deviceAuthorizationWasRejected,
        'A função de Ponto não está ativada para este dispositivo devido à autorização rejeitada pelo RH.',
      );
      expect(
        localization.deviceActivationIsPending,
        'A função de Ponto não está ativada para este dispositivo devido à ativação pendente do RH.',
      );
      expect(
        localization.deviceActivationWasRejected,
        'A função de Ponto não está ativada para este dispositivo devido à ativação rejeitada pelo RH.',
      );
      expect(localization.clockingEvents, 'Marcações');
      expect(
        localization.rangeDate('fromDate', 'toDate'),
        'fromDate até toDate',
      );
      expect(localization.menuItemHome, 'Início');
      expect(localization.menuItemAppointment, 'Marcações');
      expect(localization.menuItemTime, 'Horas');
      expect(localization.menuItemProfile, 'Perfil');
      expect(localization.clockingEventTitle, 'Ponto');
      expect(localization.clockingEventGoodMorning, 'Bom dia');
      expect(localization.clockingEventGoodAfternoon, 'Boa tarde');
      expect(localization.clockingEventGoodEvening, 'Boa noite');
      expect(localization.clockingEventCaptureTime, 'Registrar ponto');
      expect(
        localization.clockingEventCapturingTime,
        'Realizando marcação',
      );
      expect(
        localization.clockingEventKeepButtonPressedToRegister,
        'Mantenha o botão pressionado para registrar',
      );
      expect(
        localization.clockingEventAppointmentMade,
        'Marcação Realizada',
      );
      expect(localization.clockingEventSeeReceipt, 'Ver comprovante');
      expect(localization.withoutClockingEvents, 'Sem marcações');
      expect(localization.dateFormatter, 'dd/MM/yyyy');
      expect(localization.period, 'Período');
      expect(localization.oddClockingEvent, 'Marcações ímpares');
      expect(localization.periodClockingEvent, 'Marcações do período');
      expect(
        localization.lastUpdate('date1', 'date2'),
        'Última atualização date1 às date2',
      );
      expect(localization.clockInfoTitle1, 'Marcação não sincronizada');
      expect(
        localization.clockInfoDescription1,
        'São marcações que foram registradas e serão sincronizadas assim que houver conexão com a internet.',
      );
      expect(localization.clockInfoTitle2, 'Origem via celular e plataforma');
      expect(
        localization.clockInfoDescription2,
        'São marcações que foram registradas via aplicativo e plataforma. São categorizadas como marcação cross.',
      );
      expect(localization.clockInfoTitle3, 'Origem via celular');
      expect(
        localization.clockInfoDescription3,
        'São marcações que foram registradas via aplicativo tanto Ponto quanto Waapi.',
      );
      expect(localization.clockInfoTitle4, 'Origem via plataforma');
      expect(
        localization.clockInfoDescription4,
        'São marcações que foram registradas via plataforma.',
      );
      expect(localization.clockInfoTitle5, 'Marcação manual');
      expect(
        localization.clockInfoDescription5,
        'Marcações registradas manualmente pelo gestor ou colaborador através do app ou plataforma.',
      );
      expect(localization.clockInfoTitle6, 'Marcações ímpares');
      expect(
        localization.clockInfoDescription6,
        'Significa que falta uma marcação para sua jornada ficar completa, porém ela pode ter sido realizada em outro registrador de ponto.',
      );
      expect(localization.clockInfoTitle7, 'Marcações com afastamento');
      expect(
        localization.clockInfoDescription7,
        'São marcações que possuem algum afastamento lançado na jornada.',
      );
      expect(localization.infoUnderstoodButton, 'Entendi');
      expect(localization.registerCameraButton, 'Registrar');
      expect(localization.clockingsOfTheDay, 'Marcações do dia');
      expect(localization.addClocking, 'Adicionar marcação');

      expect(localization.timeControlManagement, 'Gestão do Ponto');
      expect(
        localization.centralizingJourney,
        'Centralizando a jornada do colaborador',
      );
      expect(
        localization.haveControl,
        'Tenha o controle da sua jornada do ponto.',
      );
      expect(
        localization.shortcutsTimeControl,
        'Atalhos para o Gestão do Ponto',
      );
      expect(
        localization.recentClockingEventMessage,
        'Você marcou o ponto há menos de 2 minutos. Deseja realizar outra marcação?',
      );
      expect(
        localization.outsideTheFenceMessage,
        'A localização atual está fora do perímetro definido pelo seu empregador. Deseja continuar?',
      );
      expect(
        localization.alert,
        'Atenção',
      );
      expect(
        localization.yes,
        'Sim',
      );
      expect(
        localization.no,
        'Não',
      );
      expect(
        localization.confirmAppointment,
        'Confirmar marcação',
      );
      expect(
        localization.cancelAppointment,
        'Não realizar marcação',
      );
      expect(
        localization.contactRh,
        'Por favor, contate o RH ou se dirija a um dispositivo coletivo para registrar o ponto.',
      );
      expect(
        localization.clockingEventSingleNotAvailable ,
        'A Marcação de ponto não está disponível para o modo individual para o seu usuário',
      );
      expect(
        localization.goToConfiguration ,
        'Permissões',
      );
      expect(localization.permissionCameraNotAllowedMessage,
      'Para utilizar o reconhecimento facial e captura de foto após marcação, é necessário permitir acesso à câmera do dispositivo. Essa informação não é obrigatória, mas complementa seu registro.',
      );
      expect(localization.permissionLocationNotAllowedMessage,
      'Recomendamos adicionar o local à sua marcação de ponto, para isso é necessário permitir acesso à localização do dispositivo. Essa informação não é obrigatória, mas complementa seu registro.',
      );
    },
  );
}
