import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get userNameScreenTitle => 'Log in with credentials';

  @override
  String get userNameScreenSubTitle => 'Log in';

  @override
  String get loginBtnText => 'Log in';

  @override
  String get tenantNotFoundErrorMessage => 'Tenant not found. Please try again.';

  @override
  String get genericErrorMessage => 'A problem has occurred. Please try again.';

  @override
  String get unauthorizedErrorMessage => 'Incorrect email or password. Please try again.';

  @override
  String get ok => 'OK';

  @override
  String get nextBtnText => 'Next';

  @override
  String get passwordHint => 'Password';

  @override
  String get usernameHint => 'Login';

  @override
  String get passwordRequiredMessage => 'A password is required';

  @override
  String get usernameRequiredMessage => 'An email is required';

  @override
  String get usernameInvalidMessage => 'Unknown user';

  @override
  String get samlScreenTitle => 'SAML validation';

  @override
  String get samlGreetingsMessage => 'Hello!';

  @override
  String get samlWelcomeMessage => 'Your company uses SAML security layers for authentication, so we need to externally validate your password and login.';

  @override
  String get samlValidateCredentialsBtnText => 'Validate credentials';

  @override
  String get samlCheckboxMessage => 'Do not show this message again.';

  @override
  String get authenticationCode => 'Authentication code';

  @override
  String get insertAuthenticationCodeMessage => 'Enter the 6-digit code';

  @override
  String get insertAuthenticationCodeMessageBody => 'The code can be obtained on your authenticator application.';

  @override
  String get unauthorizedErrorMessageMfaCode => 'Incorrect authentication code. Please try again.';

  @override
  String get sendBtnText => 'Send';

  @override
  String get pasteCode => 'Paste copied code?';

  @override
  String youWantToPasteCode(String code) {
    return 'Would you like to paste the code $code?';
  }

  @override
  String get multifactorAuthentication => 'Multifactor authentication';

  @override
  String get paste => 'Paste';

  @override
  String get cancel => 'Cancel';

  @override
  String get invalidCode => 'The entered code is invalid or expired. Please try again.';

  @override
  String get firstAuthenticationMultifactor => 'For your first access, you need to configure your user to perform two-factor authentication. The configuration must be done via email.';

  @override
  String get redefineAuthenticationMultifactor => 'Your MFA configuration has been reset by the administrator. Please set it up again.';

  @override
  String get requestSendEmail => 'Request sent to email.';

  @override
  String requestSendEmailMessage(String email) {
    return 'We have sent an email to $email. Please check your inbox to continue the process.';
  }

  @override
  String get back => 'Back';

  @override
  String get requestConfig => 'Request configuration';

  @override
  String get genericErrorTitle => 'Error while loading the information.';

  @override
  String get genericErrorDescription => 'Try again in a few moments.';

  @override
  String get recoveryPasswordBtnText => 'Recover password';

  @override
  String get recoveryPasswordTitle => 'Send email for password resetting?';

  @override
  String get recoveryPasswordDescription => 'If the provided user is registered in our database, we will send an email with instructions for password recovery.';

  @override
  String get recoveryPasswordDescriptionNote => 'If the user is LDAP or SAML, password changes must be made in the identity provider used.';

  @override
  String get note => 'Note';

  @override
  String get recoveryPasswordSendEmailBtnText => 'Send email';

  @override
  String get recoveryPasswordRecaptchaTitle => 'Please fill in the recaptcha to proceed';

  @override
  String get continueBtnText => 'Continue';

  @override
  String get recoveryPasswordFinishedTitle => 'Password reset request sent to your email.';

  @override
  String get recoveryPasswordFinishedDescription => 'Check your inbox. If you are a registered user, we will send you an email with instructions on how to recover your password.';

  @override
  String get backToBeginingBtnText => 'Home';

  @override
  String get help => 'Help';

  @override
  String get helpTextLoginAuthenticationTitle => 'Forgot your login or having trouble logging into the application?';

  @override
  String get helpTextLoginAuthenticationDescriptio11 => 'Your login consists of ';

  @override
  String get helpTextLoginAuthenticationDescriptio12 => 'user@domain.com.br ';

  @override
  String get helpTextLoginAuthenticationDescriptio13 => '(typed without graphic accents).';

  @override
  String get helpTextLoginAuthenticationDescriptio2 => 'If you are sure that the information is correct and you are still experiencing problems logging into the application, ';

  @override
  String get helpTextLoginAuthenticationDescriptio21 => 'check with your company\'s HR department';

  @override
  String get helpTextLoginAuthenticationDescriptio3 => 'See more information on the ';

  @override
  String get helpTextDocumentationPortal => 'Documentation Portal';

  @override
  String get helpTextLoginMfaDescriptioTitle => 'What is an authenticator application?';

  @override
  String get helpTextLoginMfaDescriptioTitle2 => 'How to find out the authenticator application used for login?';

  @override
  String get helpTextLoginMfaDescriptio1 => 'The authenticator application is a secure and convenient way to prove who you are.';

  @override
  String get helpTextLoginMfaDescriptio2 => 'It generates two-factor verification codes on your cell phone.';

  @override
  String get helpTextLoginMfaDescriptio3 => 'Copy the code offered in the authenticator and enter this code here.';

  @override
  String get helpTextLoginMfaDescriptio4 => 'Check with your company\'s HR or see more information on ';

  @override
  String get resetPasswordScreenTitle => 'New password';

  @override
  String get resetPasswordScreenSubtitle => 'Create new password';

  @override
  String get resetPasswordScreenDescription => 'To proceed, you must create a new password:';

  @override
  String get newPasswordHint => 'New password';

  @override
  String get confirmNewPasswordHint => 'Confirm your new password';

  @override
  String get resetPasswordBtnText => 'Redefine password';

  @override
  String passwordPolicyMinimumLength(int minimumLength, int maximumLength) {
    return 'Use at least $minimumLength and at most $maximumLength characters.';
  }

  @override
  String get passwordPolicyRequireNumbers => 'Your password must contain numbers.';

  @override
  String get passwordPolicyRequireLowerCase => 'Use at least one lowercase letter.';

  @override
  String get passwordPolicyRequireUpperCase => 'Use at least one uppercase letter.';

  @override
  String get passwordPolicyRequireSpecialCharacters => 'Your password must contain special characters.';

  @override
  String get passwordPolicyPasswordConfirmPasswordMatches => 'The password and the password confirmation must match.';

  @override
  String get usernameTextfieldHintText => 'user@domain.com.br';

  @override
  String get loginWithKeyConfigurationKey => 'Key configuration';

  @override
  String get loginWithKeyTitle => 'Enter the access key to configure the device';

  @override
  String get loginWithKeyHelperKey => 'You can find the key on the platform';

  @override
  String get loginWithKeyHelperDomain => 'You can find the domain on the platform';

  @override
  String get loginWithKeyWrongDomain => 'Domain not found';

  @override
  String get loginWithKeyHelperSecret => 'You can find the secret on the platform';

  @override
  String get loginWithKeyWrongKey => 'Incorrect access key';

  @override
  String get loginWithKeyWrongSecret => 'Segredo incorreto';

  @override
  String get loginWithKeyAccessKey => 'Access key';

  @override
  String get loginWithKeySecret => 'Secret';

  @override
  String get loginWithKeyDomain => 'Domain';

  @override
  String get loginWithKeyHelper => 'The information must be obtained from your company\'s system administrator, contact HR for more information.';

  @override
  String get loginWithKeyDomainNotFound => 'Domain not found';

  @override
  String get loginWithKeyUnauthorizedErrorMessage => 'Incorrect key or secret. Please try again';

  @override
  String get loginWithKeyHelpTitle => 'Need help?';

  @override
  String get loginWithKeyUnauthorizedErrorHelper => 'Incorrect key or secret';

  @override
  String get enableAccessWithBiometricsTitle => 'Enable access with biometrics';

  @override
  String get enableAccessWithBiometricsContent => 'Once this function is activated, biometrics will be required to unlock the application. This option can be changed in Settings';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get accountAccessWithBiometrics => 'Account access with biometrics';

  @override
  String get unregisteredSecurityMethods => 'Unregistered security methods.';

  @override
  String get unregisteredSecurityMethodsContent => 'To use this option, please enable biometrics or another security method in your device settings. Return to the app and enable the option in Settings.';

  @override
  String get signWithBiometrics => 'Sign in with biometrics';

  @override
  String get optionExitDialogExit => 'Sign Out';

  @override
  String get unableToLogInOffline => 'Unable to log in. Check your access credentials and your internet connection.';

  @override
  String get errorTryingAuthenticateWithBiometrics => 'Error trying to authenticate with biometrics';

  @override
  String get checkInternetConnectionTryAgain => 'Check your internet connection and try again.';
}
