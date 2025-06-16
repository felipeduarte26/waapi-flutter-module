import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'collector_localizations_en.dart';
import 'collector_localizations_es.dart';
import 'collector_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of CollectorLocalizations
/// returned by `CollectorLocalizations.of(context)`.
///
/// Applications need to include `CollectorLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/collector_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: CollectorLocalizations.localizationsDelegates,
///   supportedLocales: CollectorLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the CollectorLocalizations.supportedLocales
/// property.
abstract class CollectorLocalizations {
  CollectorLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static CollectorLocalizations of(BuildContext context) {
    return Localizations.of<CollectorLocalizations>(context, CollectorLocalizations)!;
  }

  static const LocalizationsDelegate<CollectorLocalizations> delegate = _CollectorLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('pt')
  ];

  /// Titulo da aplicação
  ///
  /// In pt, this message translates to:
  /// **'Marcação de Ponto Senior'**
  String get appTitle;

  /// Mensagem de boas vindas
  ///
  /// In pt, this message translates to:
  /// **'Olá Mundo!'**
  String get helloWorld;

  /// Formato de data no relógio
  ///
  /// In pt, this message translates to:
  /// **'d \'de\' MMMM \'de\' y'**
  String get dateFormatClock;

  /// Compartilhar
  ///
  /// In pt, this message translates to:
  /// **'Compartilhar'**
  String get share;

  /// Fechar
  ///
  /// In pt, this message translates to:
  /// **'Fechar'**
  String get close;

  /// Comprovante de marcação
  ///
  /// In pt, this message translates to:
  /// **'Comprovante de marcação'**
  String get appointmentReceipt;

  /// Data da marcação
  ///
  /// In pt, this message translates to:
  /// **'Data'**
  String get cardReceiptData;

  /// Horario da marcação
  ///
  /// In pt, this message translates to:
  /// **'Horário'**
  String get cardReceiptTime;

  /// Fuso horário da marcação
  ///
  /// In pt, this message translates to:
  /// **'Fuso'**
  String get cardReceiptZone;

  /// Nome do colaborador da marcação
  ///
  /// In pt, this message translates to:
  /// **'Colaborador'**
  String get cardReceiptEmployeeName;

  /// CPF do colaborador da marcação
  ///
  /// In pt, this message translates to:
  /// **'CPF'**
  String get cardReceiptEmployeeCPF;

  /// Nome da empresa da marcação
  ///
  /// In pt, this message translates to:
  /// **'Empresa'**
  String get cardReceiptCompanyName;

  /// CNPJ da empresa da marcação
  ///
  /// In pt, this message translates to:
  /// **'CNPJ'**
  String get cardReceiptCompanyCNPJ;

  /// Código de identificação da marcação
  ///
  /// In pt, this message translates to:
  /// **'Identificação da Marcação'**
  String get cardReceiptIdentification;

  /// No description provided for @hoursWorked.
  ///
  /// In pt, this message translates to:
  /// **'Horas trabalhadas hoje'**
  String get hoursWorked;

  /// No description provided for @breaks.
  ///
  /// In pt, this message translates to:
  /// **'Intervalos'**
  String get breaks;

  /// No description provided for @lastClockingevent.
  ///
  /// In pt, this message translates to:
  /// **'Última marcação'**
  String get lastClockingevent;

  /// No description provided for @lastClockingevents.
  ///
  /// In pt, this message translates to:
  /// **'Últimas marcações'**
  String get lastClockingevents;

  /// No description provided for @breakTime.
  ///
  /// In pt, this message translates to:
  /// **'Intervalo de %t'**
  String get breakTime;

  /// No description provided for @whenRegistered.
  ///
  /// In pt, this message translates to:
  /// **'Quando registrar, elas aparecerão aqui'**
  String get whenRegistered;

  /// No description provided for @todaysClockinEvents.
  ///
  /// In pt, this message translates to:
  /// **'Marcações de hoje'**
  String get todaysClockinEvents;

  /// No description provided for @noClockingEvents.
  ///
  /// In pt, this message translates to:
  /// **'Não há marcações registradas hoje'**
  String get noClockingEvents;

  /// Mensagem indicativo de processamento
  ///
  /// In pt, this message translates to:
  /// **'Carregando...'**
  String get loading;

  /// No description provided for @deviceSituation.
  ///
  /// In pt, this message translates to:
  /// **'Situação do dispositivo'**
  String get deviceSituation;

  /// No description provided for @goToLogin.
  ///
  /// In pt, this message translates to:
  /// **'Sair'**
  String get goToLogin;

  /// No description provided for @deviceAuthorizationIsPending.
  ///
  /// In pt, this message translates to:
  /// **'A função de Ponto não está ativada para este dispositivo devido à autorização pendente do RH.'**
  String get deviceAuthorizationIsPending;

  /// No description provided for @deviceAuthorizationWasRejected.
  ///
  /// In pt, this message translates to:
  /// **'A função de Ponto não está ativada para este dispositivo devido à autorização rejeitada pelo RH.'**
  String get deviceAuthorizationWasRejected;

  /// No description provided for @deviceActivationIsPending.
  ///
  /// In pt, this message translates to:
  /// **'A função de Ponto não está ativada para este dispositivo devido à ativação pendente do RH.'**
  String get deviceActivationIsPending;

  /// No description provided for @deviceActivationWasRejected.
  ///
  /// In pt, this message translates to:
  /// **'A função de Ponto não está ativada para este dispositivo devido à ativação rejeitada pelo RH.'**
  String get deviceActivationWasRejected;

  /// No description provided for @clockingEventSingleNotAvailable.
  ///
  /// In pt, this message translates to:
  /// **'A Marcação de ponto não está disponível para o modo individual para o seu usuário'**
  String get clockingEventSingleNotAvailable;

  /// No description provided for @contactRh.
  ///
  /// In pt, this message translates to:
  /// **'Por favor, contate o RH ou se dirija a um dispositivo coletivo para registrar o ponto.'**
  String get contactRh;

  /// No description provided for @clockingEvents.
  ///
  /// In pt, this message translates to:
  /// **'Marcações'**
  String get clockingEvents;

  /// Texto com a data de início e fim de um período.
  ///
  /// In pt, this message translates to:
  /// **'{fromDate} até {toDate}'**
  String rangeDate(String fromDate, String toDate);

  /// No description provided for @menuItemHome.
  ///
  /// In pt, this message translates to:
  /// **'Início'**
  String get menuItemHome;

  /// No description provided for @menuItemAppointment.
  ///
  /// In pt, this message translates to:
  /// **'Marcações'**
  String get menuItemAppointment;

  /// No description provided for @menuItemTime.
  ///
  /// In pt, this message translates to:
  /// **'Horas'**
  String get menuItemTime;

  /// No description provided for @menuItemProfile.
  ///
  /// In pt, this message translates to:
  /// **'Perfil'**
  String get menuItemProfile;

  /// No description provided for @clockingEventTitle.
  ///
  /// In pt, this message translates to:
  /// **'Ponto'**
  String get clockingEventTitle;

  /// No description provided for @clockingEventGoodMorning.
  ///
  /// In pt, this message translates to:
  /// **'Bom dia'**
  String get clockingEventGoodMorning;

  /// No description provided for @clockingEventGoodAfternoon.
  ///
  /// In pt, this message translates to:
  /// **'Boa tarde'**
  String get clockingEventGoodAfternoon;

  /// No description provided for @clockingEventGoodEvening.
  ///
  /// In pt, this message translates to:
  /// **'Boa noite'**
  String get clockingEventGoodEvening;

  /// No description provided for @clockingEventCaptureTime.
  ///
  /// In pt, this message translates to:
  /// **'Registrar ponto'**
  String get clockingEventCaptureTime;

  /// No description provided for @clockingEventCapturingTime.
  ///
  /// In pt, this message translates to:
  /// **'Realizando marcação'**
  String get clockingEventCapturingTime;

  /// No description provided for @clockingEventKeepButtonPressedToRegister.
  ///
  /// In pt, this message translates to:
  /// **'Mantenha o botão pressionado para registrar'**
  String get clockingEventKeepButtonPressedToRegister;

  /// No description provided for @clockingEventAppointmentMade.
  ///
  /// In pt, this message translates to:
  /// **'Marcação Realizada'**
  String get clockingEventAppointmentMade;

  /// No description provided for @clockingEventSeeReceipt.
  ///
  /// In pt, this message translates to:
  /// **'Ver comprovante'**
  String get clockingEventSeeReceipt;

  /// No description provided for @withoutClockingEvents.
  ///
  /// In pt, this message translates to:
  /// **'Sem marcações'**
  String get withoutClockingEvents;

  /// No description provided for @dateFormatter.
  ///
  /// In pt, this message translates to:
  /// **'dd/MM/yyyy'**
  String get dateFormatter;

  /// No description provided for @period.
  ///
  /// In pt, this message translates to:
  /// **'Período'**
  String get period;

  /// No description provided for @oddClockingEvent.
  ///
  /// In pt, this message translates to:
  /// **'Marcações ímpares'**
  String get oddClockingEvent;

  /// No description provided for @periodClockingEvent.
  ///
  /// In pt, this message translates to:
  /// **'Marcações do período'**
  String get periodClockingEvent;

  /// Texto definindo a data da última atualização
  ///
  /// In pt, this message translates to:
  /// **'Última atualização {date} às {hour}'**
  String lastUpdate(String date, String hour);

  /// No description provided for @clockInfoTitle1.
  ///
  /// In pt, this message translates to:
  /// **'Marcação não sincronizada'**
  String get clockInfoTitle1;

  /// No description provided for @clockInfoDescription1.
  ///
  /// In pt, this message translates to:
  /// **'São marcações que foram registradas e serão sincronizadas assim que houver conexão com a internet.'**
  String get clockInfoDescription1;

  /// No description provided for @clockInfoTitle2.
  ///
  /// In pt, this message translates to:
  /// **'Origem via celular e plataforma'**
  String get clockInfoTitle2;

  /// No description provided for @clockInfoDescription2.
  ///
  /// In pt, this message translates to:
  /// **'São marcações que foram registradas via aplicativo e plataforma. São categorizadas como marcação cross.'**
  String get clockInfoDescription2;

  /// No description provided for @clockInfoTitle3.
  ///
  /// In pt, this message translates to:
  /// **'Origem via celular'**
  String get clockInfoTitle3;

  /// No description provided for @clockInfoDescription3.
  ///
  /// In pt, this message translates to:
  /// **'São marcações que foram registradas via aplicativo tanto Ponto quanto Waapi.'**
  String get clockInfoDescription3;

  /// No description provided for @clockInfoTitle4.
  ///
  /// In pt, this message translates to:
  /// **'Origem via plataforma'**
  String get clockInfoTitle4;

  /// No description provided for @clockInfoDescription4.
  ///
  /// In pt, this message translates to:
  /// **'São marcações que foram registradas via plataforma.'**
  String get clockInfoDescription4;

  /// No description provided for @clockInfoTitle5.
  ///
  /// In pt, this message translates to:
  /// **'Marcação manual'**
  String get clockInfoTitle5;

  /// No description provided for @clockInfoDescription5.
  ///
  /// In pt, this message translates to:
  /// **'Marcações registradas manualmente pelo gestor ou colaborador através do app ou plataforma.'**
  String get clockInfoDescription5;

  /// No description provided for @clockInfoTitle6.
  ///
  /// In pt, this message translates to:
  /// **'Marcações ímpares'**
  String get clockInfoTitle6;

  /// No description provided for @clockInfoDescription6.
  ///
  /// In pt, this message translates to:
  /// **'Significa que falta uma marcação para sua jornada ficar completa, porém ela pode ter sido realizada em outro registrador de ponto.'**
  String get clockInfoDescription6;

  /// No description provided for @clockInfoTitle7.
  ///
  /// In pt, this message translates to:
  /// **'Marcações com afastamento'**
  String get clockInfoTitle7;

  /// No description provided for @clockInfoDescription7.
  ///
  /// In pt, this message translates to:
  /// **'São marcações que possuem algum afastamento lançado na jornada.'**
  String get clockInfoDescription7;

  /// No description provided for @infoUnderstoodButton.
  ///
  /// In pt, this message translates to:
  /// **'Entendi'**
  String get infoUnderstoodButton;

  /// No description provided for @registerCameraButton.
  ///
  /// In pt, this message translates to:
  /// **'Registrar'**
  String get registerCameraButton;

  /// No description provided for @clockingsOfTheDay.
  ///
  /// In pt, this message translates to:
  /// **'Marcações do dia'**
  String get clockingsOfTheDay;

  /// No description provided for @addClocking.
  ///
  /// In pt, this message translates to:
  /// **'Adicionar marcação'**
  String get addClocking;

  /// No description provided for @timeControlManagement.
  ///
  /// In pt, this message translates to:
  /// **'Gestão do Ponto'**
  String get timeControlManagement;

  /// No description provided for @centralizingJourney.
  ///
  /// In pt, this message translates to:
  /// **'Centralizando a jornada do colaborador'**
  String get centralizingJourney;

  /// No description provided for @haveControl.
  ///
  /// In pt, this message translates to:
  /// **'Tenha o controle da sua jornada do ponto.'**
  String get haveControl;

  /// No description provided for @shortcutsTimeControl.
  ///
  /// In pt, this message translates to:
  /// **'Atalhos para o Gestão do Ponto'**
  String get shortcutsTimeControl;

  /// No description provided for @recentClockingEventMessage.
  ///
  /// In pt, this message translates to:
  /// **'Você marcou o ponto há menos de 2 minutos. Deseja realizar outra marcação?'**
  String get recentClockingEventMessage;

  /// No description provided for @outsideTheFenceMessage.
  ///
  /// In pt, this message translates to:
  /// **'A localização atual está fora do perímetro definido pelo seu empregador. Deseja continuar?'**
  String get outsideTheFenceMessage;

  /// No description provided for @alert.
  ///
  /// In pt, this message translates to:
  /// **'Atenção'**
  String get alert;

  /// No description provided for @yes.
  ///
  /// In pt, this message translates to:
  /// **'Sim'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In pt, this message translates to:
  /// **'Não'**
  String get no;

  /// No description provided for @confirmAppointment.
  ///
  /// In pt, this message translates to:
  /// **'Confirmar marcação'**
  String get confirmAppointment;

  /// No description provided for @cancelAppointment.
  ///
  /// In pt, this message translates to:
  /// **'Não realizar marcação'**
  String get cancelAppointment;

  /// No description provided for @hoursWorkedTodayInfo.
  ///
  /// In pt, this message translates to:
  /// **'A quantidade de horas é calculada quando existem marcações em pares (entrada e saída), portanto o total é atualizado apenas ao registrar o fim de um período.'**
  String get hoursWorkedTodayInfo;

  /// No description provided for @syncClockingEventSyncSuccess.
  ///
  /// In pt, this message translates to:
  /// **'Sincronização concluída.'**
  String get syncClockingEventSyncSuccess;

  /// No description provided for @syncClockingEventSyncInternetUnavailable.
  ///
  /// In pt, this message translates to:
  /// **'Sincronização não concluída. Verifique sua conexão com a internet.'**
  String get syncClockingEventSyncInternetUnavailable;

  /// No description provided for @syncClockingEventSyncFailure.
  ///
  /// In pt, this message translates to:
  /// **'Desculpe, ocorreu uma falha na sincronização. Tente novamente.'**
  String get syncClockingEventSyncFailure;

  /// No description provided for @syncClockingEventSyncPartialSuccess.
  ///
  /// In pt, this message translates to:
  /// **'Sincronização concluída parcialmente. Alguns registros não foram sincronizados. Verifique sua conexão com a internet e tente novamente.'**
  String get syncClockingEventSyncPartialSuccess;

  /// No description provided for @configurations.
  ///
  /// In pt, this message translates to:
  /// **'Configurações'**
  String get configurations;

  /// No description provided for @completedAppointments.
  ///
  /// In pt, this message translates to:
  /// **'Marcações registradas'**
  String get completedAppointments;

  /// No description provided for @setKey.
  ///
  /// In pt, this message translates to:
  /// **'Configurar chave da aplicação'**
  String get setKey;

  /// No description provided for @permissions.
  ///
  /// In pt, this message translates to:
  /// **'Permissões'**
  String get permissions;

  /// No description provided for @syncAppointInfo.
  ///
  /// In pt, this message translates to:
  /// **'Sincronizar informações do ponto'**
  String get syncAppointInfo;

  /// No description provided for @resources.
  ///
  /// In pt, this message translates to:
  /// **'Recursos'**
  String get resources;

  /// No description provided for @facialRecognitionRegistration.
  ///
  /// In pt, this message translates to:
  /// **'Cadastro de reconhecimento facial'**
  String get facialRecognitionRegistration;

  /// No description provided for @facialRecognitionRegistrationDescription.
  ///
  /// In pt, this message translates to:
  /// **'Cadastrar reconhecimento facial de um novo colaborador'**
  String get facialRecognitionRegistrationDescription;

  /// No description provided for @readWebQRCode.
  ///
  /// In pt, this message translates to:
  /// **'Ler QRcode WEB'**
  String get readWebQRCode;

  /// No description provided for @readWebQRCodeDescription.
  ///
  /// In pt, this message translates to:
  /// **'Usar dispositivo para cadastrar reconhecimento facial de um novo colaborador'**
  String get readWebQRCodeDescription;

  /// No description provided for @othersResources.
  ///
  /// In pt, this message translates to:
  /// **'Outros'**
  String get othersResources;

  /// No description provided for @help.
  ///
  /// In pt, this message translates to:
  /// **'Ajuda'**
  String get help;

  /// No description provided for @helpCenter.
  ///
  /// In pt, this message translates to:
  /// **'Central de ajuda'**
  String get helpCenter;

  /// No description provided for @viewTourAgain.
  ///
  /// In pt, this message translates to:
  /// **'Visualizar tour novamente'**
  String get viewTourAgain;

  /// No description provided for @privacyPolicy.
  ///
  /// In pt, this message translates to:
  /// **'Política de privacidade'**
  String get privacyPolicy;

  /// No description provided for @about.
  ///
  /// In pt, this message translates to:
  /// **'Sobre'**
  String get about;

  /// No description provided for @signOut.
  ///
  /// In pt, this message translates to:
  /// **'Sair'**
  String get signOut;

  /// No description provided for @clockingEventNotAvailable.
  ///
  /// In pt, this message translates to:
  /// **'A marcação de ponto não está disponível para seu usuário.'**
  String get clockingEventNotAvailable;

  /// No description provided for @descriptionClockingEventNotAvailable.
  ///
  /// In pt, this message translates to:
  /// **'Por favor, aguarde ou contate o RH para obter mais informações.'**
  String get descriptionClockingEventNotAvailable;

  /// No description provided for @toView.
  ///
  /// In pt, this message translates to:
  /// **'Visualizar'**
  String get toView;

  /// Texto com mensagem de confirmação da marcação do ponto
  ///
  /// In pt, this message translates to:
  /// **'Marcação realizada às {hour} no dia {date} para {name}'**
  String successClockingEvent(String hour, String date, String name);

  /// No description provided for @configurationReminders.
  ///
  /// In pt, this message translates to:
  /// **'Configurar lembretes do ponto'**
  String get configurationReminders;

  /// No description provided for @configurationNotifications.
  ///
  /// In pt, this message translates to:
  /// **'Configurar notificações'**
  String get configurationNotifications;

  /// No description provided for @configurationRegisteredClock.
  ///
  /// In pt, this message translates to:
  /// **'Marcações registradas'**
  String get configurationRegisteredClock;

  /// No description provided for @configurationReports.
  ///
  /// In pt, this message translates to:
  /// **'Relatórios'**
  String get configurationReports;

  /// No description provided for @configurationAppReview.
  ///
  /// In pt, this message translates to:
  /// **'Avaliação do aplicativo'**
  String get configurationAppReview;

  /// No description provided for @configurationSearch.
  ///
  /// In pt, this message translates to:
  /// **'Pesquisa'**
  String get configurationSearch;

  /// No description provided for @configurationViewTourAgain.
  ///
  /// In pt, this message translates to:
  /// **'Visualizar tour novamente'**
  String get configurationViewTourAgain;

  /// No description provided for @configurationSynchronizationSuccessfully.
  ///
  /// In pt, this message translates to:
  /// **'Sincronização realizada com sucesso.'**
  String get configurationSynchronizationSuccessfully;

  /// No description provided for @configurationSynchronizationError.
  ///
  /// In pt, this message translates to:
  /// **'Não foi possível sincronizar as informações do ponto no momento. Tente novamente mais tarde.'**
  String get configurationSynchronizationError;

  /// No description provided for @hoursTitle.
  ///
  /// In pt, this message translates to:
  /// **'Totalizador de horas'**
  String get hoursTitle;

  /// No description provided for @hoursTabTitle1.
  ///
  /// In pt, this message translates to:
  /// **'Jornada do dia'**
  String get hoursTabTitle1;

  /// No description provided for @hoursTabTitle2.
  ///
  /// In pt, this message translates to:
  /// **'Saldo'**
  String get hoursTabTitle2;

  /// No description provided for @hoursTabTitle3.
  ///
  /// In pt, this message translates to:
  /// **'Espelho'**
  String get hoursTabTitle3;

  /// No description provided for @facialTryAgain.
  ///
  /// In pt, this message translates to:
  /// **'Tentar novamente'**
  String get facialTryAgain;

  /// No description provided for @facialRegistrationCompletedSuccessfully.
  ///
  /// In pt, this message translates to:
  /// **'Cadastro realizado com sucesso!'**
  String get facialRegistrationCompletedSuccessfully;

  /// No description provided for @facialBackStart.
  ///
  /// In pt, this message translates to:
  /// **'Voltar ao início'**
  String get facialBackStart;

  /// No description provided for @facialPerformingPhotoAnalysis.
  ///
  /// In pt, this message translates to:
  /// **'Realizando análise da foto...'**
  String get facialPerformingPhotoAnalysis;

  /// No description provided for @facialLooksLikeAreOffline.
  ///
  /// In pt, this message translates to:
  /// **'Sem conexão com a internet'**
  String get facialLooksLikeAreOffline;

  /// No description provided for @facialRegistrationOnlineCheckConnection.
  ///
  /// In pt, this message translates to:
  /// **'O cadastramento inicial deve ser feito conectado à internet. Verifique sua conexão e tente novamente.'**
  String get facialRegistrationOnlineCheckConnection;

  /// No description provided for @facialCheckingInformation.
  ///
  /// In pt, this message translates to:
  /// **'Verificando informações...'**
  String get facialCheckingInformation;

  /// No description provided for @facialTipsFacialRecognition.
  ///
  /// In pt, this message translates to:
  /// **'Dicas para o reconhecimento facial'**
  String get facialTipsFacialRecognition;

  /// No description provided for @facialFollowInstructionsCapture.
  ///
  /// In pt, this message translates to:
  /// **'Siga as instruções para uma boa captura'**
  String get facialFollowInstructionsCapture;

  /// No description provided for @facialPositionCellPhoneEyeCamera.
  ///
  /// In pt, this message translates to:
  /// **'Posicione o celular na altura dos seus olhos e olhe diretamente para a câmera;'**
  String get facialPositionCellPhoneEyeCamera;

  /// No description provided for @facialBeBrightEnvironmentPeopleBackground.
  ///
  /// In pt, this message translates to:
  /// **'Esteja em um ambiente iluminado, sem pessoas e objetos ao fundo;'**
  String get facialBeBrightEnvironmentPeopleBackground;

  /// No description provided for @facialAvoidWearingAccessoriesGlasses.
  ///
  /// In pt, this message translates to:
  /// **'Evite usar acessórios que escondam seu rosto, como óculos, bonés, máscaras e chapéus;'**
  String get facialAvoidWearingAccessoriesGlasses;

  /// No description provided for @facialAvoidShakingYourCellPhone.
  ///
  /// In pt, this message translates to:
  /// **'Evite tremer o seu celular durante a captura;'**
  String get facialAvoidShakingYourCellPhone;

  /// No description provided for @facialAvoidMakingFacesOrExpressions.
  ///
  /// In pt, this message translates to:
  /// **'Evite fazer caretas ou expressões que possam interferir na qualidade da captura;'**
  String get facialAvoidMakingFacesOrExpressions;

  /// No description provided for @facialIfNecessaryAskHelpCamera.
  ///
  /// In pt, this message translates to:
  /// **'Se achar necessário, peça ajuda a outra pessoa e ative a câmera traseira do seu celular.'**
  String get facialIfNecessaryAskHelpCamera;

  /// No description provided for @facialStartReconnaissance.
  ///
  /// In pt, this message translates to:
  /// **'Iniciar reconhecimento'**
  String get facialStartReconnaissance;

  /// No description provided for @facialPhotoCapture.
  ///
  /// In pt, this message translates to:
  /// **'Captura de foto'**
  String get facialPhotoCapture;

  /// No description provided for @facialPositionFaceToCapture.
  ///
  /// In pt, this message translates to:
  /// **'Posicione o rosto para capturar'**
  String get facialPositionFaceToCapture;

  /// No description provided for @facialFacialRecognition.
  ///
  /// In pt, this message translates to:
  /// **'Reconhecimento facial'**
  String get facialFacialRecognition;

  /// No description provided for @facialFacialRecognitionMultiMode.
  ///
  /// In pt, this message translates to:
  /// **'Registrar por rosto'**
  String get facialFacialRecognitionMultiMode;

  /// No description provided for @recognitionMultiModeInProgress.
  ///
  /// In pt, this message translates to:
  /// **'Aguarde...'**
  String get recognitionMultiModeInProgress;

  /// No description provided for @recognitionMultiModeDoSync.
  ///
  /// In pt, this message translates to:
  /// **'Não encontramos nenhuma face cadastrada. Realize o cadastramento de faces ou sincronização para prosseguir com a marcação.'**
  String get recognitionMultiModeDoSync;

  /// No description provided for @facialModalAlertTitle.
  ///
  /// In pt, this message translates to:
  /// **'Tem certeza que deseja registrar sem reconhecimento da face?'**
  String get facialModalAlertTitle;

  /// No description provided for @facialModalAlertTryOtherWay.
  ///
  /// In pt, this message translates to:
  /// **'Tentar outra forma'**
  String get facialModalAlertTryOtherWay;

  /// No description provided for @facialModalAlertTryOtherWayDescription.
  ///
  /// In pt, this message translates to:
  /// **'Caso não consigo realizar o registro por reconhecimento facial tente outra forma para registrar sua marcação'**
  String get facialModalAlertTryOtherWayDescription;

  /// No description provided for @facialModalAlertContent.
  ///
  /// In pt, this message translates to:
  /// **'A marcação de ponto será realizada sem registro do reconhecimento facial.'**
  String get facialModalAlertContent;

  /// No description provided for @facialModalAlertBackButton.
  ///
  /// In pt, this message translates to:
  /// **'Voltar'**
  String get facialModalAlertBackButton;

  /// No description provided for @facialModalAlertProceedButton.
  ///
  /// In pt, this message translates to:
  /// **'Registrar sem face'**
  String get facialModalAlertProceedButton;

  /// No description provided for @facialInitTechnologyTitle.
  ///
  /// In pt, this message translates to:
  /// **'Inicializando tecnologia'**
  String get facialInitTechnologyTitle;

  /// No description provided for @facialInitTechnologyContent.
  ///
  /// In pt, this message translates to:
  /// **'Enquanto é iniciada a tecnologia de reconhecimento facial, a marcação de ponto será feita sem a identificação de face.'**
  String get facialInitTechnologyContent;

  /// No description provided for @facialRecognitionRegistrationQuestion.
  ///
  /// In pt, this message translates to:
  /// **'Realizar o cadastro de reconhecimento facial?'**
  String get facialRecognitionRegistrationQuestion;

  /// No description provided for @facialRecognitionRegistrationInformation.
  ///
  /// In pt, this message translates to:
  /// **'Você ainda não cadastrou seu rosto para registro do ponto com reconhecimento facial. Cadastre agora e garanta mais segurança e agilidade dos seus dados.'**
  String get facialRecognitionRegistrationInformation;

  /// No description provided for @facialRegisterNow.
  ///
  /// In pt, this message translates to:
  /// **'Cadastrar agora'**
  String get facialRegisterNow;

  /// No description provided for @facialCouldNotanalyzePhoto.
  ///
  /// In pt, this message translates to:
  /// **'Não foi possível analisar a foto'**
  String get facialCouldNotanalyzePhoto;

  /// No description provided for @facialTryAgainLater.
  ///
  /// In pt, this message translates to:
  /// **'Tente novamente ou aguarde alguns instantes para repetir a ação.'**
  String get facialTryAgainLater;

  /// No description provided for @facialNotIdentifiedFace.
  ///
  /// In pt, this message translates to:
  /// **'Rosto não identificado'**
  String get facialNotIdentifiedFace;

  /// No description provided for @facialLowQualityPhoto.
  ///
  /// In pt, this message translates to:
  /// **'A foto está com baixa qualidade ou desfocada.'**
  String get facialLowQualityPhoto;

  /// No description provided for @facialFaceIsntVisible.
  ///
  /// In pt, this message translates to:
  /// **'Certifique-se de que seu rosto esteja visível e dentro do enquadramento e tente novamente.'**
  String get facialFaceIsntVisible;

  /// No description provided for @facialRecognitionRegistrationSoonAvailable.
  ///
  /// In pt, this message translates to:
  /// **'Dentro de alguns minutos a marcação por reconhecimento facial já estará disponível para você.'**
  String get facialRecognitionRegistrationSoonAvailable;

  /// No description provided for @facialFaceAlreadyRegistered.
  ///
  /// In pt, this message translates to:
  /// **'Rosto já cadastrado!'**
  String get facialFaceAlreadyRegistered;

  /// No description provided for @facialRecognitionRegistrationAvailable.
  ///
  /// In pt, this message translates to:
  /// **'A marcação por reconhecimento facial já está disponível.'**
  String get facialRecognitionRegistrationAvailable;

  /// No description provided for @facialRecognitionRegistrationEmployee.
  ///
  /// In pt, this message translates to:
  /// **'Cadastro reconhecimento facial'**
  String get facialRecognitionRegistrationEmployee;

  /// No description provided for @facialSelectEmployeeTitle.
  ///
  /// In pt, this message translates to:
  /// **'Selecione o colaborador que deseja cadastrar o reconhecimento facial'**
  String get facialSelectEmployeeTitle;

  /// No description provided for @enterRrSearchForTheCollaborator.
  ///
  /// In pt, this message translates to:
  /// **'Digite ou busque o colaborador'**
  String get enterRrSearchForTheCollaborator;

  /// No description provided for @employeeList.
  ///
  /// In pt, this message translates to:
  /// **'Lista de colaboradores'**
  String get employeeList;

  /// No description provided for @continueText.
  ///
  /// In pt, this message translates to:
  /// **'Continuar'**
  String get continueText;

  /// No description provided for @collaborator.
  ///
  /// In pt, this message translates to:
  /// **'Colaborador'**
  String get collaborator;

  /// No description provided for @userWithoutPermission.
  ///
  /// In pt, this message translates to:
  /// **'Usuário sem permissão'**
  String get userWithoutPermission;

  /// No description provided for @userWithoutPermissionDescription.
  ///
  /// In pt, this message translates to:
  /// **'Por favor, contate o RH para verificar a permissão do seu usuário.'**
  String get userWithoutPermissionDescription;

  /// No description provided for @unresponsiveService.
  ///
  /// In pt, this message translates to:
  /// **'Serviço sem resposta'**
  String get unresponsiveService;

  /// No description provided for @unresponsiveServiceDescription.
  ///
  /// In pt, this message translates to:
  /// **'Não foi possivel estabelecer uma conexão com o serviço de marcação de ponto.'**
  String get unresponsiveServiceDescription;

  /// No description provided for @facialUserNoPermissionTitle.
  ///
  /// In pt, this message translates to:
  /// **'Usuário sem permissão'**
  String get facialUserNoPermissionTitle;

  /// No description provided for @facialUserNoPermissionMessage.
  ///
  /// In pt, this message translates to:
  /// **'Por favor, contate o RH para verificar a permissão do seu usuário.'**
  String get facialUserNoPermissionMessage;

  /// No description provided for @registerWithoutConfirm.
  ///
  /// In pt, this message translates to:
  /// **'Tem certeza que deseja registrar sem a confirmação?'**
  String get registerWithoutConfirm;

  /// No description provided for @willRegisterWithoutPhoto.
  ///
  /// In pt, this message translates to:
  /// **'O registro de ponto será realizado sem a confirmação de foto.'**
  String get willRegisterWithoutPhoto;

  /// No description provided for @registerWithoutPhoto.
  ///
  /// In pt, this message translates to:
  /// **'Registrar sem foto'**
  String get registerWithoutPhoto;

  /// No description provided for @reRegister.
  ///
  /// In pt, this message translates to:
  /// **'Recadastrar'**
  String get reRegister;

  /// No description provided for @permissionCameraNotAllowedMessage.
  ///
  /// In pt, this message translates to:
  /// **'Para utilizar o reconhecimento facial e captura de foto após marcação, é necessário permitir acesso à câmera do dispositivo. Essa informação não é obrigatória, mas complementa seu registro.'**
  String get permissionCameraNotAllowedMessage;

  /// No description provided for @permissionLocationNotAllowedMessage.
  ///
  /// In pt, this message translates to:
  /// **'Recomendamos adicionar o local à sua marcação de ponto, para isso é necessário permitir acesso à localização do dispositivo. Essa informação não é obrigatória, mas complementa seu registro.'**
  String get permissionLocationNotAllowedMessage;

  /// No description provided for @goToConfiguration.
  ///
  /// In pt, this message translates to:
  /// **'Permissões'**
  String get goToConfiguration;

  /// No description provided for @continueAction.
  ///
  /// In pt, this message translates to:
  /// **'Continuar'**
  String get continueAction;

  /// No description provided for @deviceSettings.
  ///
  /// In pt, this message translates to:
  /// **'Configurações do dispositivo'**
  String get deviceSettings;

  /// No description provided for @setPushNotification.
  ///
  /// In pt, this message translates to:
  /// **'Configurar notificações por push'**
  String get setPushNotification;

  /// No description provided for @appReview.
  ///
  /// In pt, this message translates to:
  /// **'Avaliação do aplicativo'**
  String get appReview;

  /// No description provided for @searchApp.
  ///
  /// In pt, this message translates to:
  /// **'Pesquisa'**
  String get searchApp;

  /// No description provided for @applicationKeyHelpTitle.
  ///
  /// In pt, this message translates to:
  /// **'Entenda a configuração de chave para o dispositivo móvel'**
  String get applicationKeyHelpTitle;

  /// No description provided for @applicationKeyHelpContent1.
  ///
  /// In pt, this message translates to:
  /// **'Cadastre a chave de aplicação na Plataforma Senior X'**
  String get applicationKeyHelpContent1;

  /// No description provided for @applicationKeyHelpContent2.
  ///
  /// In pt, this message translates to:
  /// **'Adicione as informações de chave e segredo para a aplicação cadastrada, que será responsável pela comunicação da Plataforma Senior X com o Marcação de Ponto 2.0;'**
  String get applicationKeyHelpContent2;

  /// No description provided for @applicationKeyHelpContent3.
  ///
  /// In pt, this message translates to:
  /// **'Se você tem certeza de que as informações estão corretas e ainda estiver enfrentando problemas para entrar no aplicativo, verifique com o RH da sua empresa.'**
  String get applicationKeyHelpContent3;

  /// No description provided for @keyAlreadyRegistered.
  ///
  /// In pt, this message translates to:
  /// **'Chave já cadastrada!'**
  String get keyAlreadyRegistered;

  /// No description provided for @registerNewkey.
  ///
  /// In pt, this message translates to:
  /// **'Registrar nova chave'**
  String get registerNewkey;

  /// No description provided for @keyAlreadyRegisteredDescription.
  ///
  /// In pt, this message translates to:
  /// **'Você pode remover a chave com a ação abaixo.'**
  String get keyAlreadyRegisteredDescription;

  /// No description provided for @keyAlreadyRegisteredRemove.
  ///
  /// In pt, this message translates to:
  /// **'Remover chave'**
  String get keyAlreadyRegisteredRemove;

  /// No description provided for @helpTextDocumentationPortal.
  ///
  /// In pt, this message translates to:
  /// **'Portal de documentação'**
  String get helpTextDocumentationPortal;

  /// No description provided for @keyRegisteredSuccessfully.
  ///
  /// In pt, this message translates to:
  /// **'Chave cadastrada com sucesso!'**
  String get keyRegisteredSuccessfully;

  /// No description provided for @keyRegisteredSuccessfullyDescription.
  ///
  /// In pt, this message translates to:
  /// **'Os recursos estarão disponíveis para uso na home.'**
  String get keyRegisteredSuccessfullyDescription;

  /// No description provided for @keyRegisteredSuccessfullyBackHome.
  ///
  /// In pt, this message translates to:
  /// **'Voltar ao início'**
  String get keyRegisteredSuccessfullyBackHome;

  /// No description provided for @searchEmployee.
  ///
  /// In pt, this message translates to:
  /// **'Buscar colaborador'**
  String get searchEmployee;

  /// No description provided for @selectPeriodToFilter.
  ///
  /// In pt, this message translates to:
  /// **'Selecione um período para filtrar'**
  String get selectPeriodToFilter;

  /// No description provided for @change.
  ///
  /// In pt, this message translates to:
  /// **'Trocar'**
  String get change;

  /// No description provided for @init.
  ///
  /// In pt, this message translates to:
  /// **'Inicial'**
  String get init;

  /// No description provided for @end.
  ///
  /// In pt, this message translates to:
  /// **'Final'**
  String get end;

  /// No description provided for @filter.
  ///
  /// In pt, this message translates to:
  /// **'Filtrar'**
  String get filter;

  /// No description provided for @cancel.
  ///
  /// In pt, this message translates to:
  /// **'Cancelar'**
  String get cancel;

  /// No description provided for @invalidDate.
  ///
  /// In pt, this message translates to:
  /// **'Data inválida'**
  String get invalidDate;

  /// No description provided for @invalidDateFormat.
  ///
  /// In pt, this message translates to:
  /// **'Formato da data inválido'**
  String get invalidDateFormat;

  /// No description provided for @moreThanEndDate.
  ///
  /// In pt, this message translates to:
  /// **'Maior que a data final'**
  String get moreThanEndDate;

  /// No description provided for @lessThanStartDate.
  ///
  /// In pt, this message translates to:
  /// **'Menor que a data inicial'**
  String get lessThanStartDate;

  /// No description provided for @driversJourney.
  ///
  /// In pt, this message translates to:
  /// **'Jornada do motorista'**
  String get driversJourney;

  /// No description provided for @workStatus.
  ///
  /// In pt, this message translates to:
  /// **'Status de trabalho'**
  String get workStatus;

  /// No description provided for @notStarted.
  ///
  /// In pt, this message translates to:
  /// **'Não iniciado'**
  String get notStarted;

  /// No description provided for @working.
  ///
  /// In pt, this message translates to:
  /// **'Trabalhando'**
  String get working;

  /// No description provided for @driving.
  ///
  /// In pt, this message translates to:
  /// **'Dirigindo'**
  String get driving;

  /// No description provided for @mandatoryBreak.
  ///
  /// In pt, this message translates to:
  /// **'Pausa obrigatória'**
  String get mandatoryBreak;

  /// No description provided for @foodTime.
  ///
  /// In pt, this message translates to:
  /// **'Intervalo'**
  String get foodTime;

  /// No description provided for @waiting.
  ///
  /// In pt, this message translates to:
  /// **'Espera'**
  String get waiting;

  /// No description provided for @actions.
  ///
  /// In pt, this message translates to:
  /// **'Ações'**
  String get actions;

  /// No description provided for @startDrivingWithLineBreak.
  ///
  /// In pt, this message translates to:
  /// **'Iniciar\ndireção'**
  String get startDrivingWithLineBreak;

  /// No description provided for @startMandatoryBreakWithLineBreak.
  ///
  /// In pt, this message translates to:
  /// **'Iniciar pausa\nobrigatória'**
  String get startMandatoryBreakWithLineBreak;

  /// No description provided for @startWaitingWithLineBreak.
  ///
  /// In pt, this message translates to:
  /// **'Iniciar\nespera'**
  String get startWaitingWithLineBreak;

  /// No description provided for @startFoodTimeWithLineBreak.
  ///
  /// In pt, this message translates to:
  /// **'Iniciar\nintervalo'**
  String get startFoodTimeWithLineBreak;

  /// No description provided for @startJourney.
  ///
  /// In pt, this message translates to:
  /// **'Iniciar jornada'**
  String get startJourney;

  /// No description provided for @newJourney.
  ///
  /// In pt, this message translates to:
  /// **'Nova jornada'**
  String get newJourney;

  /// No description provided for @stopDriving.
  ///
  /// In pt, this message translates to:
  /// **'Encerrar direção'**
  String get stopDriving;

  /// No description provided for @stopMandatoryBreak.
  ///
  /// In pt, this message translates to:
  /// **'Encerrar pausa'**
  String get stopMandatoryBreak;

  /// No description provided for @stopFoodTime.
  ///
  /// In pt, this message translates to:
  /// **'Encerrar intervalo'**
  String get stopFoodTime;

  /// No description provided for @stopWaiting.
  ///
  /// In pt, this message translates to:
  /// **'Encerrar espera'**
  String get stopWaiting;

  /// No description provided for @journeyStart.
  ///
  /// In pt, this message translates to:
  /// **'Início da jornada'**
  String get journeyStart;

  /// No description provided for @numberOfPauses.
  ///
  /// In pt, this message translates to:
  /// **'Número de pausas'**
  String get numberOfPauses;

  /// No description provided for @totalWorked.
  ///
  /// In pt, this message translates to:
  /// **'Total trabalhado'**
  String get totalWorked;

  /// No description provided for @totalWorkedInfo.
  ///
  /// In pt, this message translates to:
  /// **'Tempo atualizado do total trabalhado do início da jornada até o momento. Não inclui pausas obrigatórias e refeições. Caso o valor total esteja zerado e vermelho, significa que a jornada contém marcações impares.'**
  String get totalWorkedInfo;

  /// No description provided for @timeInWorking.
  ///
  /// In pt, this message translates to:
  /// **'Tempo trabalhando'**
  String get timeInWorking;

  /// No description provided for @timeInDriving.
  ///
  /// In pt, this message translates to:
  /// **'Tempo dirigindo'**
  String get timeInDriving;

  /// No description provided for @timeInMandatoryBreak.
  ///
  /// In pt, this message translates to:
  /// **'Tempo em pausa obrigatória'**
  String get timeInMandatoryBreak;

  /// No description provided for @timeInFoodTime.
  ///
  /// In pt, this message translates to:
  /// **'Tempo em intervalo'**
  String get timeInFoodTime;

  /// No description provided for @timeInWaiting.
  ///
  /// In pt, this message translates to:
  /// **'Tempo em espera'**
  String get timeInWaiting;

  /// No description provided for @hours.
  ///
  /// In pt, this message translates to:
  /// **'horas'**
  String get hours;

  /// No description provided for @minutes.
  ///
  /// In pt, this message translates to:
  /// **'min'**
  String get minutes;

  /// No description provided for @seconds.
  ///
  /// In pt, this message translates to:
  /// **'seg'**
  String get seconds;

  /// No description provided for @workingStatusDescription.
  ///
  /// In pt, this message translates to:
  /// **'Jornada de trabalho decorrida desde o início da jornada, independente dos status específicos que foram registrados.'**
  String get workingStatusDescription;

  /// No description provided for @deviceLocation.
  ///
  /// In pt, this message translates to:
  /// **'Localização do dispositivo'**
  String get deviceLocation;

  /// No description provided for @deviceLocationDescription.
  ///
  /// In pt, this message translates to:
  /// **'Permite determinar a localização geográfica do dispositivo no momento das marcações.'**
  String get deviceLocationDescription;

  /// No description provided for @drive.
  ///
  /// In pt, this message translates to:
  /// **'Direção'**
  String get drive;

  /// No description provided for @drivingStatusDescription.
  ///
  /// In pt, this message translates to:
  /// **'Tempo de condução do veículo durante a jornada do dia.'**
  String get drivingStatusDescription;

  /// No description provided for @mandatoryBreakStatusDescription.
  ///
  /// In pt, this message translates to:
  /// **'A pausa obrigatória é importante para prevenir a fadiga e assegurar viagens mais seguras, é contado como parte da sua jornada.'**
  String get mandatoryBreakStatusDescription;

  /// No description provided for @foodTimeOrBreaks.
  ///
  /// In pt, this message translates to:
  /// **'Refeição ou intervalos'**
  String get foodTimeOrBreaks;

  /// No description provided for @foodTimeStatusDescription.
  ///
  /// In pt, this message translates to:
  /// **'Assim como a pausa, os intervalos principais para refeição são importantes para evitar cansaço e fadiga. Esses intervalos não contam como tempo trabalhado.'**
  String get foodTimeStatusDescription;

  /// No description provided for @waitingTime.
  ///
  /// In pt, this message translates to:
  /// **'Tempo de espera'**
  String get waitingTime;

  /// No description provided for @waitingStatusDescription.
  ///
  /// In pt, this message translates to:
  /// **'Os períodos de espera indicam um período sem movimento do veículo, mas que necessitam do acompanhamento do motorista, como fila de balança, carga e descarga do caminhão, dentre outros.'**
  String get waitingStatusDescription;

  /// No description provided for @overnight.
  ///
  /// In pt, this message translates to:
  /// **'Pernoite'**
  String get overnight;

  /// No description provided for @overnightDescription.
  ///
  /// In pt, this message translates to:
  /// **'Registra a estada/pernoite durante uma viagem mais extensa para descanso entre uma jornada e outra.'**
  String get overnightDescription;

  /// No description provided for @paidBreak.
  ///
  /// In pt, this message translates to:
  /// **'Pausa abonada'**
  String get paidBreak;

  /// No description provided for @paidBreakStatusDescription.
  ///
  /// In pt, this message translates to:
  /// **'Este intervalo é considerado como tempo de trabalho e, portanto, não resulta em redução do salário do empregado.'**
  String get paidBreakStatusDescription;

  /// No description provided for @mainTimeClocking.
  ///
  /// In pt, this message translates to:
  /// **'Marcação de ponto'**
  String get mainTimeClocking;

  /// No description provided for @mainTimeClockingDescription.
  ///
  /// In pt, this message translates to:
  /// **'Marcações de ponto (de entrada ou saída) registradas.'**
  String get mainTimeClockingDescription;

  /// No description provided for @hoursWorkedInfo.
  ///
  /// In pt, this message translates to:
  /// **'Total atualizado ao registrar entrada e saída. Inclui tempo de trabalho, direção e espera.'**
  String get hoursWorkedInfo;

  /// No description provided for @timeInBreaks.
  ///
  /// In pt, this message translates to:
  /// **'Tempo em pausas'**
  String get timeInBreaks;

  /// No description provided for @breaksInfo.
  ///
  /// In pt, this message translates to:
  /// **'Total atualizado ao registrar início e fim. Inclui pausas obrigatórias e refeição.'**
  String get breaksInfo;

  /// No description provided for @moreDetails.
  ///
  /// In pt, this message translates to:
  /// **'Mais detalhes'**
  String get moreDetails;

  /// Texto para exibir 2 horários e o total entre os 2
  ///
  /// In pt, this message translates to:
  /// **'De {startTime} até {endTime}, total de {totalTime}'**
  String betweenTimes(String startTime, String endTime, String totalTime);

  /// No description provided for @totalsOfTheDay.
  ///
  /// In pt, this message translates to:
  /// **'Totalizadores do dia'**
  String get totalsOfTheDay;

  /// No description provided for @foodTimeStatusDescriptionModal.
  ///
  /// In pt, this message translates to:
  /// **'O intervalo dentro de uma jornada é destinado, normalmente, para refeições, mas também é muito importante para evitar fadiga. Em algumas jornadas podem existir mais de um intervalo.'**
  String get foodTimeStatusDescriptionModal;

  /// No description provided for @wasThisInformationHelpful.
  ///
  /// In pt, this message translates to:
  /// **'Esta informação foi útil?'**
  String get wasThisInformationHelpful;

  /// No description provided for @enableLogs.
  ///
  /// In pt, this message translates to:
  /// **'Ativar logs'**
  String get enableLogs;

  /// No description provided for @disableLogs.
  ///
  /// In pt, this message translates to:
  /// **'Desativar logs'**
  String get disableLogs;

  /// No description provided for @logsDisabled.
  ///
  /// In pt, this message translates to:
  /// **'Logs desativados'**
  String get logsDisabled;

  /// No description provided for @logsEnabled.
  ///
  /// In pt, this message translates to:
  /// **'Logs ativados'**
  String get logsEnabled;

  /// No description provided for @sendLogs.
  ///
  /// In pt, this message translates to:
  /// **'Enviar logs'**
  String get sendLogs;

  /// No description provided for @successfulSyncLogs.
  ///
  /// In pt, this message translates to:
  /// **'Sucesso ao sincronizar os logs'**
  String get successfulSyncLogs;

  /// No description provided for @partialSuccessSyncLogs.
  ///
  /// In pt, this message translates to:
  /// **'Sucesso parcial ao sincronizar os logs'**
  String get partialSuccessSyncLogs;

  /// No description provided for @faliedSyncLogs.
  ///
  /// In pt, this message translates to:
  /// **'Falha ao sincronizar os logs'**
  String get faliedSyncLogs;

  /// No description provided for @unexpectedErrorSyncLogs.
  ///
  /// In pt, this message translates to:
  /// **'Erro inesperado ao sincronizar os logs'**
  String get unexpectedErrorSyncLogs;

  /// No description provided for @notLogsToSync.
  ///
  /// In pt, this message translates to:
  /// **'Não existem logs para sincronizar'**
  String get notLogsToSync;

  /// No description provided for @aboutScreenAppTitle.
  ///
  /// In pt, this message translates to:
  /// **'Aplicativo'**
  String get aboutScreenAppTitle;

  /// No description provided for @aboutScreenVersion.
  ///
  /// In pt, this message translates to:
  /// **'Versão'**
  String get aboutScreenVersion;

  /// No description provided for @aboutScreenDeviceTitle.
  ///
  /// In pt, this message translates to:
  /// **'Dispositivo'**
  String get aboutScreenDeviceTitle;

  /// No description provided for @aboutScreenIdentifier.
  ///
  /// In pt, this message translates to:
  /// **'Identificador'**
  String get aboutScreenIdentifier;

  /// No description provided for @aboutScreenModel.
  ///
  /// In pt, this message translates to:
  /// **'Modelo'**
  String get aboutScreenModel;

  /// No description provided for @aboutScreenName.
  ///
  /// In pt, this message translates to:
  /// **'Nome'**
  String get aboutScreenName;

  /// No description provided for @aboutScreenDevelopedBy.
  ///
  /// In pt, this message translates to:
  /// **'Desenvolvido por'**
  String get aboutScreenDevelopedBy;

  /// No description provided for @removeFilter.
  ///
  /// In pt, this message translates to:
  /// **'Limpar'**
  String get removeFilter;

  /// No description provided for @checkConnectivityForKeys.
  ///
  /// In pt, this message translates to:
  /// **'A chave de aplicação deve ser gerenciada de forma online. Verifique sua conexão e tente novamente.'**
  String get checkConnectivityForKeys;

  /// No description provided for @selectTheStartingDate.
  ///
  /// In pt, this message translates to:
  /// **'Selecione a data de início'**
  String get selectTheStartingDate;

  /// No description provided for @selectTheEndDate.
  ///
  /// In pt, this message translates to:
  /// **'Selecione a data final'**
  String get selectTheEndDate;

  /// No description provided for @reminderClockingEventMessageIntraJourney.
  ///
  /// In pt, this message translates to:
  /// **'Você marcou o ponto há menos de {reminderTime}. No intervalo para descanso e refeição importante completar o período mínimo antes de retornar ao trabalho.'**
  String reminderClockingEventMessageIntraJourney(Object reminderTime);

  /// No description provided for @reminderClockingEventMessageInterJourney.
  ///
  /// In pt, this message translates to:
  /// **'Você marcou o ponto há menos de {reminderTime}. No intervalo para descanso entre jornadas é importante completar o período mínimo antes de retornar ao trabalho.'**
  String reminderClockingEventMessageInterJourney(Object reminderTime);

  /// No description provided for @warning.
  ///
  /// In pt, this message translates to:
  /// **'Aviso'**
  String get warning;

  /// No description provided for @registerKeyOnSyncLogs.
  ///
  /// In pt, this message translates to:
  /// **'Os logs só podem ser enviados se houver uma chave de aplicação configurada'**
  String get registerKeyOnSyncLogs;

  /// No description provided for @hasNoConnectivityToSync.
  ///
  /// In pt, this message translates to:
  /// **'Sem conexão para realizar a sincronia de dados.'**
  String get hasNoConnectivityToSync;

  /// No description provided for @unableToSyncClockingEvents.
  ///
  /// In pt, this message translates to:
  /// **'Não foi possível sincronizar marcações'**
  String get unableToSyncClockingEvents;

  /// No description provided for @syncUnsuccessful.
  ///
  /// In pt, this message translates to:
  /// **'Sincronização não sucedida'**
  String get syncUnsuccessful;

  /// Texto com algum motivo
  ///
  /// In pt, this message translates to:
  /// **'Motivo:\n{reason}'**
  String reason(String reason);

  /// No description provided for @unsyncedClockingEvents.
  ///
  /// In pt, this message translates to:
  /// **'Marcações não sincronizadas'**
  String get unsyncedClockingEvents;

  /// No description provided for @syncClockingEventsBeforeRemoveKeys.
  ///
  /// In pt, this message translates to:
  /// **'Existem marcações não sincronizadas. Faça a sincronização antes de remover a chave.'**
  String get syncClockingEventsBeforeRemoveKeys;

  /// No description provided for @confirmRemoveKeys.
  ///
  /// In pt, this message translates to:
  /// **'Tem certeza que deseja remover?\nSerá desvinculada a conta de sua empresa e todas as informações dos colaboradores, assim como marcações, serão removidas do dispositivo.'**
  String get confirmRemoveKeys;

  /// No description provided for @loadingUnsyncedClockingEvents.
  ///
  /// In pt, this message translates to:
  /// **'Buscando marcações não sincronizadas...'**
  String get loadingUnsyncedClockingEvents;

  /// No description provided for @verifiyngConnectivity.
  ///
  /// In pt, this message translates to:
  /// **'Verificando conexão com a internet...'**
  String get verifiyngConnectivity;

  /// No description provided for @syncingClockingEvents.
  ///
  /// In pt, this message translates to:
  /// **'Sincronizando marcações...'**
  String get syncingClockingEvents;

  /// No description provided for @removingKeys.
  ///
  /// In pt, this message translates to:
  /// **'Removendo chaves...'**
  String get removingKeys;

  /// No description provided for @keysNotRemoved.
  ///
  /// In pt, this message translates to:
  /// **'Chaves não removidas'**
  String get keysNotRemoved;

  /// No description provided for @keysRemovedUnsuccessfully.
  ///
  /// In pt, this message translates to:
  /// **'Não foi possível fazer a remoção completa das chaves. Tente novamente.'**
  String get keysRemovedUnsuccessfully;

  /// No description provided for @keysRemoved.
  ///
  /// In pt, this message translates to:
  /// **'Chaves removidas'**
  String get keysRemoved;

  /// No description provided for @keysRemovedSuccessfully.
  ///
  /// In pt, this message translates to:
  /// **'As chaves foram removidas com sucesso.'**
  String get keysRemovedSuccessfully;

  /// No description provided for @initJourney.
  ///
  /// In pt, this message translates to:
  /// **'Iniciar jornada?'**
  String get initJourney;

  /// No description provided for @initJourneyBeforeStartAction.
  ///
  /// In pt, this message translates to:
  /// **'Nenhuma jornada em andamento, deseja iniciar uma jornada antes de prosseguir?'**
  String get initJourneyBeforeStartAction;

  /// No description provided for @initMyJourney.
  ///
  /// In pt, this message translates to:
  /// **'Iniciar minha jornada'**
  String get initMyJourney;

  /// No description provided for @manualRegistration.
  ///
  /// In pt, this message translates to:
  /// **'Registro manual'**
  String get manualRegistration;

  /// No description provided for @ok.
  ///
  /// In pt, this message translates to:
  /// **'Ok'**
  String get ok;

  /// No description provided for @continueRegistration.
  ///
  /// In pt, this message translates to:
  /// **'Deseja continuar o registro?'**
  String get continueRegistration;

  /// No description provided for @wantToStartJourney.
  ///
  /// In pt, this message translates to:
  /// **'Deseja iniciar jornada?'**
  String get wantToStartJourney;

  /// Texto perguntando se deseja iniciar a jornada antes de iniciar a ação
  ///
  /// In pt, this message translates to:
  /// **'Ainda não foi realizada uma marcação de início de jornada. Deseja começar agora antes de registrar {action}?'**
  String startJourneyBeforeStartAction(String action);

  /// Texto informando que a jornada e a ação foram iniciadas
  ///
  /// In pt, this message translates to:
  /// **'Jornada e {actionLabel} iniciado(a) com sucesso.'**
  String journeyStartedBeforeAction(String actionLabel);

  /// Texto informando que a ação foi iniciada sem a jornada
  ///
  /// In pt, this message translates to:
  /// **'{actionLabel} iniciado(a), mas a jornada não. Um ajuste manual deverá ser realizado posteriormente.'**
  String actionStartedWithoutJourney(String actionLabel);

  /// Texto perguntando se deseja finalizar a ação atual antes de iniciar a próxima
  ///
  /// In pt, this message translates to:
  /// **'Deseja finalizar {currentActionLabel} antes de iniciar {nextActionLabel} na sequência?'**
  String finishCurrentActionBeforeStartNextAction(String currentActionLabel, String nextActionLabel);

  /// Texto informando que a nova ação foi iniciada e a anterior não foi finalizada
  ///
  /// In pt, this message translates to:
  /// **'{newActionLabel} iniciado(a) e {previousActionLabel} não finalizado(a) pela aplicação. Faça o ajuste manual posteriormente, se necessário.'**
  String newActionStartedAndPreviousDoesNot(String newActionLabel, String previousActionLabel);

  /// Texto informando que a ação anterior foi finalizada e a nova foi iniciada
  ///
  /// In pt, this message translates to:
  /// **'{previousActionLabel} finalizado(a) e {newActionLabel} iniciado(a) com sucesso.'**
  String previousActionFinishedAndNewStarted(String previousActionLabel, String newActionLabel);

  /// Texto perguntando se deseja finalizar a ação antes de encerrar a jornada
  ///
  /// In pt, this message translates to:
  /// **'Deseja finalizar {actionLabel} antes de encerrar a jornada?'**
  String closeActionBeforeEndJourney(String actionLabel);

  /// Texto informando que a ação e a jornada foram finalizadas
  ///
  /// In pt, this message translates to:
  /// **'{actionLabel} e jornada finalizada com sucesso.'**
  String previousActionClosedAndJourneyEnded(String actionLabel);

  /// Texto informando que a jornada foi finalizada, mas a ação não
  ///
  /// In pt, this message translates to:
  /// **'Jornada finalizada, mas {actionLabel} não. Um ajuste manual deverá ser realizado posteriormente.'**
  String journeyFinishedAndPreviousActionDoesNot(String actionLabel);

  /// No description provided for @finish.
  ///
  /// In pt, this message translates to:
  /// **'Finalizar'**
  String get finish;

  /// No description provided for @start.
  ///
  /// In pt, this message translates to:
  /// **'Iniciar'**
  String get start;

  /// No description provided for @sureStartNewJourney.
  ///
  /// In pt, this message translates to:
  /// **'Tem certeza que deseja iniciar uma nova jornada?'**
  String get sureStartNewJourney;

  /// No description provided for @previousJourneyStillRunning.
  ///
  /// In pt, this message translates to:
  /// **'A jornada anterior ainda está em andamento. Se prosseguir, a marcação de finalização deverá ser inserida de forma manual posteriormente.'**
  String get previousJourneyStillRunning;

  /// No description provided for @finishJourney.
  ///
  /// In pt, this message translates to:
  /// **'Finalizar jornada'**
  String get finishJourney;

  /// No description provided for @wantRegisterOvernight.
  ///
  /// In pt, this message translates to:
  /// **'Deseja registrar pernoite?'**
  String get wantRegisterOvernight;

  /// No description provided for @reportOvernightAfterJourney.
  ///
  /// In pt, this message translates to:
  /// **'Informe a ocorrência de pernoite para descanso após essa jornada, caso seja necessário.'**
  String get reportOvernightAfterJourney;

  /// No description provided for @registerOvernight.
  ///
  /// In pt, this message translates to:
  /// **'Registrar pernoite'**
  String get registerOvernight;

  /// No description provided for @startOf.
  ///
  /// In pt, this message translates to:
  /// **'Início de '**
  String get startOf;

  /// No description provided for @endOf.
  ///
  /// In pt, this message translates to:
  /// **'Fim de '**
  String get endOf;

  /// No description provided for @work.
  ///
  /// In pt, this message translates to:
  /// **'Trabalho'**
  String get work;

  /// No description provided for @abbreviatedHour.
  ///
  /// In pt, this message translates to:
  /// **'h'**
  String get abbreviatedHour;

  /// No description provided for @addOvernightButton.
  ///
  /// In pt, this message translates to:
  /// **'Adicionar pernoite'**
  String get addOvernightButton;

  /// No description provided for @overnightAddedSuccessfully.
  ///
  /// In pt, this message translates to:
  /// **'Pernoite adicionado com sucesso'**
  String get overnightAddedSuccessfully;

  /// No description provided for @overnightAddedError.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao adicionar pernoite'**
  String get overnightAddedError;

  /// No description provided for @journey.
  ///
  /// In pt, this message translates to:
  /// **'Jornada'**
  String get journey;

  /// No description provided for @cameraPermission.
  ///
  /// In pt, this message translates to:
  /// **'Câmera'**
  String get cameraPermission;

  /// No description provided for @cameraPermissionDescription.
  ///
  /// In pt, this message translates to:
  /// **'Permissão para acessar a câmera. Usamos esse recurso para conseguir capturar foto do colaborador, leitura de QR code ou para realizar o reconhecimento facial.'**
  String get cameraPermissionDescription;

  /// No description provided for @gpsPermission.
  ///
  /// In pt, this message translates to:
  /// **'GPS'**
  String get gpsPermission;

  /// No description provided for @gpsPermissionDescription.
  ///
  /// In pt, this message translates to:
  /// **'Permissão para acessar o GPS. Usamos esse recurso para identificar o local que as marcações são registradas.'**
  String get gpsPermissionDescription;

  /// No description provided for @nfcPermission.
  ///
  /// In pt, this message translates to:
  /// **'NFC'**
  String get nfcPermission;

  /// No description provided for @nfcPermissionDescription.
  ///
  /// In pt, this message translates to:
  /// **'Recurso de NFC, usamos esse recurso quando o modo aproximação esta ativo pelo empregador para conseguir realizar os registro das marcações.'**
  String get nfcPermissionDescription;

  /// No description provided for @deviceConfigurationPermission.
  ///
  /// In pt, this message translates to:
  /// **'Permissões do dispositivo'**
  String get deviceConfigurationPermission;

  /// No description provided for @privacyCenter.
  ///
  /// In pt, this message translates to:
  /// **'Central de privacidade'**
  String get privacyCenter;

  /// No description provided for @privacyPolicies.
  ///
  /// In pt, this message translates to:
  /// **'Políticas de privacidade'**
  String get privacyPolicies;

  /// No description provided for @info.
  ///
  /// In pt, this message translates to:
  /// **'Informações'**
  String get info;

  /// No description provided for @viewDate.
  ///
  /// In pt, this message translates to:
  /// **'Data de visualização'**
  String get viewDate;

  /// No description provided for @facialRegistrationCompleted.
  ///
  /// In pt, this message translates to:
  /// **'Marcação realizada'**
  String get facialRegistrationCompleted;

  /// No description provided for @facialCaceledRegistration.
  ///
  /// In pt, this message translates to:
  /// **'Marcação cancelada'**
  String get facialCaceledRegistration;

  /// No description provided for @facialRegistering.
  ///
  /// In pt, this message translates to:
  /// **'Aguarde...'**
  String get facialRegistering;

  /// No description provided for @facialCollaboratorNotFound.
  ///
  /// In pt, this message translates to:
  /// **'Colaborador não encontrado ou inativo'**
  String get facialCollaboratorNotFound;

  /// No description provided for @noFaceRegistered.
  ///
  /// In pt, this message translates to:
  /// **'Nenhum rosto cadastrado'**
  String get noFaceRegistered;

  /// No description provided for @offlineFeatureUnavailable.
  ///
  /// In pt, this message translates to:
  /// **'Esta funcionalidade não está disponível enquanto estiver offline. Verifique sua conexão.'**
  String get offlineFeatureUnavailable;

  /// No description provided for @titleNotifications.
  ///
  /// In pt, this message translates to:
  /// **'Notificações'**
  String get titleNotifications;

  /// No description provided for @notificationErrorNextPage.
  ///
  /// In pt, this message translates to:
  /// **'Ocorreu um erro ao carregar as próximas notificações. Toque em Repetir para tentar novamente.'**
  String get notificationErrorNextPage;

  /// No description provided for @repeat.
  ///
  /// In pt, this message translates to:
  /// **'Repetir'**
  String get repeat;

  /// No description provided for @notificationErrorState.
  ///
  /// In pt, this message translates to:
  /// **'Não foi possível obter suas notificações'**
  String get notificationErrorState;

  /// No description provided for @notificationErrorStateDescription.
  ///
  /// In pt, this message translates to:
  /// **'O sistema apresentou um erro interno e, por isso, não foi possível recuperar suas notificações. Aguarde alguns instantes e para repetir esta ação, toque em Tentar novamente.'**
  String get notificationErrorStateDescription;

  /// No description provided for @notificationNotReceivedTitle.
  ///
  /// In pt, this message translates to:
  /// **'Você ainda não recebeu notificações.'**
  String get notificationNotReceivedTitle;

  /// No description provided for @notificationNotReceivedDescription.
  ///
  /// In pt, this message translates to:
  /// **'Quando você receber uma notificação, ela ficará disponível aqui para consulta.'**
  String get notificationNotReceivedDescription;

  /// No description provided for @latestNotifications.
  ///
  /// In pt, this message translates to:
  /// **'Últimas notificações'**
  String get latestNotifications;

  /// No description provided for @optionCancel.
  ///
  /// In pt, this message translates to:
  /// **'Cancelar'**
  String get optionCancel;

  /// No description provided for @errorMarkNotificationAsRead.
  ///
  /// In pt, this message translates to:
  /// **'Ocorreu um erro ao marcar sua notificação como lida. Toque em Repetir para tentar novamente.'**
  String get errorMarkNotificationAsRead;

  /// No description provided for @featureIsNotAvailableOffline.
  ///
  /// In pt, this message translates to:
  /// **'Esta funcionalidade não está disponível enquanto estiver offline. Verifique sua conexão.'**
  String get featureIsNotAvailableOffline;

  /// No description provided for @selectItem.
  ///
  /// In pt, this message translates to:
  /// **'Selecionar'**
  String get selectItem;

  /// No description provided for @facialMsgStatusVeryBlurryImage.
  ///
  /// In pt, this message translates to:
  /// **'A foto está fora de foco ou o rosto está em movimento. Tente novamente.'**
  String get facialMsgStatusVeryBlurryImage;

  /// No description provided for @facialMsgStatusMoreThanOneFaceFoundInTheImage.
  ///
  /// In pt, this message translates to:
  /// **'Somente um rosto deve aparecer na foto de cadastro.'**
  String get facialMsgStatusMoreThanOneFaceFoundInTheImage;

  /// No description provided for @facialMsgStatusFacesNotFoundInTheImage.
  ///
  /// In pt, this message translates to:
  /// **'Nenhum rosto foi encontrado com aparecimento suficiente na imagem. Tente novamente.'**
  String get facialMsgStatusFacesNotFoundInTheImage;

  /// No description provided for @facialMsgStatusNonFrontalFace.
  ///
  /// In pt, this message translates to:
  /// **'Posicione o rosto de forma frontal e olhe diretamente para a câmera.'**
  String get facialMsgStatusNonFrontalFace;

  /// No description provided for @facialMsgStatusPoorQualityImage.
  ///
  /// In pt, this message translates to:
  /// **'A imagem tem baixa resolução, ruído ou iluminação inadequada.'**
  String get facialMsgStatusPoorQualityImage;

  /// No description provided for @facialMsgStatusVerySmallFaceInTheImage.
  ///
  /// In pt, this message translates to:
  /// **'Aproxime mais seu rosto da câmera.'**
  String get facialMsgStatusVerySmallFaceInTheImage;

  /// No description provided for @facialMsgStatusFaceTooCloseToTheEdgeOfTheImage.
  ///
  /// In pt, this message translates to:
  /// **'Centralize o rosto na tela e tente novamente.'**
  String get facialMsgStatusFaceTooCloseToTheEdgeOfTheImage;

  /// No description provided for @facialMsgStatusEvidenceOfFraud.
  ///
  /// In pt, this message translates to:
  /// **'A imagem não atendeu aos requisitos de autenticidade. Tente novamente.'**
  String get facialMsgStatusEvidenceOfFraud;

  /// No description provided for @facialMsgStatusIdsWithCloseImagesWereFound.
  ///
  /// In pt, this message translates to:
  /// **'O rosto parece semelhante a outra pessoa na base de dados. Evite duplicidade cadastral.'**
  String get facialMsgStatusIdsWithCloseImagesWereFound;

  /// No description provided for @facialMsgStatusGlassesDetectedOrTooMuchEyeShadow.
  ///
  /// In pt, this message translates to:
  /// **'Remova os óculos ou ajuste a iluminação para evitar sombras nos olhos.'**
  String get facialMsgStatusGlassesDetectedOrTooMuchEyeShadow;

  /// No description provided for @facialMsgStatusLowConfidenceFaceDetection.
  ///
  /// In pt, this message translates to:
  /// **'O sistema não conseguiu detectar um rosto com confiança suficiente. Tente novamente.'**
  String get facialMsgStatusLowConfidenceFaceDetection;

  /// No description provided for @facialTitleStatusVeryBlurryImage.
  ///
  /// In pt, this message translates to:
  /// **'Imagem muito borrada'**
  String get facialTitleStatusVeryBlurryImage;

  /// No description provided for @facialTitleStatusMoreThanOneFaceFoundInTheImage.
  ///
  /// In pt, this message translates to:
  /// **'Mais de um rosto detectado'**
  String get facialTitleStatusMoreThanOneFaceFoundInTheImage;

  /// No description provided for @facialTitleStatusFacesNotFoundInTheImage.
  ///
  /// In pt, this message translates to:
  /// **'Rosto não detectado'**
  String get facialTitleStatusFacesNotFoundInTheImage;

  /// No description provided for @facialTitleStatusNonFrontalFace.
  ///
  /// In pt, this message translates to:
  /// **'Rosto fora de posição'**
  String get facialTitleStatusNonFrontalFace;

  /// No description provided for @facialTitleStatusPoorQualityImage.
  ///
  /// In pt, this message translates to:
  /// **'Imagem com baixa qualidade'**
  String get facialTitleStatusPoorQualityImage;

  /// No description provided for @facialTitleStatusVerySmallFaceInTheImage.
  ///
  /// In pt, this message translates to:
  /// **'Rosto pequeno na imagem'**
  String get facialTitleStatusVerySmallFaceInTheImage;

  /// No description provided for @facialTitleStatusFaceTooCloseToTheEdgeOfTheImage.
  ///
  /// In pt, this message translates to:
  /// **'Rosto próximo à borda'**
  String get facialTitleStatusFaceTooCloseToTheEdgeOfTheImage;

  /// No description provided for @facialTitleStatusEvidenceOfFraud.
  ///
  /// In pt, this message translates to:
  /// **'Possível fraude detectada'**
  String get facialTitleStatusEvidenceOfFraud;

  /// No description provided for @facialTitleStatusIdsWithCloseImagesWereFound.
  ///
  /// In pt, this message translates to:
  /// **'Similaridade com outros rostos'**
  String get facialTitleStatusIdsWithCloseImagesWereFound;

  /// No description provided for @facialTitleStatusGlassesDetectedOrTooMuchEyeShadow.
  ///
  /// In pt, this message translates to:
  /// **'Óculos ou sombras nos olhos'**
  String get facialTitleStatusGlassesDetectedOrTooMuchEyeShadow;

  /// No description provided for @facialTitleStatusLowConfidenceFaceDetection.
  ///
  /// In pt, this message translates to:
  /// **'Baixa confiança na face'**
  String get facialTitleStatusLowConfidenceFaceDetection;

  /// No description provided for @privacy_police_change.
  ///
  /// In pt, this message translates to:
  /// **'Atualizamos a nossa política de privacidade'**
  String get privacy_police_change;

  /// No description provided for @privacy_police_change_subtitle.
  ///
  /// In pt, this message translates to:
  /// **'Clique para visualizar ou consulte a qualquer momento no menu Configurações > Política de privacidade.'**
  String get privacy_police_change_subtitle;

  /// No description provided for @reRegisterApplicationKey.
  ///
  /// In pt, this message translates to:
  /// **'Consultar chave de aplicação'**
  String get reRegisterApplicationKey;

  /// No description provided for @errorAuthenticatingApplicationKey.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao autenticar chave de aplicação.'**
  String get errorAuthenticatingApplicationKey;

  /// No description provided for @authenticating.
  ///
  /// In pt, this message translates to:
  /// **'Autenticando...'**
  String get authenticating;

  /// No description provided for @authenticationFailure.
  ///
  /// In pt, this message translates to:
  /// **'Falha de Autenticação'**
  String get authenticationFailure;

  /// No description provided for @errorWhileAuthenticatingApplicationKey.
  ///
  /// In pt, this message translates to:
  /// **'Ocorreu um erro ao autenticar a chave de aplicação cadastrada neste dispositivo.'**
  String get errorWhileAuthenticatingApplicationKey;

  /// No description provided for @recognitionBlocked.
  ///
  /// In pt, this message translates to:
  /// **'Reconhecimento bloqueado, aguarde'**
  String get recognitionBlocked;

  /// No description provided for @secondsFullName.
  ///
  /// In pt, this message translates to:
  /// **'segundos'**
  String get secondsFullName;

  /// No description provided for @totalTimeSinceLastJourney.
  ///
  /// In pt, this message translates to:
  /// **'Tempo desde a última jornada'**
  String get totalTimeSinceLastJourney;

  /// No description provided for @userNameScreenTitle.
  ///
  /// In pt, this message translates to:
  /// **'Entrar com credenciais'**
  String get userNameScreenTitle;
}

class _CollectorLocalizationsDelegate extends LocalizationsDelegate<CollectorLocalizations> {
  const _CollectorLocalizationsDelegate();

  @override
  Future<CollectorLocalizations> load(Locale locale) {
    return SynchronousFuture<CollectorLocalizations>(lookupCollectorLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_CollectorLocalizationsDelegate old) => false;
}

CollectorLocalizations lookupCollectorLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return CollectorLocalizationsEn();
    case 'es': return CollectorLocalizationsEs();
    case 'pt': return CollectorLocalizationsPt();
  }

  throw FlutterError(
    'CollectorLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
