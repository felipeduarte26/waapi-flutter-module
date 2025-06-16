import 'package:equatable/equatable.dart';
import 'package:senior_platform_authentication/senior_platform_authentication.dart';

class KeyAuthenticationData extends Equatable {
  final LoginWithKey? loginWithKey;
  final Token? token;

  const KeyAuthenticationData({
    required this.loginWithKey,
    required this.token,
  });

  KeyAuthenticationData copyWith({
    LoginWithKey? loginWithKey,
    Token? token,
  }) {
    return KeyAuthenticationData(
      loginWithKey: loginWithKey ?? this.loginWithKey,
      token: token ?? this.token,
    );
  }

  @override
  List<Object?> get props => [
        loginWithKey,
        token,
      ];
}
