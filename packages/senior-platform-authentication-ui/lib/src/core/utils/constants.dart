enum NetworkStatus {
  loading,
  idle,
}

enum ErrorType {
  tenantNotFound,
  domainNotFound,
  unknown,
  unauthorized,
  loginOfflineUnauthorized,
  biometricError,
  disableLoginOffline
}

enum AuthenticationStatus {
  unknown,
  authenticated,
  unauthenticated,
  offline,
}

enum AuthenticationFlow {
  unknown,
  password,
  mfa,
  saml,
  resetPassword,
  offline,
  biometryFlow
}

enum BiometryStatus {
  unknown,
  success,
  canceled,
  error,
  authenticating,
}

enum KeyAuthenticationFlow { unknown, domain, accessKey, secret, offline }

final RegExp emailRegex = RegExp(
  r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
);

///  return "•";
const bulletPoint = '\u2022';

const linkSeniorDocumentation = 'https://documentacao.senior.com.br/home.htm';

const String logoSeniorSvg = 'images/logosenior.svg';

const String generalErrorState = 'images/states/general_error_state.svg';
