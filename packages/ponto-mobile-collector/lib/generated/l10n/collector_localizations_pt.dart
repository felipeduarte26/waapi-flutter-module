import 'collector_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class CollectorLocalizationsPt extends CollectorLocalizations {
  CollectorLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Marcação de Ponto Senior';

  @override
  String get helloWorld => 'Olá Mundo!';

  @override
  String get dateFormatClock => 'd \'de\' MMMM \'de\' y';

  @override
  String get share => 'Compartilhar';

  @override
  String get close => 'Fechar';

  @override
  String get appointmentReceipt => 'Comprovante de marcação';

  @override
  String get cardReceiptData => 'Data';

  @override
  String get cardReceiptTime => 'Horário';

  @override
  String get cardReceiptZone => 'Fuso';

  @override
  String get cardReceiptEmployeeName => 'Colaborador';

  @override
  String get cardReceiptEmployeeCPF => 'CPF';

  @override
  String get cardReceiptCompanyName => 'Empresa';

  @override
  String get cardReceiptCompanyCNPJ => 'CNPJ';

  @override
  String get cardReceiptIdentification => 'Identificação da Marcação';

  @override
  String get hoursWorked => 'Horas trabalhadas hoje';

  @override
  String get breaks => 'Intervalos';

  @override
  String get lastClockingevent => 'Última marcação';

  @override
  String get lastClockingevents => 'Últimas marcações';

  @override
  String get breakTime => 'Intervalo de %t';

  @override
  String get whenRegistered => 'Quando registrar, elas aparecerão aqui';

  @override
  String get todaysClockinEvents => 'Marcações de hoje';

  @override
  String get noClockingEvents => 'Não há marcações registradas hoje';

  @override
  String get loading => 'Carregando...';

  @override
  String get deviceSituation => 'Situação do dispositivo';

  @override
  String get goToLogin => 'Sair';

  @override
  String get deviceAuthorizationIsPending => 'A função de Ponto não está ativada para este dispositivo devido à autorização pendente do RH.';

  @override
  String get deviceAuthorizationWasRejected => 'A função de Ponto não está ativada para este dispositivo devido à autorização rejeitada pelo RH.';

  @override
  String get deviceActivationIsPending => 'A função de Ponto não está ativada para este dispositivo devido à ativação pendente do RH.';

  @override
  String get deviceActivationWasRejected => 'A função de Ponto não está ativada para este dispositivo devido à ativação rejeitada pelo RH.';

  @override
  String get clockingEventSingleNotAvailable => 'A Marcação de ponto não está disponível para o modo individual para o seu usuário';

  @override
  String get contactRh => 'Por favor, contate o RH ou se dirija a um dispositivo coletivo para registrar o ponto.';

  @override
  String get clockingEvents => 'Marcações';

  @override
  String rangeDate(String fromDate, String toDate) {
    return '$fromDate até $toDate';
  }

  @override
  String get menuItemHome => 'Início';

  @override
  String get menuItemAppointment => 'Marcações';

  @override
  String get menuItemTime => 'Horas';

  @override
  String get menuItemProfile => 'Perfil';

  @override
  String get clockingEventTitle => 'Ponto';

  @override
  String get clockingEventGoodMorning => 'Bom dia';

  @override
  String get clockingEventGoodAfternoon => 'Boa tarde';

  @override
  String get clockingEventGoodEvening => 'Boa noite';

  @override
  String get clockingEventCaptureTime => 'Registrar ponto';

  @override
  String get clockingEventCapturingTime => 'Realizando marcação';

  @override
  String get clockingEventKeepButtonPressedToRegister => 'Mantenha o botão pressionado para registrar';

  @override
  String get clockingEventAppointmentMade => 'Marcação Realizada';

  @override
  String get clockingEventSeeReceipt => 'Ver comprovante';

  @override
  String get withoutClockingEvents => 'Sem marcações';

  @override
  String get dateFormatter => 'dd/MM/yyyy';

  @override
  String get period => 'Período';

  @override
  String get oddClockingEvent => 'Marcações ímpares';

  @override
  String get periodClockingEvent => 'Marcações do período';

  @override
  String lastUpdate(String date, String hour) {
    return 'Última atualização $date às $hour';
  }

  @override
  String get clockInfoTitle1 => 'Marcação não sincronizada';

  @override
  String get clockInfoDescription1 => 'São marcações que foram registradas e serão sincronizadas assim que houver conexão com a internet.';

  @override
  String get clockInfoTitle2 => 'Origem via celular e plataforma';

  @override
  String get clockInfoDescription2 => 'São marcações que foram registradas via aplicativo e plataforma. São categorizadas como marcação cross.';

  @override
  String get clockInfoTitle3 => 'Origem via celular';

  @override
  String get clockInfoDescription3 => 'São marcações que foram registradas via aplicativo tanto Ponto quanto Waapi.';

  @override
  String get clockInfoTitle4 => 'Origem via plataforma';

  @override
  String get clockInfoDescription4 => 'São marcações que foram registradas via plataforma.';

  @override
  String get clockInfoTitle5 => 'Marcação manual';

  @override
  String get clockInfoDescription5 => 'Marcações registradas manualmente pelo gestor ou colaborador através do app ou plataforma.';

  @override
  String get clockInfoTitle6 => 'Marcações ímpares';

  @override
  String get clockInfoDescription6 => 'Significa que falta uma marcação para sua jornada ficar completa, porém ela pode ter sido realizada em outro registrador de ponto.';

  @override
  String get clockInfoTitle7 => 'Marcações com afastamento';

  @override
  String get clockInfoDescription7 => 'São marcações que possuem algum afastamento lançado na jornada.';

  @override
  String get infoUnderstoodButton => 'Entendi';

  @override
  String get registerCameraButton => 'Registrar';

  @override
  String get clockingsOfTheDay => 'Marcações do dia';

  @override
  String get addClocking => 'Adicionar marcação';

  @override
  String get timeControlManagement => 'Gestão do Ponto';

  @override
  String get centralizingJourney => 'Centralizando a jornada do colaborador';

  @override
  String get haveControl => 'Tenha o controle da sua jornada do ponto.';

  @override
  String get shortcutsTimeControl => 'Atalhos para o Gestão do Ponto';

  @override
  String get recentClockingEventMessage => 'Você marcou o ponto há menos de 2 minutos. Deseja realizar outra marcação?';

  @override
  String get outsideTheFenceMessage => 'A localização atual está fora do perímetro definido pelo seu empregador. Deseja continuar?';

  @override
  String get alert => 'Atenção';

  @override
  String get yes => 'Sim';

  @override
  String get no => 'Não';

  @override
  String get confirmAppointment => 'Confirmar marcação';

  @override
  String get cancelAppointment => 'Não realizar marcação';

  @override
  String get hoursWorkedTodayInfo => 'A quantidade de horas é calculada quando existem marcações em pares (entrada e saída), portanto o total é atualizado apenas ao registrar o fim de um período.';

  @override
  String get syncClockingEventSyncSuccess => 'Sincronização concluída.';

  @override
  String get syncClockingEventSyncInternetUnavailable => 'Sincronização não concluída. Verifique sua conexão com a internet.';

  @override
  String get syncClockingEventSyncFailure => 'Desculpe, ocorreu uma falha na sincronização. Tente novamente.';

  @override
  String get syncClockingEventSyncPartialSuccess => 'Sincronização concluída parcialmente. Alguns registros não foram sincronizados. Verifique sua conexão com a internet e tente novamente.';

  @override
  String get configurations => 'Configurações';

  @override
  String get completedAppointments => 'Marcações registradas';

  @override
  String get setKey => 'Configurar chave da aplicação';

  @override
  String get permissions => 'Permissões';

  @override
  String get syncAppointInfo => 'Sincronizar informações do ponto';

  @override
  String get resources => 'Recursos';

  @override
  String get facialRecognitionRegistration => 'Cadastro de reconhecimento facial';

  @override
  String get facialRecognitionRegistrationDescription => 'Cadastrar reconhecimento facial de um novo colaborador';

  @override
  String get readWebQRCode => 'Ler QRcode WEB';

  @override
  String get readWebQRCodeDescription => 'Usar dispositivo para cadastrar reconhecimento facial de um novo colaborador';

  @override
  String get othersResources => 'Outros';

  @override
  String get help => 'Ajuda';

  @override
  String get helpCenter => 'Central de ajuda';

  @override
  String get viewTourAgain => 'Visualizar tour novamente';

  @override
  String get privacyPolicy => 'Política de privacidade';

  @override
  String get about => 'Sobre';

  @override
  String get signOut => 'Sair';

  @override
  String get clockingEventNotAvailable => 'A marcação de ponto não está disponível para seu usuário.';

  @override
  String get descriptionClockingEventNotAvailable => 'Por favor, aguarde ou contate o RH para obter mais informações.';

  @override
  String get toView => 'Visualizar';

  @override
  String successClockingEvent(String hour, String date, String name) {
    return 'Marcação realizada às $hour no dia $date para $name';
  }

  @override
  String get configurationReminders => 'Configurar lembretes do ponto';

  @override
  String get configurationNotifications => 'Configurar notificações';

  @override
  String get configurationRegisteredClock => 'Marcações registradas';

  @override
  String get configurationReports => 'Relatórios';

  @override
  String get configurationAppReview => 'Avaliação do aplicativo';

  @override
  String get configurationSearch => 'Pesquisa';

  @override
  String get configurationViewTourAgain => 'Visualizar tour novamente';

  @override
  String get configurationSynchronizationSuccessfully => 'Sincronização realizada com sucesso.';

  @override
  String get configurationSynchronizationError => 'Não foi possível sincronizar as informações do ponto no momento. Tente novamente mais tarde.';

  @override
  String get hoursTitle => 'Totalizador de horas';

  @override
  String get hoursTabTitle1 => 'Jornada do dia';

  @override
  String get hoursTabTitle2 => 'Saldo';

  @override
  String get hoursTabTitle3 => 'Espelho';

  @override
  String get facialTryAgain => 'Tentar novamente';

  @override
  String get facialRegistrationCompletedSuccessfully => 'Cadastro realizado com sucesso!';

  @override
  String get facialBackStart => 'Voltar ao início';

  @override
  String get facialPerformingPhotoAnalysis => 'Realizando análise da foto...';

  @override
  String get facialLooksLikeAreOffline => 'Sem conexão com a internet';

  @override
  String get facialRegistrationOnlineCheckConnection => 'O cadastramento inicial deve ser feito conectado à internet. Verifique sua conexão e tente novamente.';

  @override
  String get facialCheckingInformation => 'Verificando informações...';

  @override
  String get facialTipsFacialRecognition => 'Dicas para o reconhecimento facial';

  @override
  String get facialFollowInstructionsCapture => 'Siga as instruções para uma boa captura';

  @override
  String get facialPositionCellPhoneEyeCamera => 'Posicione o celular na altura dos seus olhos e olhe diretamente para a câmera;';

  @override
  String get facialBeBrightEnvironmentPeopleBackground => 'Esteja em um ambiente iluminado, sem pessoas e objetos ao fundo;';

  @override
  String get facialAvoidWearingAccessoriesGlasses => 'Evite usar acessórios que escondam seu rosto, como óculos, bonés, máscaras e chapéus;';

  @override
  String get facialAvoidShakingYourCellPhone => 'Evite tremer o seu celular durante a captura;';

  @override
  String get facialAvoidMakingFacesOrExpressions => 'Evite fazer caretas ou expressões que possam interferir na qualidade da captura;';

  @override
  String get facialIfNecessaryAskHelpCamera => 'Se achar necessário, peça ajuda a outra pessoa e ative a câmera traseira do seu celular.';

  @override
  String get facialStartReconnaissance => 'Iniciar reconhecimento';

  @override
  String get facialPhotoCapture => 'Captura de foto';

  @override
  String get facialPositionFaceToCapture => 'Posicione o rosto para capturar';

  @override
  String get facialFacialRecognition => 'Reconhecimento facial';

  @override
  String get facialFacialRecognitionMultiMode => 'Registrar por rosto';

  @override
  String get recognitionMultiModeInProgress => 'Aguarde...';

  @override
  String get recognitionMultiModeDoSync => 'Não encontramos nenhuma face cadastrada. Realize o cadastramento de faces ou sincronização para prosseguir com a marcação.';

  @override
  String get facialModalAlertTitle => 'Tem certeza que deseja registrar sem reconhecimento da face?';

  @override
  String get facialModalAlertTryOtherWay => 'Tentar outra forma';

  @override
  String get facialModalAlertTryOtherWayDescription => 'Caso não consigo realizar o registro por reconhecimento facial tente outra forma para registrar sua marcação';

  @override
  String get facialModalAlertContent => 'A marcação de ponto será realizada sem registro do reconhecimento facial.';

  @override
  String get facialModalAlertBackButton => 'Voltar';

  @override
  String get facialModalAlertProceedButton => 'Registrar sem face';

  @override
  String get facialInitTechnologyTitle => 'Inicializando tecnologia';

  @override
  String get facialInitTechnologyContent => 'Enquanto é iniciada a tecnologia de reconhecimento facial, a marcação de ponto será feita sem a identificação de face.';

  @override
  String get facialRecognitionRegistrationQuestion => 'Realizar o cadastro de reconhecimento facial?';

  @override
  String get facialRecognitionRegistrationInformation => 'Você ainda não cadastrou seu rosto para registro do ponto com reconhecimento facial. Cadastre agora e garanta mais segurança e agilidade dos seus dados.';

  @override
  String get facialRegisterNow => 'Cadastrar agora';

  @override
  String get facialCouldNotanalyzePhoto => 'Não foi possível analisar a foto';

  @override
  String get facialTryAgainLater => 'Tente novamente ou aguarde alguns instantes para repetir a ação.';

  @override
  String get facialNotIdentifiedFace => 'Rosto não identificado';

  @override
  String get facialLowQualityPhoto => 'A foto está com baixa qualidade ou desfocada.';

  @override
  String get facialFaceIsntVisible => 'Certifique-se de que seu rosto esteja visível e dentro do enquadramento e tente novamente.';

  @override
  String get facialRecognitionRegistrationSoonAvailable => 'Dentro de alguns minutos a marcação por reconhecimento facial já estará disponível para você.';

  @override
  String get facialFaceAlreadyRegistered => 'Rosto já cadastrado!';

  @override
  String get facialRecognitionRegistrationAvailable => 'A marcação por reconhecimento facial já está disponível.';

  @override
  String get facialRecognitionRegistrationEmployee => 'Cadastro reconhecimento facial';

  @override
  String get facialSelectEmployeeTitle => 'Selecione o colaborador que deseja cadastrar o reconhecimento facial';

  @override
  String get enterRrSearchForTheCollaborator => 'Digite ou busque o colaborador';

  @override
  String get employeeList => 'Lista de colaboradores';

  @override
  String get continueText => 'Continuar';

  @override
  String get collaborator => 'Colaborador';

  @override
  String get userWithoutPermission => 'Usuário sem permissão';

  @override
  String get userWithoutPermissionDescription => 'Por favor, contate o RH para verificar a permissão do seu usuário.';

  @override
  String get unresponsiveService => 'Serviço sem resposta';

  @override
  String get unresponsiveServiceDescription => 'Não foi possivel estabelecer uma conexão com o serviço de marcação de ponto.';

  @override
  String get facialUserNoPermissionTitle => 'Usuário sem permissão';

  @override
  String get facialUserNoPermissionMessage => 'Por favor, contate o RH para verificar a permissão do seu usuário.';

  @override
  String get registerWithoutConfirm => 'Tem certeza que deseja registrar sem a confirmação?';

  @override
  String get willRegisterWithoutPhoto => 'O registro de ponto será realizado sem a confirmação de foto.';

  @override
  String get registerWithoutPhoto => 'Registrar sem foto';

  @override
  String get reRegister => 'Recadastrar';

  @override
  String get permissionCameraNotAllowedMessage => 'Para utilizar o reconhecimento facial e captura de foto após marcação, é necessário permitir acesso à câmera do dispositivo. Essa informação não é obrigatória, mas complementa seu registro.';

  @override
  String get permissionLocationNotAllowedMessage => 'Recomendamos adicionar o local à sua marcação de ponto, para isso é necessário permitir acesso à localização do dispositivo. Essa informação não é obrigatória, mas complementa seu registro.';

  @override
  String get goToConfiguration => 'Permissões';

  @override
  String get continueAction => 'Continuar';

  @override
  String get deviceSettings => 'Configurações do dispositivo';

  @override
  String get setPushNotification => 'Configurar notificações por push';

  @override
  String get appReview => 'Avaliação do aplicativo';

  @override
  String get searchApp => 'Pesquisa';

  @override
  String get applicationKeyHelpTitle => 'Entenda a configuração de chave para o dispositivo móvel';

  @override
  String get applicationKeyHelpContent1 => 'Cadastre a chave de aplicação na Plataforma Senior X';

  @override
  String get applicationKeyHelpContent2 => 'Adicione as informações de chave e segredo para a aplicação cadastrada, que será responsável pela comunicação da Plataforma Senior X com o Marcação de Ponto 2.0;';

  @override
  String get applicationKeyHelpContent3 => 'Se você tem certeza de que as informações estão corretas e ainda estiver enfrentando problemas para entrar no aplicativo, verifique com o RH da sua empresa.';

  @override
  String get keyAlreadyRegistered => 'Chave já cadastrada!';

  @override
  String get registerNewkey => 'Registrar nova chave';

  @override
  String get keyAlreadyRegisteredDescription => 'Você pode remover a chave com a ação abaixo.';

  @override
  String get keyAlreadyRegisteredRemove => 'Remover chave';

  @override
  String get helpTextDocumentationPortal => 'Portal de documentação';

  @override
  String get keyRegisteredSuccessfully => 'Chave cadastrada com sucesso!';

  @override
  String get keyRegisteredSuccessfullyDescription => 'Os recursos estarão disponíveis para uso na home.';

  @override
  String get keyRegisteredSuccessfullyBackHome => 'Voltar ao início';

  @override
  String get searchEmployee => 'Buscar colaborador';

  @override
  String get selectPeriodToFilter => 'Selecione um período para filtrar';

  @override
  String get change => 'Trocar';

  @override
  String get init => 'Inicial';

  @override
  String get end => 'Final';

  @override
  String get filter => 'Filtrar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get invalidDate => 'Data inválida';

  @override
  String get invalidDateFormat => 'Formato da data inválido';

  @override
  String get moreThanEndDate => 'Maior que a data final';

  @override
  String get lessThanStartDate => 'Menor que a data inicial';

  @override
  String get driversJourney => 'Jornada do motorista';

  @override
  String get workStatus => 'Status de trabalho';

  @override
  String get notStarted => 'Não iniciado';

  @override
  String get working => 'Trabalhando';

  @override
  String get driving => 'Dirigindo';

  @override
  String get mandatoryBreak => 'Pausa obrigatória';

  @override
  String get foodTime => 'Intervalo';

  @override
  String get waiting => 'Espera';

  @override
  String get actions => 'Ações';

  @override
  String get startDrivingWithLineBreak => 'Iniciar\ndireção';

  @override
  String get startMandatoryBreakWithLineBreak => 'Iniciar pausa\nobrigatória';

  @override
  String get startWaitingWithLineBreak => 'Iniciar\nespera';

  @override
  String get startFoodTimeWithLineBreak => 'Iniciar\nintervalo';

  @override
  String get startJourney => 'Iniciar jornada';

  @override
  String get newJourney => 'Nova jornada';

  @override
  String get stopDriving => 'Encerrar direção';

  @override
  String get stopMandatoryBreak => 'Encerrar pausa';

  @override
  String get stopFoodTime => 'Encerrar intervalo';

  @override
  String get stopWaiting => 'Encerrar espera';

  @override
  String get journeyStart => 'Início da jornada';

  @override
  String get numberOfPauses => 'Número de pausas';

  @override
  String get totalWorked => 'Total trabalhado';

  @override
  String get totalWorkedInfo => 'Tempo atualizado do total trabalhado do início da jornada até o momento. Não inclui pausas obrigatórias e refeições. Caso o valor total esteja zerado e vermelho, significa que a jornada contém marcações impares.';

  @override
  String get timeInWorking => 'Tempo trabalhando';

  @override
  String get timeInDriving => 'Tempo dirigindo';

  @override
  String get timeInMandatoryBreak => 'Tempo em pausa obrigatória';

  @override
  String get timeInFoodTime => 'Tempo em intervalo';

  @override
  String get timeInWaiting => 'Tempo em espera';

  @override
  String get hours => 'horas';

  @override
  String get minutes => 'min';

  @override
  String get seconds => 'seg';

  @override
  String get workingStatusDescription => 'Jornada de trabalho decorrida desde o início da jornada, independente dos status específicos que foram registrados.';

  @override
  String get deviceLocation => 'Localização do dispositivo';

  @override
  String get deviceLocationDescription => 'Permite determinar a localização geográfica do dispositivo no momento das marcações.';

  @override
  String get drive => 'Direção';

  @override
  String get drivingStatusDescription => 'Tempo de condução do veículo durante a jornada do dia.';

  @override
  String get mandatoryBreakStatusDescription => 'A pausa obrigatória é importante para prevenir a fadiga e assegurar viagens mais seguras, é contado como parte da sua jornada.';

  @override
  String get foodTimeOrBreaks => 'Refeição ou intervalos';

  @override
  String get foodTimeStatusDescription => 'Assim como a pausa, os intervalos principais para refeição são importantes para evitar cansaço e fadiga. Esses intervalos não contam como tempo trabalhado.';

  @override
  String get waitingTime => 'Tempo de espera';

  @override
  String get waitingStatusDescription => 'Os períodos de espera indicam um período sem movimento do veículo, mas que necessitam do acompanhamento do motorista, como fila de balança, carga e descarga do caminhão, dentre outros.';

  @override
  String get overnight => 'Pernoite';

  @override
  String get overnightDescription => 'Registra a estada/pernoite durante uma viagem mais extensa para descanso entre uma jornada e outra.';

  @override
  String get paidBreak => 'Pausa abonada';

  @override
  String get paidBreakStatusDescription => 'Este intervalo é considerado como tempo de trabalho e, portanto, não resulta em redução do salário do empregado.';

  @override
  String get mainTimeClocking => 'Marcação de ponto';

  @override
  String get mainTimeClockingDescription => 'Marcações de ponto (de entrada ou saída) registradas.';

  @override
  String get hoursWorkedInfo => 'Total atualizado ao registrar entrada e saída. Inclui tempo de trabalho, direção e espera.';

  @override
  String get timeInBreaks => 'Tempo em pausas';

  @override
  String get breaksInfo => 'Total atualizado ao registrar início e fim. Inclui pausas obrigatórias e refeição.';

  @override
  String get moreDetails => 'Mais detalhes';

  @override
  String betweenTimes(String startTime, String endTime, String totalTime) {
    return 'De $startTime até $endTime, total de $totalTime';
  }

  @override
  String get totalsOfTheDay => 'Totalizadores do dia';

  @override
  String get foodTimeStatusDescriptionModal => 'O intervalo dentro de uma jornada é destinado, normalmente, para refeições, mas também é muito importante para evitar fadiga. Em algumas jornadas podem existir mais de um intervalo.';

  @override
  String get wasThisInformationHelpful => 'Esta informação foi útil?';

  @override
  String get enableLogs => 'Ativar logs';

  @override
  String get disableLogs => 'Desativar logs';

  @override
  String get logsDisabled => 'Logs desativados';

  @override
  String get logsEnabled => 'Logs ativados';

  @override
  String get sendLogs => 'Enviar logs';

  @override
  String get successfulSyncLogs => 'Sucesso ao sincronizar os logs';

  @override
  String get partialSuccessSyncLogs => 'Sucesso parcial ao sincronizar os logs';

  @override
  String get faliedSyncLogs => 'Falha ao sincronizar os logs';

  @override
  String get unexpectedErrorSyncLogs => 'Erro inesperado ao sincronizar os logs';

  @override
  String get notLogsToSync => 'Não existem logs para sincronizar';

  @override
  String get aboutScreenAppTitle => 'Aplicativo';

  @override
  String get aboutScreenVersion => 'Versão';

  @override
  String get aboutScreenDeviceTitle => 'Dispositivo';

  @override
  String get aboutScreenIdentifier => 'Identificador';

  @override
  String get aboutScreenModel => 'Modelo';

  @override
  String get aboutScreenName => 'Nome';

  @override
  String get aboutScreenDevelopedBy => 'Desenvolvido por';

  @override
  String get removeFilter => 'Limpar';

  @override
  String get checkConnectivityForKeys => 'A chave de aplicação deve ser gerenciada de forma online. Verifique sua conexão e tente novamente.';

  @override
  String get selectTheStartingDate => 'Selecione a data de início';

  @override
  String get selectTheEndDate => 'Selecione a data final';

  @override
  String reminderClockingEventMessageIntraJourney(Object reminderTime) {
    return 'Você marcou o ponto há menos de $reminderTime. No intervalo para descanso e refeição importante completar o período mínimo antes de retornar ao trabalho.';
  }

  @override
  String reminderClockingEventMessageInterJourney(Object reminderTime) {
    return 'Você marcou o ponto há menos de $reminderTime. No intervalo para descanso entre jornadas é importante completar o período mínimo antes de retornar ao trabalho.';
  }

  @override
  String get warning => 'Aviso';

  @override
  String get registerKeyOnSyncLogs => 'Os logs só podem ser enviados se houver uma chave de aplicação configurada';

  @override
  String get hasNoConnectivityToSync => 'Sem conexão para realizar a sincronia de dados.';

  @override
  String get unableToSyncClockingEvents => 'Não foi possível sincronizar marcações';

  @override
  String get syncUnsuccessful => 'Sincronização não sucedida';

  @override
  String reason(String reason) {
    return 'Motivo:\n$reason';
  }

  @override
  String get unsyncedClockingEvents => 'Marcações não sincronizadas';

  @override
  String get syncClockingEventsBeforeRemoveKeys => 'Existem marcações não sincronizadas. Faça a sincronização antes de remover a chave.';

  @override
  String get confirmRemoveKeys => 'Tem certeza que deseja remover?\nSerá desvinculada a conta de sua empresa e todas as informações dos colaboradores, assim como marcações, serão removidas do dispositivo.';

  @override
  String get loadingUnsyncedClockingEvents => 'Buscando marcações não sincronizadas...';

  @override
  String get verifiyngConnectivity => 'Verificando conexão com a internet...';

  @override
  String get syncingClockingEvents => 'Sincronizando marcações...';

  @override
  String get removingKeys => 'Removendo chaves...';

  @override
  String get keysNotRemoved => 'Chaves não removidas';

  @override
  String get keysRemovedUnsuccessfully => 'Não foi possível fazer a remoção completa das chaves. Tente novamente.';

  @override
  String get keysRemoved => 'Chaves removidas';

  @override
  String get keysRemovedSuccessfully => 'As chaves foram removidas com sucesso.';

  @override
  String get initJourney => 'Iniciar jornada?';

  @override
  String get initJourneyBeforeStartAction => 'Nenhuma jornada em andamento, deseja iniciar uma jornada antes de prosseguir?';

  @override
  String get initMyJourney => 'Iniciar minha jornada';

  @override
  String get manualRegistration => 'Registro manual';

  @override
  String get ok => 'Ok';

  @override
  String get continueRegistration => 'Deseja continuar o registro?';

  @override
  String get wantToStartJourney => 'Deseja iniciar jornada?';

  @override
  String startJourneyBeforeStartAction(String action) {
    return 'Ainda não foi realizada uma marcação de início de jornada. Deseja começar agora antes de registrar $action?';
  }

  @override
  String journeyStartedBeforeAction(String actionLabel) {
    return 'Jornada e $actionLabel iniciado(a) com sucesso.';
  }

  @override
  String actionStartedWithoutJourney(String actionLabel) {
    return '$actionLabel iniciado(a), mas a jornada não. Um ajuste manual deverá ser realizado posteriormente.';
  }

  @override
  String finishCurrentActionBeforeStartNextAction(String currentActionLabel, String nextActionLabel) {
    return 'Deseja finalizar $currentActionLabel antes de iniciar $nextActionLabel na sequência?';
  }

  @override
  String newActionStartedAndPreviousDoesNot(String newActionLabel, String previousActionLabel) {
    return '$newActionLabel iniciado(a) e $previousActionLabel não finalizado(a) pela aplicação. Faça o ajuste manual posteriormente, se necessário.';
  }

  @override
  String previousActionFinishedAndNewStarted(String previousActionLabel, String newActionLabel) {
    return '$previousActionLabel finalizado(a) e $newActionLabel iniciado(a) com sucesso.';
  }

  @override
  String closeActionBeforeEndJourney(String actionLabel) {
    return 'Deseja finalizar $actionLabel antes de encerrar a jornada?';
  }

  @override
  String previousActionClosedAndJourneyEnded(String actionLabel) {
    return '$actionLabel e jornada finalizada com sucesso.';
  }

  @override
  String journeyFinishedAndPreviousActionDoesNot(String actionLabel) {
    return 'Jornada finalizada, mas $actionLabel não. Um ajuste manual deverá ser realizado posteriormente.';
  }

  @override
  String get finish => 'Finalizar';

  @override
  String get start => 'Iniciar';

  @override
  String get sureStartNewJourney => 'Tem certeza que deseja iniciar uma nova jornada?';

  @override
  String get previousJourneyStillRunning => 'A jornada anterior ainda está em andamento. Se prosseguir, a marcação de finalização deverá ser inserida de forma manual posteriormente.';

  @override
  String get finishJourney => 'Finalizar jornada';

  @override
  String get wantRegisterOvernight => 'Deseja registrar pernoite?';

  @override
  String get reportOvernightAfterJourney => 'Informe a ocorrência de pernoite para descanso após essa jornada, caso seja necessário.';

  @override
  String get registerOvernight => 'Registrar pernoite';

  @override
  String get startOf => 'Início de ';

  @override
  String get endOf => 'Fim de ';

  @override
  String get work => 'Trabalho';

  @override
  String get abbreviatedHour => 'h';

  @override
  String get addOvernightButton => 'Adicionar pernoite';

  @override
  String get overnightAddedSuccessfully => 'Pernoite adicionado com sucesso';

  @override
  String get overnightAddedError => 'Erro ao adicionar pernoite';

  @override
  String get journey => 'Jornada';

  @override
  String get cameraPermission => 'Câmera';

  @override
  String get cameraPermissionDescription => 'Permissão para acessar a câmera. Usamos esse recurso para conseguir capturar foto do colaborador, leitura de QR code ou para realizar o reconhecimento facial.';

  @override
  String get gpsPermission => 'GPS';

  @override
  String get gpsPermissionDescription => 'Permissão para acessar o GPS. Usamos esse recurso para identificar o local que as marcações são registradas.';

  @override
  String get nfcPermission => 'NFC';

  @override
  String get nfcPermissionDescription => 'Recurso de NFC, usamos esse recurso quando o modo aproximação esta ativo pelo empregador para conseguir realizar os registro das marcações.';

  @override
  String get deviceConfigurationPermission => 'Permissões do dispositivo';

  @override
  String get privacyCenter => 'Central de privacidade';

  @override
  String get privacyPolicies => 'Políticas de privacidade';

  @override
  String get info => 'Informações';

  @override
  String get viewDate => 'Data de visualização';

  @override
  String get facialRegistrationCompleted => 'Marcação realizada';

  @override
  String get facialCaceledRegistration => 'Marcação cancelada';

  @override
  String get facialRegistering => 'Aguarde...';

  @override
  String get facialCollaboratorNotFound => 'Colaborador não encontrado ou inativo';

  @override
  String get noFaceRegistered => 'Nenhum rosto cadastrado';

  @override
  String get offlineFeatureUnavailable => 'Esta funcionalidade não está disponível enquanto estiver offline. Verifique sua conexão.';

  @override
  String get titleNotifications => 'Notificações';

  @override
  String get notificationErrorNextPage => 'Ocorreu um erro ao carregar as próximas notificações. Toque em Repetir para tentar novamente.';

  @override
  String get repeat => 'Repetir';

  @override
  String get notificationErrorState => 'Não foi possível obter suas notificações';

  @override
  String get notificationErrorStateDescription => 'O sistema apresentou um erro interno e, por isso, não foi possível recuperar suas notificações. Aguarde alguns instantes e para repetir esta ação, toque em Tentar novamente.';

  @override
  String get notificationNotReceivedTitle => 'Você ainda não recebeu notificações.';

  @override
  String get notificationNotReceivedDescription => 'Quando você receber uma notificação, ela ficará disponível aqui para consulta.';

  @override
  String get latestNotifications => 'Últimas notificações';

  @override
  String get optionCancel => 'Cancelar';

  @override
  String get errorMarkNotificationAsRead => 'Ocorreu um erro ao marcar sua notificação como lida. Toque em Repetir para tentar novamente.';

  @override
  String get featureIsNotAvailableOffline => 'Esta funcionalidade não está disponível enquanto estiver offline. Verifique sua conexão.';

  @override
  String get selectItem => 'Selecionar';

  @override
  String get facialMsgStatusVeryBlurryImage => 'A foto está fora de foco ou o rosto está em movimento. Tente novamente.';

  @override
  String get facialMsgStatusMoreThanOneFaceFoundInTheImage => 'Somente um rosto deve aparecer na foto de cadastro.';

  @override
  String get facialMsgStatusFacesNotFoundInTheImage => 'Nenhum rosto foi encontrado com aparecimento suficiente na imagem. Tente novamente.';

  @override
  String get facialMsgStatusNonFrontalFace => 'Posicione o rosto de forma frontal e olhe diretamente para a câmera.';

  @override
  String get facialMsgStatusPoorQualityImage => 'A imagem tem baixa resolução, ruído ou iluminação inadequada.';

  @override
  String get facialMsgStatusVerySmallFaceInTheImage => 'Aproxime mais seu rosto da câmera.';

  @override
  String get facialMsgStatusFaceTooCloseToTheEdgeOfTheImage => 'Centralize o rosto na tela e tente novamente.';

  @override
  String get facialMsgStatusEvidenceOfFraud => 'A imagem não atendeu aos requisitos de autenticidade. Tente novamente.';

  @override
  String get facialMsgStatusIdsWithCloseImagesWereFound => 'O rosto parece semelhante a outra pessoa na base de dados. Evite duplicidade cadastral.';

  @override
  String get facialMsgStatusGlassesDetectedOrTooMuchEyeShadow => 'Remova os óculos ou ajuste a iluminação para evitar sombras nos olhos.';

  @override
  String get facialMsgStatusLowConfidenceFaceDetection => 'O sistema não conseguiu detectar um rosto com confiança suficiente. Tente novamente.';

  @override
  String get facialTitleStatusVeryBlurryImage => 'Imagem muito borrada';

  @override
  String get facialTitleStatusMoreThanOneFaceFoundInTheImage => 'Mais de um rosto detectado';

  @override
  String get facialTitleStatusFacesNotFoundInTheImage => 'Rosto não detectado';

  @override
  String get facialTitleStatusNonFrontalFace => 'Rosto fora de posição';

  @override
  String get facialTitleStatusPoorQualityImage => 'Imagem com baixa qualidade';

  @override
  String get facialTitleStatusVerySmallFaceInTheImage => 'Rosto pequeno na imagem';

  @override
  String get facialTitleStatusFaceTooCloseToTheEdgeOfTheImage => 'Rosto próximo à borda';

  @override
  String get facialTitleStatusEvidenceOfFraud => 'Possível fraude detectada';

  @override
  String get facialTitleStatusIdsWithCloseImagesWereFound => 'Similaridade com outros rostos';

  @override
  String get facialTitleStatusGlassesDetectedOrTooMuchEyeShadow => 'Óculos ou sombras nos olhos';

  @override
  String get facialTitleStatusLowConfidenceFaceDetection => 'Baixa confiança na face';

  @override
  String get privacy_police_change => 'Atualizamos a nossa política de privacidade';

  @override
  String get privacy_police_change_subtitle => 'Clique para visualizar ou consulte a qualquer momento no menu Configurações > Política de privacidade.';

  @override
  String get reRegisterApplicationKey => 'Consultar chave de aplicação';

  @override
  String get errorAuthenticatingApplicationKey => 'Erro ao autenticar chave de aplicação.';

  @override
  String get authenticating => 'Autenticando...';

  @override
  String get authenticationFailure => 'Falha de Autenticação';

  @override
  String get errorWhileAuthenticatingApplicationKey => 'Ocorreu um erro ao autenticar a chave de aplicação cadastrada neste dispositivo.';

  @override
  String get recognitionBlocked => 'Reconhecimento bloqueado, aguarde';

  @override
  String get secondsFullName => 'segundos';

  @override
  String get totalTimeSinceLastJourney => 'Tempo desde a última jornada';

  @override
  String get userNameScreenTitle => 'Entrar com credenciais';
}
