import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get userNameScreenTitle => 'Entrar com credenciais';

  @override
  String get userNameScreenSubTitle => 'Entrar na conta';

  @override
  String get loginBtnText => 'Entrar';

  @override
  String get tenantNotFoundErrorMessage => 'Tenant não encontrado. Por favor, tente novamente.';

  @override
  String get genericErrorMessage => 'Houve um problema. Por favor, tente novamente.';

  @override
  String get unauthorizedErrorMessage => 'Email ou senha incorretos. Por favor, tente novamente.';

  @override
  String get ok => 'Ok';

  @override
  String get nextBtnText => 'Avançar';

  @override
  String get passwordHint => 'Senha';

  @override
  String get usernameHint => 'Login';

  @override
  String get passwordRequiredMessage => 'Senha é obrigatória';

  @override
  String get usernameRequiredMessage => 'E-mail é obrigatório';

  @override
  String get usernameInvalidMessage => 'Usuário desconhecido';

  @override
  String get samlScreenTitle => 'Validação SAML';

  @override
  String get samlGreetingsMessage => 'Olá!';

  @override
  String get samlWelcomeMessage => 'Sua empresa utiliza camadas de segurança SAML para autenticação, por isso precisamos validar sua senha e login externamente.';

  @override
  String get samlValidateCredentialsBtnText => 'Validar credenciais';

  @override
  String get samlCheckboxMessage => 'Não mostrar esta mensagem novamente.';

  @override
  String get authenticationCode => 'Código de autenticação';

  @override
  String get insertAuthenticationCodeMessage => 'Insira o código de 6 dígitos';

  @override
  String get insertAuthenticationCodeMessageBody => 'O código pode ser obtido no seu aplicativo autenticador.';

  @override
  String get unauthorizedErrorMessageMfaCode => 'Codigo de autenticação incorreto. Por favor, tente novamente.';

  @override
  String get sendBtnText => 'Enviar';

  @override
  String get pasteCode => 'Colar código copiado?';

  @override
  String youWantToPasteCode(String code) {
    return 'Você deseja colar o código $code?';
  }

  @override
  String get multifactorAuthentication => 'Autenticação de multifator';

  @override
  String get paste => 'Colar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get invalidCode => 'Código inserido e inválido ou expirado. por favor, tente novamente.';

  @override
  String get firstAuthenticationMultifactor => 'Para seu primeiro acesso, é necessário configurar seu usuário para realizar a autenticação de duplo fator. \n\nA configuração deve ser feita via e-mail.';

  @override
  String get redefineAuthenticationMultifactor => 'Sua configuração de MFA foi redefinida pelo administrador, por favor configure-a novamente.';

  @override
  String get requestSendEmail => 'Solicitação envidada para o email.';

  @override
  String requestSendEmailMessage(String email) {
    return 'Enviamos um email para $email. Verifique seu e-mail para prosseguir com o processo.';
  }

  @override
  String get back => 'Voltar';

  @override
  String get requestConfig => 'Solicitar configuração';

  @override
  String get genericErrorTitle => 'Erro ao carregar as informações.';

  @override
  String get genericErrorDescription => 'Tente novamente em alguns instantes.';

  @override
  String get recoveryPasswordBtnText => 'Recuperar senha';

  @override
  String get recoveryPasswordTitle => 'Enviar e-mail para redefinição da senha?';

  @override
  String get recoveryPasswordDescription => 'Caso o usuário informado esteja cadastrado em nossa base, enviaremos um e-mail com as instruções para a recuperação da senha.';

  @override
  String get recoveryPasswordDescriptionNote => 'Se o usuário for LDAP ou SAML, a alteração da senha deve ser feita no provedor de identidade utilizado.';

  @override
  String get note => 'Atenção';

  @override
  String get recoveryPasswordSendEmailBtnText => 'Enviar e-mail';

  @override
  String get recoveryPasswordRecaptchaTitle => 'Por favor, preencha o recaptcha para continuar';

  @override
  String get continueBtnText => 'Continuar';

  @override
  String get recoveryPasswordFinishedTitle => 'Solicitação de redefinição de senha enviada para seu e-mail.';

  @override
  String get recoveryPasswordFinishedDescription => 'Confira sua caixa de entrada. Caso seja um usuário cadastrado, enviaremos um e-mail com as instruções para a recuperação da senha.';

  @override
  String get backToBeginingBtnText => 'Voltar ao início';

  @override
  String get help => 'Ajuda';

  @override
  String get helpTextLoginAuthenticationTitle => 'Esqueceu seu login ou está com problemas para entrar no aplicativo?';

  @override
  String get helpTextLoginAuthenticationDescriptio11 => 'Seu login é formado por ';

  @override
  String get helpTextLoginAuthenticationDescriptio12 => 'usuario@dominio.com.br ';

  @override
  String get helpTextLoginAuthenticationDescriptio13 => '(digitado sem acentos).';

  @override
  String get helpTextLoginAuthenticationDescriptio2 => 'Se você tem certeza de que as informações estão corretas e ainda estiver enfrentando problemas para entrar no aplicativo, ';

  @override
  String get helpTextLoginAuthenticationDescriptio21 => 'verifique com o RH da sua empresa.';

  @override
  String get helpTextLoginAuthenticationDescriptio3 => 'Veja mais informações no ';

  @override
  String get helpTextDocumentationPortal => 'Portal de documentação';

  @override
  String get helpTextLoginMfaDescriptioTitle => 'O que é um aplicativo autenticador?';

  @override
  String get helpTextLoginMfaDescriptioTitle2 => 'Como descobrir o aplicativo autenticador utilizado para o login?';

  @override
  String get helpTextLoginMfaDescriptio1 => 'O aplicativo autenticador é uma maneira segura e conveniente de provar quem você é.';

  @override
  String get helpTextLoginMfaDescriptio2 => 'Nele gera-se códigos de verificação em dois fatores no seu celular.';

  @override
  String get helpTextLoginMfaDescriptio3 => 'Copie o código oferecido no autenticador e informe aqui este código.';

  @override
  String get helpTextLoginMfaDescriptio4 => 'Verifique com o RH de sua empresa ou veja mais informações do ';

  @override
  String get resetPasswordScreenTitle => 'Nova senha';

  @override
  String get resetPasswordScreenSubtitle => 'Criar nova senha';

  @override
  String get resetPasswordScreenDescription => 'Para prosseguir, é preciso que você crie uma nova senha:';

  @override
  String get newPasswordHint => 'Nova senha';

  @override
  String get confirmNewPasswordHint => 'Confirme sua nova senha';

  @override
  String get resetPasswordBtnText => 'Redefinir senha';

  @override
  String passwordPolicyMinimumLength(int minimumLength, int maximumLength) {
    return 'Utilize no mínimo $minimumLength e no máximo $maximumLength caracteres.';
  }

  @override
  String get passwordPolicyRequireNumbers => 'Sua senha precisa conter números.';

  @override
  String get passwordPolicyRequireLowerCase => 'Utilize pelo menos uma letra minúscula.';

  @override
  String get passwordPolicyRequireUpperCase => 'Utilize pelo menos uma letra maiúscula.';

  @override
  String get passwordPolicyRequireSpecialCharacters => 'Sua senha precisa conter caracteres especiais.';

  @override
  String get passwordPolicyPasswordConfirmPasswordMatches => 'A senha e a confirmação da senha devem ser iguais.';

  @override
  String get usernameTextfieldHintText => 'usuario@dominio.com.br';

  @override
  String get loginWithKeyConfigurationKey => 'Configuração da chave';

  @override
  String get loginWithKeyTitle => 'Informe a chave de acesso para configuração do dispositivo';

  @override
  String get loginWithKeyHelperKey => 'Você pode encontrar a chave na plataforma';

  @override
  String get loginWithKeyHelperDomain => 'Você pode encontrar o domínio na plataforma';

  @override
  String get loginWithKeyWrongDomain => 'Domínio não encontrado';

  @override
  String get loginWithKeyHelperSecret => 'Você pode encontrar o segredo na plataforma';

  @override
  String get loginWithKeyWrongKey => 'Chave de acesso incorreta';

  @override
  String get loginWithKeyWrongSecret => 'Segredo incorreto';

  @override
  String get loginWithKeyAccessKey => 'Chave de acesso';

  @override
  String get loginWithKeySecret => 'Segredo';

  @override
  String get loginWithKeyDomain => 'Domínio';

  @override
  String get loginWithKeyHelper => 'As informações devem ser obtidas junto ao administrador do sistema de sua empresa, contate o RH para obter mais informações.';

  @override
  String get loginWithKeyDomainNotFound => 'Domínio não encontrado';

  @override
  String get loginWithKeyUnauthorizedErrorMessage => 'Chave ou segredo incorretos. Por favor, tente novamente.';

  @override
  String get loginWithKeyHelpTitle => 'Precisa de ajuda?';

  @override
  String get loginWithKeyUnauthorizedErrorHelper => 'Chave ou segredo incorretos';

  @override
  String get enableAccessWithBiometricsTitle => 'Habilitar acesso com biometria?';

  @override
  String get enableAccessWithBiometricsContent => 'Quando esta função estiver ativada, você precisará usar a biometria para desbloquear o aplicativo. Você poderá alterar essa opção em Configurações.';

  @override
  String get yes => 'Sim';

  @override
  String get no => 'Não';

  @override
  String get accountAccessWithBiometrics => 'Acesso à conta com biometria';

  @override
  String get unregisteredSecurityMethods => 'Métodos de segurança não cadastrados';

  @override
  String get unregisteredSecurityMethodsContent => 'Para utilizar esta opção, por favor, ative a biometria ou outro método de segurança nas configurações do seu dispositivo. Retorne ao aplicativo e habilite a opção em Configurações.';

  @override
  String get signWithBiometrics => 'Entrar com biometria';

  @override
  String get optionExitDialogExit => 'Sair';

  @override
  String get unableToLogInOffline => 'Não foi possível realizar o login. Verifique as credenciais de acesso e sua conexão com a internet.';

  @override
  String get errorTryingAuthenticateWithBiometrics => 'Erro ao tentar autenticar com biometria';

  @override
  String get checkInternetConnectionTryAgain => 'Verifique sua conexão com a internet e tente novamente.';
}
