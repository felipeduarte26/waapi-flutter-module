import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get userNameScreenTitle => 'Iniciar sesión con credenciales';

  @override
  String get userNameScreenSubTitle => 'Iniciar sesión en la cuenta';

  @override
  String get loginBtnText => 'Entrar';

  @override
  String get tenantNotFoundErrorMessage => 'Tenant no encontrado. Por favor, inténtelo de nuevo.';

  @override
  String get genericErrorMessage => 'Hubo un problema. Por favor, inténtalo de nuevo.';

  @override
  String get unauthorizedErrorMessage => 'Correo electrónico o contraseña incorrectos. Por favor, inténtelo de nuevo.';

  @override
  String get ok => 'Ok';

  @override
  String get nextBtnText => 'Avanzar';

  @override
  String get passwordHint => 'Contraseña';

  @override
  String get usernameHint => 'Iniciar sesión';

  @override
  String get passwordRequiredMessage => 'Contraseña es obligatoria';

  @override
  String get usernameRequiredMessage => 'Correo electrónico es obligatorio';

  @override
  String get usernameInvalidMessage => 'Usuario desconocido';

  @override
  String get samlScreenTitle => 'Validación SAML';

  @override
  String get samlGreetingsMessage => '¡Hola!';

  @override
  String get samlWelcomeMessage => 'Su empresa utiliza capas de seguridad SAML para la autenticación, por lo que necesitamos validar externamente su contraseña e inicio de sesión..';

  @override
  String get samlValidateCredentialsBtnText => 'Validar credenciales';

  @override
  String get samlCheckboxMessage => 'No volver a mostrar este mensaje.';

  @override
  String get authenticationCode => 'Código de autenticación';

  @override
  String get insertAuthenticationCodeMessage => 'Introduzca el código de 6 dígitos';

  @override
  String get insertAuthenticationCodeMessageBody => 'El código se puede obtener de su aplicación de autenticación..';

  @override
  String get unauthorizedErrorMessageMfaCode => 'Código de autenticación incorrecto. Inténtalo de nuevo.';

  @override
  String get sendBtnText => 'Enviar';

  @override
  String get pasteCode => '¿Pegar código copiado?';

  @override
  String youWantToPasteCode(String code) {
    return '¿Quieres pegar el código $code?';
  }

  @override
  String get multifactorAuthentication => 'Autenticación multifactor';

  @override
  String get paste => 'Pegar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get invalidCode => 'El código introducido no es válido o ha caducado, inténtelo de nuevo..';

  @override
  String get firstAuthenticationMultifactor => 'Para su primer acceso, debe configurar su usuario para realizar la autenticación de dos factores. \n\n La configuración debe realizarse por correo electrónico.';

  @override
  String get redefineAuthenticationMultifactor => 'Su configuración MFA ha sido restablecida por el administrador, por favor configúrela de nuevo.';

  @override
  String get requestSendEmail => 'Solicitud enviada al correo electrónico.';

  @override
  String requestSendEmailMessage(String email) {
    return 'Hemos enviado un correo electrónico a $email. Por favor, compruebe su correo electrónico para continuar con el proceso.';
  }

  @override
  String get back => 'Volver';

  @override
  String get requestConfig => 'Solicitar configuración';

  @override
  String get genericErrorTitle => 'Error al cargar las informaciones.';

  @override
  String get genericErrorDescription => 'Inténtelo de nuevo en unos instantes.';

  @override
  String get recoveryPasswordBtnText => 'Recuperar contraseña';

  @override
  String get recoveryPasswordTitle => '¿Enviar un correo electrónico para restablecer la contraseña?';

  @override
  String get recoveryPasswordDescription => 'Si el usuario introducido está registrado con nosotros, le enviaremos un email con instrucciones sobre como recuperar su contraseña.';

  @override
  String get recoveryPasswordDescriptionNote => 'Si el usuario es LDAP o SAML, el cambio de la contraseña debe ser realizado en el proveedor de identidad utilizado.';

  @override
  String get note => 'Atención';

  @override
  String get recoveryPasswordSendEmailBtnText => 'Enviar correo electrónico';

  @override
  String get recoveryPasswordRecaptchaTitle => 'Por favor, Rellene el recaptcha para continuar';

  @override
  String get continueBtnText => 'Continuar';

  @override
  String get recoveryPasswordFinishedTitle => 'Solicitud de restablecimiento de contraseña enviada a su correo electrónico.';

  @override
  String get recoveryPasswordFinishedDescription => 'Compruebe su bandeja de entrada. Si eres un usuario registrado, te enviaremos un correo electrónico con instrucciones para recuperar tu contraseña.';

  @override
  String get backToBeginingBtnText => 'Volver al principio';

  @override
  String get help => 'Ayuda';

  @override
  String get helpTextLoginAuthenticationTitle => '¿Ha olvidado sus datos de acceso o tiene problemas para conectarse?';

  @override
  String get helpTextLoginAuthenticationDescriptio11 => 'Sus datos de acceso son los siguientes ';

  @override
  String get helpTextLoginAuthenticationDescriptio12 => 'usuario@dominio.com.br ';

  @override
  String get helpTextLoginAuthenticationDescriptio13 => '(introducido sin acentos).';

  @override
  String get helpTextLoginAuthenticationDescriptio2 => 'Si estás seguro de que las informaciones son correctas y sigues teniendo problemas para iniciar sesión en la aplicación, ';

  @override
  String get helpTextLoginAuthenticationDescriptio21 => 'consúltalo con el departamento de RRHH de tu empresa.';

  @override
  String get helpTextLoginAuthenticationDescriptio3 => 'Más informaciones en ';

  @override
  String get helpTextDocumentationPortal => 'Portal de documentación';

  @override
  String get helpTextLoginMfaDescriptioTitle => '¿Qué es una aplicación autenticadora??';

  @override
  String get helpTextLoginMfaDescriptioTitle2 => '¿Cómo averiguar la aplicación autenticadora utilizada para el inicio de sesión?';

  @override
  String get helpTextLoginMfaDescriptio1 => 'La aplicación de autenticación es una forma segura y conveniente de demostrar quién eres.';

  @override
  String get helpTextLoginMfaDescriptio2 => 'Genera códigos de verificación de dos factores en tu móvil.';

  @override
  String get helpTextLoginMfaDescriptio3 => 'Copie el código ofrecido en el autenticador e introdúzcalo aquí.';

  @override
  String get helpTextLoginMfaDescriptio4 => 'Consulte con RRHH de su empresa o vea más información en ';

  @override
  String get resetPasswordScreenTitle => 'Nueva contraseña';

  @override
  String get resetPasswordScreenSubtitle => 'Crear nueva contraseña';

  @override
  String get resetPasswordScreenDescription => 'Para continuar, debe crear una nueva contraseña:';

  @override
  String get newPasswordHint => 'Nueva contraseña';

  @override
  String get confirmNewPasswordHint => 'Confirme su nueva contraseña';

  @override
  String get resetPasswordBtnText => 'Restablecer contraseña';

  @override
  String passwordPolicyMinimumLength(int minimumLength, int maximumLength) {
    return 'Utilice los caracteres mínimos $minimumLength y máximos $maximumLength..';
  }

  @override
  String get passwordPolicyRequireNumbers => 'Su contraseña debe contener números.';

  @override
  String get passwordPolicyRequireLowerCase => 'Utilice al menos una letra minúscula.';

  @override
  String get passwordPolicyRequireUpperCase => 'Utilice al menos una mayúscula.';

  @override
  String get passwordPolicyRequireSpecialCharacters => 'Su contraseña debe contener caracteres especiales.';

  @override
  String get passwordPolicyPasswordConfirmPasswordMatches => 'La contraseña y la confirmación de contraseña deben coincidir.';

  @override
  String get usernameTextfieldHintText => 'usuario@dominio.com.br';

  @override
  String get loginWithKeyConfigurationKey => 'Configuración de la clave';

  @override
  String get loginWithKeyTitle => 'Insiera la clave de acceso para configuración del dispositivo';

  @override
  String get loginWithKeyHelperKey => 'Usted puede encontrar la clave en la plataforma';

  @override
  String get loginWithKeyHelperDomain => 'Usted puede encontrar el Dominio en la plataforma';

  @override
  String get loginWithKeyWrongDomain => 'Dominio no encontrado';

  @override
  String get loginWithKeyHelperSecret => 'Usted puede encontrar el secreto en la plataforma';

  @override
  String get loginWithKeyWrongKey => 'Clave de acceso incorrecta';

  @override
  String get loginWithKeyWrongSecret => 'Secreto incorrecto';

  @override
  String get loginWithKeyAccessKey => 'Clave de acceso';

  @override
  String get loginWithKeySecret => 'Secreto';

  @override
  String get loginWithKeyDomain => 'Dominio';

  @override
  String get loginWithKeyHelper => 'La información debe ser obtenida con el administrador del sistema de su empresa. Contacte com RRHH para saber más.';

  @override
  String get loginWithKeyDomainNotFound => 'Domínio no encontrado';

  @override
  String get loginWithKeyUnauthorizedErrorMessage => 'Clave o secreto incorrectos. Por favor, inténtelo nuevamente';

  @override
  String get loginWithKeyHelpTitle => '¿Necesita ayuda?';

  @override
  String get loginWithKeyUnauthorizedErrorHelper => 'Clave o secreto incorrectos';

  @override
  String get enableAccessWithBiometricsTitle => '¿Permitir el acceso por biometría?';

  @override
  String get enableAccessWithBiometricsContent => 'Cuando esta función está activada, usted necesita usar biometría para desbloquear la aplicación. Es posible alterar esta opción en Configuración.';

  @override
  String get yes => 'Sí';

  @override
  String get no => 'No';

  @override
  String get accountAccessWithBiometrics => 'Acceso a la cuenta por biometría';

  @override
  String get unregisteredSecurityMethods => 'Métodos de seguridad no registrados.';

  @override
  String get unregisteredSecurityMethodsContent => 'Para utilizar esta opción, por favor, active la biometría u otro método de seguridad en la configuración de su dispositivo. Regrese a la aplicación y active la opción en Configuración.';

  @override
  String get signWithBiometrics => 'Ingresar con biometría';

  @override
  String get optionExitDialogExit => 'Salir';

  @override
  String get unableToLogInOffline => 'No ha sido posible iniciar sesión. Verifique sus credenciales de acceso y su conexión a Internet.';

  @override
  String get errorTryingAuthenticateWithBiometrics => 'Error al intentar autenticar con biometría';

  @override
  String get checkInternetConnectionTryAgain => 'Verifique su conexión a internet y vuelva a intentarlo.';
}
