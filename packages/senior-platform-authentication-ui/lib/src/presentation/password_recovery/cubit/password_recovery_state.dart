part of 'password_recovery_cubit.dart';

enum PasswordRecoveryStatus { initial, recaptcha, finished, error }

class PasswordRecoveryState extends Equatable {
  final PasswordRecoveryStatus passwordRecoveryStatus;
  final NetworkStatus networkStatus;
  final String recaptchaUrl;
  final String captcha;
  final String username;

  const PasswordRecoveryState({
    required this.passwordRecoveryStatus,
    required this.recaptchaUrl,
    required this.captcha,
    required this.networkStatus,
    required this.username,
  });

  factory PasswordRecoveryState.initial() {
    return const PasswordRecoveryState(
      passwordRecoveryStatus: PasswordRecoveryStatus.initial,
      recaptchaUrl: '',
      captcha: '',
      networkStatus: NetworkStatus.idle,
      username: '',
    );
  }

  PasswordRecoveryState copyWith({
    PasswordRecoveryStatus? passwordRecoveryStatus,
    String? recaptchaUrl,
    String? captcha,
    NetworkStatus? networkStatus,
    String? username,
  }) {
    return PasswordRecoveryState(
      passwordRecoveryStatus:
          passwordRecoveryStatus ?? this.passwordRecoveryStatus,
      recaptchaUrl: recaptchaUrl ?? this.recaptchaUrl,
      captcha: captcha ?? this.captcha,
      networkStatus: networkStatus ?? this.networkStatus,
      username: username ?? this.username,
    );
  }

  @override
  List<Object?> get props => [
        passwordRecoveryStatus,
        recaptchaUrl,
        captcha,
        networkStatus,
        username,
      ];
}
